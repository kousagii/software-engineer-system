require('dotenv').config();

const express = require('express');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const session = require('express-session');
const path = require('path');
const multer = require('multer');
const fs = require('fs');
const os = require('os');
const { exec } = require('child_process');
const cron = require('node-cron');

// Helper: get local LAN IPv4 address
function getLanIP() {
    const interfaces = os.networkInterfaces();
    for (const name of Object.keys(interfaces)) {
        for (const iface of interfaces[name]) {
            if (iface.family === 'IPv4' && !iface.internal) {
                return iface.address;
            }
        }
    }
    return 'localhost';
}

const backupDir = path.join(__dirname, 'backups');
if (!fs.existsSync(backupDir)) {
    fs.mkdirSync(backupDir, { recursive: true });
}

const uploadDir = path.join(__dirname, 'program_codes', 'uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

// Configure Multer storage
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, 'prod-' + uniqueSuffix + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, 'program_codes')));

app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: { secure: false }
}));

// Use a single connection with auto-reconnect to support the app's transaction style
// and prevent crash if DB wasn't fully ready at startup (important for portable)
let db;

function handleDisconnect() {
    db = mysql.createConnection({
        host: process.env.DB_HOST,
        port: process.env.DB_PORT || 3306,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME
    });

    db.connect((err) => {
        if (err) {
            console.error('❌ DATABASE CONNECTION ERROR:', err.message);
            console.error('   Make sure MariaDB is running on port', process.env.DB_PORT || 3306);
            setTimeout(handleDisconnect, 2000); // retry after 2 seconds
        } else {
            console.log('✅ Connected to MySQL Database!');
        }
    });

    db.on('error', (err) => {
        if (err.code === 'PROTOCOL_CONNECTION_LOST' || err.code === 'ECONNRESET') {
            console.error('❌ Database connection lost. Reconnecting...');
            handleDisconnect();
        } else {
            throw err;
        }
    });
}

handleDisconnect();


// Route to add a new user (Admin only)
app.post('/api/users', async (req, res) => {
    const { username, firstName, lastName, rawPassword, role, contactInfo } = req.body;

    try {
        const hashedPassword = await bcrypt.hash(rawPassword, 10);

        const sql = `INSERT INTO users (username, firstName, lastName, userPassword, role, contactInfo) VALUES (?, ?, ?, ?, ?, ?)`;

        db.query(sql, [username, firstName, lastName, hashedPassword, role, contactInfo], (err, result) => {
            if (err) {
                if (err.code === 'ER_DUP_ENTRY') {
                    return res.status(400).json({ error: "Username already exists. Please choose another." });
                }
                return res.status(500).json({ error: "Database error" });
            }
            res.status(201).json({ message: "User created successfully!", userID: result.insertId });
            const sessionUserID = req.session?.user?.id;
            if (sessionUserID) {
                db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Create User', ?)`,
                    [sessionUserID, `Created user: ${username} (${role})`]);
            }
        });
    } catch (error) {
        res.status(500).json({ error: "Hashing error" });
    }
});

app.post('/api/login', (req, res) => {

    const { username, password } = req.body;

    const sql = `SELECT * FROM users WHERE username = ?`;
    db.query(sql, [username], async (err, results) => {
        if (err || results.length === 0) {
            return res.status(401).json({ error: "Incorrect username or password." });
        }

        const user = results[0];

        const match = await bcrypt.compare(password, user.userPassword);

        if (!match) {
            return res.status(401).json({ error: "Incorrect username or password." });
        }

        const dbRoles = user.role.split(',').map(r => r.trim());
        let availableRoles = [];

        // Check for Admin
        if (dbRoles.includes('Admin')) availableRoles.push('Admin');

        // Check for Sales (handles 'SalesStaff' and legacy 'Sales')
        if (dbRoles.includes('SalesStaff') || dbRoles.includes('Sales')) {
            availableRoles.push('Sales');
        }

        // Check for Inventory (handles 'InventoryStaff' and legacy 'Inventory')
        if (dbRoles.includes('InventoryStaff') || dbRoles.includes('Inventory')) {
            availableRoles.push('Inventory');
        }

        // Fallback for old legacy 'Staff' role. 
        // Only grant both if the user isn't already explicitly identified as Sales or Inventory
        if (dbRoles.includes('Staff') && availableRoles.length === 0) {
            availableRoles.push('Sales');
            availableRoles.push('Inventory');
        }

        const initialRole = availableRoles.length > 0 ? availableRoles[0] : '';

        req.session.user = {
            id: user.userID,
            username: user.username,
            role: initialRole,
            availableRoles: availableRoles,
            dbRole: user.role,
            name: user.firstName
        };

        db.query(
            `INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Login', ?)`,
            [user.userID, `${user.firstName} ${user.lastName} logged in as ${initialRole}`]
        );

        res.json({ message: "Login successful", role: initialRole, availableRoles });
    });
});

// Route to check current session status
app.get('/api/auth-status', (req, res) => {
    if (req.session.user) {
        res.json({
            loggedIn: true,
            role: req.session.user.role,
            availableRoles: req.session.user.availableRoles || [],
            dbRole: req.session.user.dbRole,
            name: req.session.user.name
        });
    } else {
        res.json({ loggedIn: false });
    }
});

// Switch role without logging out
app.post('/api/switch-role', (req, res) => {
    if (!req.session || !req.session.user) {
        return res.status(401).json({ error: "Not logged in." });
    }

    const { role: newRole } = req.body;
    const { id, name, availableRoles, role: oldRole } = req.session.user;

    if (!availableRoles || !availableRoles.includes(newRole)) {
        return res.status(403).json({ error: "Access denied. You do not have permission for this role." });
    }

    // Update the session role
    req.session.user.role = newRole;

    db.query(
        `INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Login', ?)`,
        [id, `${name} switched from ${oldRole} view to ${newRole} view`]
    );

    res.json({ message: "Role switched successfully.", role: newRole });
});

app.post('/api/logout', (req, res) => {
    if (req.session && req.session.user) {
        db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Logout', ?)`,
            [req.session.user.id, `${req.session.user.name} logged out`]);
    }
    req.session.destroy();
    res.json({ message: "Logged out" });
});

app.get('/api/setup-test-admin', async (req, res) => {
    try {
        const hashedPassword = await bcrypt.hash('admin123', 10);

        const sql = `INSERT INTO users (username, firstName, lastName, userPassword, role, contactInfo) 
                     VALUES (?, ?, ?, ?, ?, ?)`;

        db.query(sql, ['admin', 'Test', 'Admin', hashedPassword, 'Admin', '09123456789'], (err, result) => {
            if (err) {
                if (err.code === 'ER_DUP_ENTRY') {
                    return res.send("<h1>Admin already exists! Go to the login page.</h1>");
                }
                console.error(err);
                return res.status(500).send("Database error");
            }
            res.send("<h1>Success! Test Admin created.</h1><p>You can now go to your login page and use:<br><b>Username:</b> admin<br><b>Password:</b> admin123</p>");
        });
    } catch (error) {
        res.status(500).send("Hashing error");
    }
});

const PORT = process.env.PORT || 3000;
const HOST = '0.0.0.0';

app.listen(PORT, HOST, () => {
    const lanIP = getLanIP();
    console.log(`✅ Server is running!`);
    console.log(`   Local:   http://localhost:${PORT}/log-in.html`);
    console.log(`   Network: http://${lanIP}:${PORT}/log-in.html`);
});

// GET route to fetch products for the inventory product list page
app.get('/api/products', (req, res) => {
    const sql = `SELECT * FROM product WHERE isActive = 1 ORDER BY productID DESC`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: "Failed to fetch products" });
        res.json(results);
    });
});

// GET today's income (profit)
app.get('/api/dashboard/today-income', (req, res) => {
    // using MySQL CURDATE() for accuracy
    const sql = `
        SELECT 
            SUM(si.quantity * COALESCE(si.unitPrice, p.price, 0)) AS totalSales,
            SUM(si.quantity * COALESCE(p.initialPrice, 0)) AS totalCost
        FROM sales_transaction st
        JOIN sales_item si ON st.transactionID = si.transactionID
        LEFT JOIN product p ON si.productID = p.productID
        WHERE DATE(st.transDateTime) = CURDATE()
          AND st.paymentStatus IN ('Paid', 'Partial', 'Exchanged')
    `;
    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching today income:', err);
            return res.status(500).json({ error: "Failed to fetch today income" });
        }
        const sales = parseFloat(results[0]?.totalSales) || 0;
        const cost = parseFloat(results[0]?.totalCost) || 0;
        const income = sales - cost;
        res.json({ income, sales, cost });
    });
});

// POST route to add a new product 
app.post('/api/products', upload.single('productImage'), (req, res) => {
    const { productName, barcode, category, stockQuantity, price, initialPrice, brand, productDescription, lowStockThreshold, variantOptions } = req.body;
    const imagePath = req.file ? `/uploads/${req.file.filename}` : null;

    const sql = `INSERT INTO product (productName, barcode, category, stockQuantity, price, initialPrice, brand, productDescription, imagePath, lowStockThreshold, variantOptions) 
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

    db.query(sql, [productName, barcode, category, stockQuantity, price, initialPrice || null, brand, productDescription, imagePath, parseInt(lowStockThreshold) || 10, variantOptions || null], (err, result) => {
        if (err) {
            console.error(err);
            if (err.code === 'ER_DUP_ENTRY') {
                return res.status(400).json({ error: "That barcode already exists!" });
            }
            return res.status(500).json({ error: "Database error" });
        }
        const sessionUserID = req.session?.user?.id;
        if (!sessionUserID) return res.status(401).json({ error: "Unauthorized" });

        db.query(`INSERT INTO inventory_record (userID, productID, actionType, quantityChange, inventoryDate, details) VALUES (?, ?, 'Add', ?, NOW(), ?)`,
            [sessionUserID, result.insertId, parseInt(stockQuantity) || 0, `Added product: ${productName}`]);
        res.status(201).json({ message: "Success!" });
    });
});

// POST route to add/update multiple products in bulk (variations)
app.post('/api/products/bulk', upload.single('productImage'), async (req, res) => {
    const sessionUserID = req.session?.user?.id;
    if (!sessionUserID) return res.status(401).json({ error: "Unauthorized" });

    let products = [];
    try {
        products = typeof req.body.products === 'string' ? JSON.parse(req.body.products) : req.body.products;
    } catch (e) {
        return res.status(400).json({ error: "Invalid products array format" });
    }

    if (!Array.isArray(products) || products.length === 0) {
        return res.status(400).json({ error: "No products to save" });
    }

    const imagePath = req.file ? `/uploads/${req.file.filename}` : null;

    try {
        await db.promise().query('START TRANSACTION');

        const insertSql = `INSERT INTO product (productName, barcode, category, stockQuantity, price, initialPrice, brand, productDescription, imagePath, lowStockThreshold, variantOptions) 
                           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

        const updateSql = `UPDATE product 
                           SET productName = ?, barcode = ?, category = ?, stockQuantity = ?, price = ?, initialPrice = ?, brand = ?, productDescription = ?, lowStockThreshold = ?, variantOptions = ? 
                           ${imagePath ? ', imagePath = ?' : ''}
                           WHERE productID = ?`;

        const deleteSql = `UPDATE product SET isActive = 0 WHERE productID = ?`;

        const logSql = `INSERT INTO inventory_record (userID, productID, actionType, quantityChange, inventoryDate, details) 
                        VALUES (?, ?, ?, ?, NOW(), ?)`;

        for (const item of products) {
            const { productID, productName, barcode, category, stockQuantity, price, initialPrice, brand, productDescription, lowStockThreshold, isDeleted, variantOptions } = item;

            if (isDeleted) {
                if (productID) {
                    await db.promise().query(deleteSql, [productID]);
                    await db.promise().query(logSql, [
                        sessionUserID,
                        productID,
                        'Archive',
                        0,
                        `Archived product variant: ${productName}`
                    ]);
                }
                continue;
            }

            if (productID) {
                // Fetch the current stock before updating (to calculate diff)
                const [oldRows] = await db.promise().query(`SELECT stockQuantity FROM product WHERE productID = ?`, [productID]);
                const oldStock = oldRows.length > 0 ? parseInt(oldRows[0].stockQuantity) : 0;
                const newStock = parseInt(stockQuantity) || 0;
                const stockDiff = newStock - oldStock;

                // Update existing product
                const updateParams = [
                    productName,
                    barcode,
                    category,
                    newStock,
                    parseFloat(price) || 0.00,
                    initialPrice ? parseFloat(initialPrice) : null,
                    brand || null,
                    productDescription || null,
                    parseInt(lowStockThreshold) || 10,
                    variantOptions || null
                ];
                if (imagePath) updateParams.push(imagePath);
                updateParams.push(productID);

                await db.promise().query(updateSql, updateParams);

                // Log edit
                await db.promise().query(logSql, [
                    sessionUserID,
                    productID,
                    'Edit',
                    0,
                    `Edited product variant: ${productName}`
                ]);

                // Log stock diff if adjusted
                if (stockDiff !== 0) {
                    await db.promise().query(logSql, [
                        sessionUserID,
                        productID,
                        'Stock Adjustment',
                        stockDiff,
                        `Stock adjusted for variant: ${productName} (${stockDiff > 0 ? '+' : ''}${stockDiff})`
                    ]);
                }
            } else {
                // Insert new product
                const [result] = await db.promise().query(insertSql, [
                    productName,
                    barcode,
                    category,
                    parseInt(stockQuantity) || 0,
                    parseFloat(price) || 0.00,
                    initialPrice ? parseFloat(initialPrice) : null,
                    brand || null,
                    productDescription || null,
                    imagePath,
                    parseInt(lowStockThreshold) || 10,
                    variantOptions || null
                ]);

                const newProductID = result.insertId;

                await db.promise().query(logSql, [
                    sessionUserID,
                    newProductID,
                    'Add',
                    parseInt(stockQuantity) || 0,
                    `Added product variant: ${productName}`
                ]);
            }
        }

        await db.promise().query('COMMIT');
        res.status(200).json({ message: "Success!" });
    } catch (err) {
        await db.promise().query('ROLLBACK');
        console.error("Bulk save error:", err);
        if (err.code === 'ER_DUP_ENTRY') {
            return res.status(400).json({ error: "One of the barcodes already exists! Please make sure all barcodes are unique." });
        }
        res.status(500).json({ error: "Database error during bulk save" });
    }
});

// PUT route to UPDATE an existing product 
app.put('/api/products/:id', upload.single('productImage'), async (req, res) => {
    const { id } = req.params;
    const { productName, category, stockQuantity, price, initialPrice, brand, productDescription, lowStockThreshold, stockAdjustReason, variantOptions } = req.body;

    const newImagePath = req.file ? `/uploads/${req.file.filename}` : null;

    let sql, params;

    if (newImagePath) {
        sql = `UPDATE product 
               SET productName = ?, category = ?, stockQuantity = ?, price = ?, initialPrice = ?, brand = ?, productDescription = ?, imagePath = ?, lowStockThreshold = ?, variantOptions = ? 
               WHERE productID = ?`;
        params = [productName, category, stockQuantity, price, initialPrice || null, brand, productDescription, newImagePath, parseInt(lowStockThreshold) || 10, variantOptions || null, id];
    } else {
        sql = `UPDATE product 
               SET productName = ?, category = ?, stockQuantity = ?, price = ?, initialPrice = ?, brand = ?, productDescription = ?, lowStockThreshold = ?, variantOptions = ? 
               WHERE productID = ?`;
        params = [productName, category, stockQuantity, price, initialPrice || null, brand, productDescription, parseInt(lowStockThreshold) || 10, variantOptions || null, id];
    }

    try {
        // Fetch the current stock before updating (to calculate diff)
        const [oldRows] = await db.promise().query(`SELECT stockQuantity FROM product WHERE productID = ?`, [id]);
        const oldStock = oldRows.length > 0 ? parseInt(oldRows[0].stockQuantity) : 0;
        const newStock = parseInt(stockQuantity) || 0;
        const stockDiff = newStock - oldStock;

        await db.promise().query(sql, params);

        const sessionUserID = req.session?.user?.id;
        if (!sessionUserID) return res.status(401).json({ error: "Unauthorized" });

        // Always log the general edit
        db.query(`INSERT INTO inventory_record (userID, productID, actionType, quantityChange, inventoryDate, details) VALUES (?, ?, 'Edit', 0, NOW(), ?)`,
            [sessionUserID, id, `Edited product: ${productName}`]);

        // If stock changed and a reason was provided, log a dedicated stock adjustment record
        if (stockDiff !== 0 && stockAdjustReason) {
            // actionType must match a valid ENUM value; map free-text reasons to 'Stock Adjustment'
            const validActionTypes = ['Damaged goods', 'Lost / Stolen', 'Inventory count correction', 'Stock Adjustment'];
            const safeActionType = validActionTypes.includes(stockAdjustReason) ? stockAdjustReason : 'Stock Adjustment';
            const adjustDetails = `Stock adjusted for: ${productName} (${stockDiff > 0 ? '+' : ''}${stockDiff}) — Reason: ${stockAdjustReason}`;
            db.query(
                `INSERT INTO inventory_record (userID, productID, actionType, quantityChange, inventoryDate, details) VALUES (?, ?, ?, ?, NOW(), ?)`,
                [sessionUserID, id, safeActionType, stockDiff, adjustDetails]
            );
        }

        res.status(200).json({ message: "Product updated successfully!" });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Failed to update product" });
    }
});

// PUT update a product's threshold directly
app.put('/api/products/:id/threshold', async (req, res) => {
    const { id } = req.params;
    const { lowStockThreshold } = req.body;

    if (lowStockThreshold === undefined) return res.status(400).json({ error: "Threshold is required" });

    try {
        await db.promise().query(
            'UPDATE product SET lowStockThreshold = ? WHERE productID = ?',
            [lowStockThreshold, id]
        );
        res.json({ message: "Threshold updated successfully" });

        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Edit Product', ?)`,
                [sessionUserID, `Updated Low Stock Threshold for Product ${id} to ${lowStockThreshold}`]);
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Failed to update threshold" });
    }
});

// DELETE route to REMOVE a product (soft delete - marks as inactive)
app.delete('/api/products/:id', (req, res) => {
    const { id } = req.params;

    const sql = `UPDATE product SET isActive = 0 WHERE productID = ?`;

    db.query(sql, [id], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to remove product from view" });
        }
        const sessionUserID = req.session?.user?.id;
        if (!sessionUserID) return res.status(401).json({ error: "Unauthorized" });

        db.query(`INSERT INTO inventory_record (userID, productID, actionType, quantityChange, inventoryDate, details) VALUES (?, ?, 'Archive', 0, NOW(), ?)`,
            [sessionUserID, id, `Archived product ID: ${id}`]);
        res.status(200).json({ message: "Product removed!" });
    });


});


// GET route to suggest a low stock threshold based on sales velocity & lead time
app.get('/api/products/:id/suggest-threshold', async (req, res) => {
    const { id } = req.params;
    const ANALYSIS_DAYS = 90; // Look at the last 90 days of data

    try {
        // 0. Find how many days the product has existed
        const [ageRows] = await db.promise().query(`
            SELECT DATEDIFF(NOW(), MIN(inventoryDate)) as ageDays
            FROM inventory_record
            WHERE productID = ?
        `, [id]);

        let productAge = parseInt(ageRows[0]?.ageDays) || 0;
        productAge = Math.max(1, productAge); // prevent division by zero

        // The divisor is either 90 or the product age, whichever is smaller
        const actualAnalysisDays = Math.min(ANALYSIS_DAYS, productAge);

        // 1. Get average daily sales for this product
        const [salesRows] = await db.promise().query(`
            SELECT COALESCE(SUM(si.quantity), 0) AS totalSold
            FROM sales_item si
            JOIN sales_transaction st ON si.transactionID = st.transactionID
            WHERE si.productID = ?
              AND st.transDateTime >= DATE_SUB(NOW(), INTERVAL ? DAY)
              AND st.paymentStatus = 'Paid'
        `, [id, actualAnalysisDays]);

        const totalSold = parseFloat(salesRows[0]?.totalSold) || 0;
        const avgDailySales = totalSold / actualAnalysisDays;

        // 2. Average lead time (computed from actual received purchase items)
        const [leadRows] = await db.promise().query(`
            SELECT AVG(leadTimeDays) AS avgLeadDays
            FROM purchase_item
            WHERE productID = ? AND leadTimeDays IS NOT NULL
        `, [id]);

        const avgLeadDays = parseFloat(leadRows[0]?.avgLeadDays) || 7; // default 7 days if no history
        const safetyDays = 7; // Owner-configurable buffer; hardcoded default
        const suggested = Math.ceil(avgDailySales * (avgLeadDays + safetyDays));

        // Build a human-readable reason
        let reason = '';
        if (totalSold === 0) {
            reason = `No sales data found in the last ${actualAnalysisDays} days. Using minimum baseline of ${Math.max(suggested, 5)} units.`;
        } else {
            reason = `Based on ~${avgDailySales.toFixed(1)} units/day sold (last ${actualAnalysisDays} days) × ${Math.round(avgLeadDays)} day lead time + ${safetyDays}-day safety buffer.`;
        }

        return res.json({
            suggested: Math.max(suggested, 5), // minimum of 5
            avgDailySales: parseFloat(avgDailySales.toFixed(2)),
            avgLeadDays: parseFloat(avgLeadDays.toFixed(1)),
            safetyDays,
            analysisDays: actualAnalysisDays,
            reason
        });

    } catch (err) {
        console.error('suggest-threshold error:', err);
        return res.status(500).json({ error: 'Failed to calculate suggestion' });
    }
});


// ARCHIVE MANAGEMENT


// GET archived (soft-deleted) users
app.get('/api/archive/users', (req, res) => {
    const sql = `SELECT userID, username, firstName, lastName, role, contactInfo FROM users WHERE isActive = 0 ORDER BY userID DESC`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: "Failed to fetch archived users" });
        res.json(results);
    });
});

// Restore an archived user
app.put('/api/archive/users/:id/restore', (req, res) => {
    const { id } = req.params;
    const sql = `UPDATE users SET isActive = 1 WHERE userID = ?`;
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).json({ error: "Failed to restore user" });
        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Restore User', ?)`,
                [sessionUserID, `Restored user ID: ${id}`]);
        }
        res.status(200).json({ message: "User restored!" });
    });
});

// GET archived (soft-deleted) products
app.get('/api/archive/products', (req, res) => {
    const sql = `SELECT * FROM product WHERE isActive = 0 ORDER BY productID DESC`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: "Failed to fetch archived products" });
        res.json(results);
    });
});

// GET archived purchase orders
app.get('/api/archive/orders', (req, res) => {
    const sql = `
        SELECT po.*, s.supplierName 
        FROM purchase_order po
        LEFT JOIN supplier s ON po.supplierID = s.supplierID
        WHERE po.isActive = 0 
        ORDER BY po.orderID DESC
    `;
    db.query(sql, (err, orders) => {
        if (err) return res.status(500).json({ error: "Failed to fetch archived orders" });
        if (!orders || orders.length === 0) return res.json([]);

        const ids = orders.map(o => o.orderID);
        const itemsSql = `
            SELECT pi.orderID, pi.productID, pi.quantity, pi.receivedQty, pi.defectiveQty, pi.unitCost, p.productName
            FROM purchase_item pi
            LEFT JOIN product p ON pi.productID = p.productID
            WHERE pi.orderID IN (?);
        `;

        db.query(itemsSql, [ids], (itErr, items) => {
            if (itErr) {
                console.error(itErr);
                return res.status(500).json({ error: "Failed to fetch archived order items" });
            }

            const itemsByOrder = {};
            (items || []).forEach(it => {
                if (!itemsByOrder[it.orderID]) itemsByOrder[it.orderID] = [];
                itemsByOrder[it.orderID].push({ productID: it.productID, productName: it.productName, qty: it.quantity, receivedQty: it.receivedQty, defectiveQty: it.defectiveQty, unitCost: it.unitCost });
            });

            const result = orders.map(o => {
                const orderDate = o.orderDateTime || o.orderDate || null;
                return {
                    ...o,
                    orderDate: orderDate,
                    items: itemsByOrder[o.orderID] || []
                };
            });

            res.json(result);
        });
    });
});

// Restore an archived purchase order
app.put('/api/archive/orders/:id/restore', (req, res) => {
    const { id } = req.params;
    const sql = `UPDATE purchase_order SET isActive = 1 WHERE orderID = ?`;
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).json({ error: "Failed to restore order" });
        res.status(200).json({ message: "Order restored!" });
    });
});

// GET archived (soft-deleted) suppliers
app.get('/api/archive/suppliers', (req, res) => {
    db.query("SET SESSION group_concat_max_len = 1000000", (err) => {
        if (err) console.error("Failed to set group_concat_max_len", err);
        const query = `
            SELECT 
                s.supplierID,
                s.supplierName,
                s.contactNumber,
                s.email,
                s.address,
                s.termsOfPayment,
                GROUP_CONCAT(sp.productID) AS productIDs,
                GROUP_CONCAT(p.productName) AS productNames
            FROM supplier s
            LEFT JOIN supplier_products sp ON s.supplierID = sp.supplierID
            LEFT JOIN product p ON sp.productID = p.productID
            WHERE s.isActive = 0
            GROUP BY s.supplierID;
        `;
        db.query(query, (err, results) => {
            if (err) return res.status(500).json({ error: err.message });
            res.json(results);
        });
    });
});

// Restore an archived product
app.put('/api/archive/products/:id/restore', (req, res) => {
    const { id } = req.params;
    const sql = `UPDATE product SET isActive = 1 WHERE productID = ?`;
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).json({ error: "Failed to restore product" });
        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO inventory_record (userID, productID, actionType, quantityChange, inventoryDate, details) VALUES (?, ?, 'Edit', 0, NOW(), ?)`,
                [sessionUserID, id, `Restored product ID: ${id}`]);
        }
        res.status(200).json({ message: "Product restored!" });
    });
});

// Restore an archived supplier
app.put('/api/archive/suppliers/:id/restore', (req, res) => {
    const { id } = req.params;
    const sql = `UPDATE supplier SET isActive = 1 WHERE supplierID = ?`;
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).json({ error: "Failed to restore supplier" });
        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO inventory_record (userID, supplierID, actionType, quantityChange, inventoryDate, details) VALUES (?, ?, 'Supplier Edit', 0, NOW(), ?)`,
                [sessionUserID, id, `Restored supplier ID: ${id}`]);
        }
        res.status(200).json({ message: "Supplier restored!" });
    });
});


// SUPPLIER MANAGEMENT 

// GET route to fetch all suppliers with their associated products
app.get('/api/suppliers', (req, res) => {
    db.query("SET SESSION group_concat_max_len = 1000000", (err) => {
        if (err) console.error("Failed to set group_concat_max_len", err);
        const query = `
            SELECT 
                s.supplierID,
                s.supplierName,
                s.contactNumber,
                s.email,
                s.address,
                s.termsOfPayment,
                GROUP_CONCAT(sp.productID) AS productIDs,
                GROUP_CONCAT(p.productName) AS productNames
            FROM supplier s
            LEFT JOIN supplier_products sp ON s.supplierID = sp.supplierID
            LEFT JOIN product p ON sp.productID = p.productID
            WHERE s.isActive = 1
            GROUP BY s.supplierID;
        `;

        db.query(query, (err, results) => {
            if (err) return res.status(500).json({ error: err.message });
            res.json(results);
        });
    });
});

// POST route to add a new supplier
app.post('/api/suppliers', (req, res) => {
    const { supplierName, contactNumber, email, address, termsOfPayment, productIDs } = req.body;

    const sql = `INSERT INTO supplier (supplierName, contactNumber, email, address, termsOfPayment) VALUES (?, ?, ?, ?, ?)`;

    db.query(sql, [supplierName, contactNumber, email, address, termsOfPayment || 'COD'], (err, result) => {
        if (err) return res.status(500).json({ error: "Database error" });

        const newSupplierId = result.insertId;
        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO inventory_record (userID, supplierID, actionType, quantityChange, inventoryDate, details) VALUES (?, ?, 'Supplier Add', 0, NOW(), ?)`,
                [sessionUserID, newSupplierId, `Added supplier: ${supplierName}`]);
        }

        if (productIDs && productIDs.length > 0) {
            const spSql = `INSERT INTO supplier_products (supplierID, productID) VALUES ?`;
            const values = productIDs.map(pid => [newSupplierId, pid]);

            db.query(spSql, [values], (spErr) => {
                if (spErr) console.error(spErr);
                res.status(201).json({ message: "Supplier created successfully!" });
            });
        } else {
            res.status(201).json({ message: "Supplier created successfully!" });
        }
    });
});

// PUT route to UPDATE an existing supplier
app.put('/api/suppliers/:id', (req, res) => {
    const { id } = req.params;
    const { supplierName, contactNumber, email, address, termsOfPayment, productIDs } = req.body;

    const sql = `UPDATE supplier SET supplierName = ?, contactNumber = ?, email = ?, address = ?, termsOfPayment = ? WHERE supplierID = ?`;

    db.query(sql, [supplierName, contactNumber, email, address, termsOfPayment || 'COD', id], (err, result) => {
        if (err) return res.status(500).json({ error: "Failed to update supplier" });
        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO inventory_record (userID, supplierID, actionType, quantityChange, inventoryDate, details) VALUES (?, ?, 'Supplier Edit', 0, NOW(), ?)`,
                [sessionUserID, id, `Edited supplier: ${supplierName}`]);
        }

        db.query(`DELETE FROM supplier_products WHERE supplierID = ?`, [id], (delErr) => {
            if (delErr) console.error(delErr);

            if (productIDs && productIDs.length > 0) {
                const spSql = `INSERT INTO supplier_products (supplierID, productID) VALUES ?`;
                const values = productIDs.map(pid => [id, pid]);

                db.query(spSql, [values], (spErr) => {
                    res.status(200).json({ message: "Supplier updated successfully!" });
                });
            } else {
                res.status(200).json({ message: "Supplier updated successfully!" });
            }
        });
    });
});

// DELETE route to REMOVE a supplier (soft delete - marks as inactive)
app.delete('/api/suppliers/:id', (req, res) => {
    const { id } = req.params;
    const sql = `UPDATE supplier SET isActive = 0 WHERE supplierID = ?`;
    db.query(sql, [id], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to remove supplier from view" });
        }
        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO inventory_record (userID, supplierID, actionType, quantityChange, inventoryDate, details) VALUES (?, ?, 'Supplier Archive', 0, NOW(), ?)`,
                [sessionUserID, id, `Archived supplier ID: ${id}`]);
        }
        res.status(200).json({ message: "Supplier removed!" });
    });
});


// PURCHASE ORDER / ORDERS MANAGEMENT

// GET all orders with their items
app.get('/api/orders', (req, res) => {
    const sql = `
        SELECT po.*, s.supplierName, s.termsOfPayment AS supplierTerms
        FROM purchase_order po
        LEFT JOIN supplier s ON po.supplierID = s.supplierID
        WHERE po.isActive = 1
        ORDER BY po.orderID DESC
    `;

    db.query(sql, (err, orders) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to fetch orders" });
        }

        if (!orders || orders.length === 0) return res.json([]);

        const ids = orders.map(o => o.orderID);
        const itemsSql = `
            SELECT pi.orderID, pi.productID, pi.quantity, pi.receivedQty, pi.defectiveQty, pi.unitCost, p.productName
            FROM purchase_item pi
            LEFT JOIN product p ON pi.productID = p.productID
            WHERE pi.orderID IN (?);
        `;

        db.query(itemsSql, [ids], (itErr, items) => {
            if (itErr) {
                console.error(itErr);
                return res.status(500).json({ error: "Failed to fetch order items" });
            }

            const itemsByOrder = {};
            (items || []).forEach(it => {
                if (!itemsByOrder[it.orderID]) itemsByOrder[it.orderID] = [];
                itemsByOrder[it.orderID].push({ productID: it.productID, productName: it.productName, qty: it.quantity, receivedQty: it.receivedQty, defectiveQty: it.defectiveQty, unitCost: it.unitCost });
            });

            const result = orders.map(o => {
                const orderDate = o.orderDateTime || o.orderDate || null;
                const terms = o.termsOfPayment || o.supplierTerms || 'COD';

                // Calculate due date based on receive date and terms. 
                // Only start countdown if status is Partially Completed or Completed
                let dueDateStr = o.dueDate ? new Date(o.dueDate).toISOString() : 'N/A';
                if (dueDateStr === 'N/A' && (o.status === 'Partially Completed' || o.status === 'Completed') && (o.receiveDate || orderDate)) {
                    let days = 0;
                    if (terms.includes('Days')) {
                        const match = terms.match(/(\d+)\s*Days/i);
                        if (match) days = parseInt(match[1]);
                    } else if (terms.match(/Net\s*(\d+)/i)) {
                        const match = terms.match(/Net\s*(\d+)/i);
                        if (match) days = parseInt(match[1]);
                    }
                    const dDate = new Date(o.receiveDate || orderDate);
                    dDate.setDate(dDate.getDate() + days);
                    dueDateStr = dDate.toISOString();
                }

                return {
                    orderID: o.orderID,
                    userID: o.userID,
                    supplierID: o.supplierID,
                    supplierName: o.supplierName,
                    orderDate: orderDate,
                    dueDate: dueDateStr,
                    status: o.status,
                    paymentStatus: o.paymentStatus || 'Pending',
                    paymentMethod: o.paymentMethod || null,
                    paymentReference: o.paymentReference || null,
                    paymentDate: o.paymentDate || null,
                    amountPaid: o.amountPaid || null,
                    termsOfPayment: terms,
                    contact: o.contact || null,
                    shipmentInfo: o.shipmentInfo || null,
                    items: itemsByOrder[o.orderID] || []
                };
            });

            res.json(result);
        });
    });
});

// POST create a new order 
app.post('/api/orders', (req, res) => {
    const userID = req.session && req.session.user ? req.session.user.id : null;
    if (!userID) return res.status(401).json({ error: "Please log in to create an order" });
    const { supplierID, contact, shipmentInfo, status, paymentStatus, items, shipToAddress, termsOfPayment } = req.body;

    if (!supplierID) return res.status(400).json({ error: "supplierID is required" });

    const orderDateTime = new Date();
    const insertSql = `INSERT INTO purchase_order (userID, supplierID, orderDateTime, status, contact, shipmentInfo, paymentStatus, shipToAddress, termsOfPayment) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`;

    db.query(insertSql, [userID, supplierID, orderDateTime, status || 'To Order', contact || null, shipmentInfo || null, paymentStatus || 'Pending', shipToAddress || null, termsOfPayment || null], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to create order" });
        }

        const orderID = result.insertId;

        if (!items || items.length === 0) return res.status(201).json({ message: "Order created", orderID });

        const productIds = items.map(i => i.productID).filter(Boolean);
        if (productIds.length === 0) return res.status(201).json({ message: "Order created", orderID });

        const placeholders = productIds.map(() => '?').join(',');

        const checkSql = `SELECT productID FROM supplier_products WHERE supplierID = ? AND productID IN (${placeholders})`;
        db.query(checkSql, [supplierID, ...productIds], (checkErr, allowedRows) => {
            if (checkErr) { console.error(checkErr); return res.status(500).json({ error: "Failed to validate supplier products" }); }
            const allowedIds = (allowedRows || []).map(r => String(r.productID));
            const invalid = productIds.map(String).filter(id => !allowedIds.includes(id));
            if (invalid.length > 0) {
                return res.status(400).json({ error: `Products ${invalid.join(', ')} are not supplied by supplier ${supplierID}` });
            }

            const priceSql = `SELECT productID, price FROM product WHERE productID IN (${placeholders})`;
            db.query(priceSql, productIds, (pErr, prices) => {
                if (pErr) {
                    console.error(pErr);
                    return res.status(500).json({ error: "Failed to fetch product prices" });
                }

                const priceMap = {};
                (prices || []).forEach(p => priceMap[p.productID] = p.price || 0);

                const values = items.map(it => [orderID, it.productID, it.qty || it.quantity || 0, priceMap[it.productID] || 0]);
                const insertItemsSql = `INSERT INTO purchase_item (orderID, productID, quantity, unitCost) VALUES ?`;

                db.query(insertItemsSql, [values], (insErr) => {
                    if (insErr) {
                        console.error(insErr);
                        return res.status(500).json({ error: "Failed to insert order items" });
                    }
                    res.status(201).json({ message: "Order created", orderID });
                    const sessionUserID = req.session?.user?.id;
                    if (sessionUserID) {
                        db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Create Order', ?)`,
                            [sessionUserID, `Created PO-${orderID} for supplier ID: ${supplierID}`]);
                    }
                });
            });
        });
    });
});

// PUT update an existing order (replace items)
app.put('/api/orders/:id', async (req, res) => {
    const { id } = req.params;
    const { supplierID, contact, shipmentInfo, status, items, shipToAddress, termsOfPayment } = req.body;

    try {

        const [existingOrders] = await db.promise().query(
            `SELECT status, paymentStatus FROM purchase_order WHERE orderID = ?`,
            [id]
        );

        if (existingOrders.length === 0) {
            return res.status(404).json({
                error: "Order not found"
            });
        }

        const oldStatus = existingOrders[0].status;
        const oldPaymentStatus = existingOrders[0].paymentStatus;

        if (oldStatus === 'Completed' || oldStatus === 'Partially Completed') {
            return res.status(400).json({
                error: "Orders that are completed or partially completed cannot be edited directly. Please use the receiving module."
            });
        }

        if (!supplierID) {
            return res.status(400).json({
                error: "Supplier is required."
            });
        }

        await db.promise().query('START TRANSACTION');

        const updateOrderSql = `
            UPDATE purchase_order
            SET supplierID = ?,
                status = ?,
                contact = ?,
                shipmentInfo = ?,
                paymentStatus = ?,
                shipToAddress = ?,
                termsOfPayment = ?
            WHERE orderID = ?
        `;

        await db.promise().query(updateOrderSql, [
            supplierID,
            status || 'To Order',
            contact || null,
            shipmentInfo || null,
            req.body.paymentStatus || oldPaymentStatus || 'Pending',
            shipToAddress || null,
            termsOfPayment || null,
            id
        ]);

        await db.promise().query(
            `DELETE FROM purchase_item WHERE orderID = ?`,
            [id]
        );

        if (items && items.length > 0) {

            const productIds = items.map(i => i.productID);

            const placeholders = productIds.map(() => '?').join(',');

            const validateSql = `
                SELECT productID
                FROM supplier_products
                WHERE supplierID = ?
                AND productID IN (${placeholders})
            `;

            const [allowedRows] = await db.promise().query(
                validateSql,
                [supplierID, ...productIds]
            );

            const allowedIds = allowedRows.map(r => String(r.productID));

            const invalidProducts = productIds.filter(
                pid => !allowedIds.includes(String(pid))
            );

            if (invalidProducts.length > 0) {

                await db.promise().query('ROLLBACK');

                return res.status(400).json({
                    error: `Products ${invalidProducts.join(', ')} are not supplied by this supplier.`
                });
            }

            const [prices] = await db.promise().query(
                `SELECT productID, price
                 FROM product
                 WHERE productID IN (${placeholders})`,
                productIds
            );

            const priceMap = {};

            prices.forEach(p => {
                priceMap[p.productID] = p.price || 0;
            });

            const values = items.map(it => [
                id,
                it.productID,
                it.qty || it.quantity || 0,
                priceMap[it.productID] || 0
            ]);

            const insertItemsSql = `
                INSERT INTO purchase_item
                (orderID, productID, quantity, unitCost)
                VALUES ?
            `;

            await db.promise().query(insertItemsSql, [values]);

            // We don't update stock here anymore because stock is updated via the receiving endpoint.
        }
        await db.promise().query('COMMIT');
        res.json({
            message: "Order updated successfully."
        });
    } catch (error) {
        console.error('PUT ORDER ERROR:', error);
        await db.promise().query('ROLLBACK');
        res.status(500).json({
            error: "Failed to update order."
        });
    }
});

// PUT receive/complete an order
app.put('/api/orders/:id/receive', async (req, res) => {
    const { id } = req.params;
    const { status, items } = req.body;

    try {
        const [existingOrders] = await db.promise().query(
            `SELECT status, orderDateTime FROM purchase_order WHERE orderID = ?`,
            [id]
        );

        if (existingOrders.length === 0) {
            return res.status(404).json({ error: "Order not found" });
        }

        const oldStatus = existingOrders[0].status;
        const orderDateTime = existingOrders[0].orderDateTime;
        if (oldStatus === 'Completed') {
            return res.status(400).json({ error: "Completed orders cannot be modified." });
        }

        await db.promise().query('START TRANSACTION');

        await db.promise().query(`UPDATE purchase_order SET status = ? WHERE orderID = ?`, [status, id]);

        for (const item of items) {
            const [oldItems] = await db.promise().query(`SELECT receivedQty FROM purchase_item WHERE orderID = ? AND productID = ?`, [id, item.productID]);
            const oldReceived = oldItems.length > 0 ? oldItems[0].receivedQty : 0;
            const newReceived = parseInt(item.receivedQty) || 0;
            const defective = parseInt(item.defectiveQty) || 0;
            const stockDiff = newReceived - oldReceived;

            let leadTimeSql = "";
            let params = [newReceived, defective];
            if (stockDiff > 0) {
                // Set lead time on first reception (DATEDIFF of NOW and orderDateTime)
                leadTimeSql = `, leadTimeDays = COALESCE(leadTimeDays, DATEDIFF(NOW(), ?))`;
                params.push(orderDateTime);
            }
            params.push(id, item.productID);

            await db.promise().query(`UPDATE purchase_item SET receivedQty = ?, defectiveQty = ? ${leadTimeSql} WHERE orderID = ? AND productID = ?`, params);

            if (stockDiff > 0) {
                await db.promise().query(`UPDATE product SET stockQuantity = stockQuantity + ? WHERE productID = ?`, [stockDiff, item.productID]);
            } else if (stockDiff < 0) {
                await db.promise().query(`UPDATE product SET stockQuantity = stockQuantity - ? WHERE productID = ?`, [-stockDiff, item.productID]);
            }
        }

        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Receive Order', ?)`,
                [sessionUserID, `Received/Updated PO-${id} (Status: ${status})`]);
        }

        await db.promise().query('COMMIT');
        res.json({ message: "Order receiving updated successfully." });
    } catch (error) {
        await db.promise().query('ROLLBACK');
        console.error('RECEIVE ORDER ERROR:', error);
        res.status(500).json({ error: "Failed to receive order." });
    }
});

// PUT update payment status of an order
app.put('/api/orders/:id/payment', async (req, res) => {
    const { id } = req.params;
    const { paymentMethod, paymentReference, paymentDate, amountPaid } = req.body;

    try {
        const [itemRows] = await db.promise().query(
            `SELECT COALESCE(SUM(quantity * unitCost), 0) AS totalAmount FROM purchase_item WHERE orderID = ?`,
            [id]
        );
        const totalAmount = parseFloat(itemRows[0]?.totalAmount || 0);

        const [poRows] = await db.promise().query(
            `SELECT amountPaid FROM purchase_order WHERE orderID = ?`,
            [id]
        );
        const currentPaid = parseFloat(poRows[0]?.amountPaid || 0);
        const newPaid = currentPaid + parseFloat(amountPaid || 0);

        let newStatus = 'Pending';
        if (newPaid >= totalAmount - 0.01 && totalAmount > 0) {
            newStatus = 'Completed';
        } else if (newPaid > 0) {
            newStatus = 'Partially Paid';
        }

        await db.promise().query(
            `UPDATE purchase_order SET paymentStatus = ?, paymentMethod = ?, paymentReference = ?, paymentDate = ?, amountPaid = ? WHERE orderID = ?`,
            [newStatus, paymentMethod, paymentReference || null, paymentDate || new Date(), newPaid, id]
        );
        res.json({ message: "Payment processed successfully", newStatus });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Failed to process payment" });
    }
});

// DELETE an order (soft delete - marks as inactive)
app.delete('/api/orders/:id', (req, res) => {
    const { id } = req.params;
    const sql = `UPDATE purchase_order SET isActive = 0 WHERE orderID = ?`;
    db.query(sql, [id], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to archive order" });
        }
        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Archive Order', ?)`,
                [sessionUserID, `Archived order ID: ${id}`]);
        }
        res.json({ message: "Order archived" });
    });
});


// GET auto-reorder/preview: Fetch low-stock items and their available suppliers
app.get('/api/auto-reorder/preview', async (req, res) => {
    const { productID } = req.query;
    try {
        let whereClause = `WHERE p.isActive = 1 AND s.isActive = 1 AND p.stockQuantity <= p.lowStockThreshold`;
        const params = [];
        if (productID) {
            whereClause += ` AND p.productID = ?`;
            params.push(productID);
        }

        const [rows] = await db.promise().query(`
            SELECT
                p.productID,
                p.productName,
                p.stockQuantity,
                p.lowStockThreshold,
                p.price,
                s.supplierID,
                s.supplierName
            FROM product p
            JOIN supplier_products sp ON p.productID = sp.productID
            JOIN supplier s ON sp.supplierID = s.supplierID
            ${whereClause}
        `, params);

        // Group by product
        const productsMap = {};
        rows.forEach(row => {
            if (!productsMap[row.productID]) {
                productsMap[row.productID] = {
                    productID: row.productID,
                    productName: row.productName,
                    stockQuantity: row.stockQuantity,
                    lowStockThreshold: parseInt(row.lowStockThreshold) || 10,
                    price: parseFloat(row.price) || 0,
                    suppliers: []
                };
            }
            productsMap[row.productID].suppliers.push({
                supplierID: row.supplierID,
                supplierName: row.supplierName
            });
        });

        res.json(Object.values(productsMap));
    } catch (error) {
        console.error('PREVIEW ERROR:', error);
        res.status(500).json({ error: 'Failed to fetch reorder preview. ' + error.message });
    }
});

// POST auto-reorder: Create To Order purchase orders based on explicit user selections
app.post('/api/auto-reorder', async (req, res) => {
    const userID = req.session && req.session.user ? req.session.user.id : null;
    if (!userID) return res.status(401).json({ error: 'Please log in to create orders.' });

    const { items } = req.body;
    if (!items || !Array.isArray(items) || items.length === 0) {
        return res.status(400).json({ error: 'No items provided for reorder.' });
    }

    try {
        // Group items by supplierID
        const bySupplier = {};
        for (const item of items) {
            if (!bySupplier[item.supplierID]) {
                bySupplier[item.supplierID] = { supplierName: item.supplierName, items: [] };
            }
            bySupplier[item.supplierID].items.push({
                productID: item.productID,
                productName: item.productName,
                qty: Math.max(parseInt(item.quantity) || 1, 1),
                price: parseFloat(item.price) || 0
            });
        }

        const orderDateTime = new Date();
        let ordersCreated = 0;
        const createdOrders = [];

        for (const [suppID, data] of Object.entries(bySupplier)) {
            const [orderResult] = await db.promise().query(
                `INSERT INTO purchase_order (userID, supplierID, orderDateTime, status, contact, shipmentInfo, shipToAddress) VALUES (?, ?, ?, 'To Order', NULL, NULL, '#2 National Road, Brgy. San Juan,\\nTaytay, Rizal, Philippines\\nPhone: 8658-7984 / 8658-6802')`,
                [userID, suppID, orderDateTime]
            );
            const orderID = orderResult.insertId;

            const values = data.items.map(it => [orderID, it.productID, it.qty, it.price]);
            await db.promise().query(`INSERT INTO purchase_item (orderID, productID, quantity, unitCost) VALUES ?`, [values]);

            await db.promise().query(
                `INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Auto Reorder', ?)`,
                [userID, `Auto-created PO-${orderID} for ${data.supplierName} (${data.items.length} item(s))`]
            );

            ordersCreated++;
            createdOrders.push({
                orderID,
                supplierName: data.supplierName,
                itemCount: data.items.length,
                items: data.items.map(i => i.productName)
            });
        }

        res.json({
            message: `Auto reorder complete! ${ordersCreated} purchase order(s) created.`,
            ordersCreated,
            orders: createdOrders
        });

    } catch (error) {
        console.error('AUTO REORDER ERROR:', error);
        res.status(500).json({ error: 'Failed to create auto reorder. ' + error.message });
    }
});

// USER MANAGEMENT 

// GET route to fetch all users (excluding passwords for security)
app.get('/api/users', (req, res) => {
    const sql = `SELECT userID, username, firstName, lastName, role, contactInfo FROM users WHERE isActive = 1 OR isActive IS NULL ORDER BY userID DESC`;

    db.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to fetch users" });
        }
        res.json(results);
    });
});

// Put route to UPDATE a user
app.put('/api/users/:id', async (req, res) => {
    const { id } = req.params;
    const { username, firstName, lastName, rawPassword, role, contactInfo } = req.body;

    try {
        let sql;
        let params;

        if (rawPassword && rawPassword.trim() !== "") {
            const hashedPassword = await bcrypt.hash(rawPassword, 10);

            sql = `
                UPDATE users 
                SET username = ?, firstName = ?, lastName = ?, userPassword = ?, role = ?, contactInfo = ? 
                WHERE userID = ?
            `;

            params = [username, firstName, lastName, hashedPassword, role, contactInfo, id];
        } else {
            sql = `
                UPDATE users 
                SET username = ?, firstName = ?, lastName = ?, role = ?, contactInfo = ? 
                WHERE userID = ?
            `;

            params = [username, firstName, lastName, role, contactInfo, id];
        }

        db.query(sql, params, (err, result) => {
            if (err) {
                if (err.code === 'ER_DUP_ENTRY') {
                    return res.status(400).json({ error: "Username already exists." });
                }
                return res.status(500).json({ error: "Failed to update user" });
            }

            // Immediately update session if the user updated their own profile
            if (req.session && req.session.user && String(req.session.user.id) === String(id)) {
                req.session.user.name = firstName;
                req.session.user.username = username;
            }

            res.status(200).json({ message: "User updated successfully!" });
            const sessionUserID = req.session?.user?.id;
            if (sessionUserID) {
                db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Edit User', ?)`,
                    [sessionUserID, `Updated user: ${username} (${role})`]);
            }
        });

    } catch (error) {
        res.status(500).json({ error: "Server error" });
    }
});

// DELETE route to REMOVE a user (soft delete)
app.delete('/api/users/:id', (req, res) => {
    const { id } = req.params;

    const sql = `UPDATE users SET isActive = 0 WHERE userID = ?`;

    db.query(sql, [id], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to archive user" });
        }
        const sessionUserID = req.session?.user?.id;
        if (sessionUserID) {
            db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Archive User', ?)`,
                [sessionUserID, `Archived user ID: ${id}`]);
        }
        res.status(200).json({ message: "User archived successfully!" });
    });
});

// --- REPORT API ENDPOINTS ---

// Sales Performance Report - grouped by product
app.get('/api/reports/sales', (req, res) => {
    const { from, to } = req.query;
    if (!from || !to) return res.status(400).json({ error: 'Date range required' });

    const sql = `
        SELECT 
            COALESCE(si.productName, p.productName, CONCAT('Product ID ', si.productID)) AS productName,
            SUM(CASE WHEN si.quantity > 0 THEN si.quantity ELSE 0 END) AS qtySold,
            SUM(CASE WHEN si.quantity < 0 THEN ABS(si.quantity) ELSE 0 END) AS qtyReturned,
            SUM(CASE WHEN si.quantity > 0 THEN si.subtotal ELSE 0 END) AS income
        FROM sales_item si
        JOIN sales_transaction st ON si.transactionID = st.transactionID
        LEFT JOIN product p ON si.productID = p.productID
        WHERE DATE(st.transDateTime) BETWEEN ? AND ?
          AND st.paymentStatus IN ('Paid', 'Refunded', 'Exchanged', 'Unpaid', 'Partial')
        GROUP BY si.productID, COALESCE(si.productName, p.productName, CONCAT('Product ID ', si.productID))
        ORDER BY income DESC
    `;

    db.query(sql, [from, to], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to generate sales report' });
        }
        res.json(results);
    });
});

// Sales Summary Report
app.get('/api/reports/sales-summary', (req, res) => {
    const { from, to } = req.query;
    if (!from || !to) return res.status(400).json({ error: 'Date range required' });

    const sql = `
        SELECT 
            (SELECT SUM(CASE WHEN paymentStatus IN ('Paid', 'Exchanged', 'Unpaid', 'Partial') THEN totalAmount ELSE 0 END) 
             FROM sales_transaction WHERE DATE(transDateTime) BETWEEN ? AND ?) AS totalSales,
            (SELECT SUM(CASE WHEN paymentStatus = 'Refunded' THEN ABS(totalAmount) ELSE 0 END) 
             FROM sales_transaction WHERE DATE(transDateTime) BETWEEN ? AND ?) AS totalRefunds,
            (SELECT COUNT(*) 
             FROM sales_transaction WHERE paymentStatus IN ('Paid', 'Exchanged', 'Unpaid', 'Partial') AND DATE(transDateTime) BETWEEN ? AND ?) AS totalOrders,
            (SELECT COALESCE(SUM(COALESCE(p.initialPrice, 0) * si.quantity), 0) 
             FROM sales_item si JOIN sales_transaction st ON si.transactionID = st.transactionID 
             LEFT JOIN product p ON si.productID = p.productID 
             WHERE DATE(st.transDateTime) BETWEEN ? AND ?) AS totalExpenses,
            (SELECT COALESCE(SUM(CASE WHEN si.quantity > 0 THEN si.quantity ELSE 0 END), 0) 
             FROM sales_item si JOIN sales_transaction st ON si.transactionID = st.transactionID 
             WHERE DATE(st.transDateTime) BETWEEN ? AND ? AND st.paymentStatus IN ('Paid', 'Exchanged', 'Unpaid', 'Partial')) AS totalProductsSold,
            (SELECT SUM(totalAmount - COALESCE(cashReceived, 0) - COALESCE(digitalAmount, 0))
             FROM sales_transaction WHERE paymentStatus IN ('Unpaid', 'Partial') AND DATE(transDateTime) BETWEEN ? AND ?) AS totalReceivables,
            (SELECT COALESCE(SUM(cashAmount + digitalAmount), 0)
             FROM payment_log WHERE status = 'Paid' AND paymentType IN ('Initial', 'Settlement', 'Installment') AND DATE(paymentDate) BETWEEN ? AND ?) AS totalCollected
    `;

    db.query(sql, [from, to, from, to, from, to, from, to, from, to, from, to, from, to], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to generate sales summary' });
        }
        res.json(results[0] || {});
    });
});

// User Logs Report - combines inventory_record + activity_log with enhanced filtering
app.get('/api/reports/userlogs', (req, res) => {
    const { from, to, user, filterBy } = req.query;
    if (!from || !to) return res.status(400).json({ error: 'Date range required' });

    const userFilter = user ? `AND u.userID = ${parseInt(user)}` : '';

    let activityCategoryFilter = '';
    let includeActivity = true;
    let includeInventory = true;

    if (filterBy === 'login') {
        activityCategoryFilter = "AND al.actionType IN ('Login', 'Logout')";
        includeInventory = false;
    } else if (filterBy === 'product') {
        includeActivity = false;
    } else if (filterBy === 'supplier') {
        includeActivity = false;
    } else if (filterBy === 'po') {
        activityCategoryFilter = "AND al.actionType IN ('Create Order', 'Update Order', 'Delete Order', 'Receive Order', 'Auto Reorder')";
        includeInventory = false;
    } else if (filterBy === 'sales') {
        activityCategoryFilter = "AND al.actionType IN ('Sale', 'Refund', 'Exchange', 'Sale Transaction')";
        includeInventory = false;
    } else if (filterBy === 'system') {
        activityCategoryFilter = "AND al.actionType NOT IN ('Login', 'Logout', 'Create Order', 'Update Order', 'Delete Order', 'Receive Order', 'Auto Reorder', 'Sale', 'Refund', 'Exchange', 'Sale Transaction')";
        includeInventory = false; // Usually inventory is just product/supplier
    }

    const queries = [];
    const params = [];

    if (includeActivity) {
        queries.push(`
            SELECT 
                al.logDateTime AS dateTime,
                CONCAT(u.firstName, ' ', u.lastName) AS userName,
                u.role AS userType,
                al.actionType AS category,
                CONCAT(al.actionType, IFNULL(CONCAT(' - ', al.details), '')) AS action
            FROM activity_log al
            JOIN users u ON al.userID = u.userID
            WHERE DATE(al.logDateTime) BETWEEN ? AND ?
            ${userFilter}
            ${activityCategoryFilter}
        `);
        params.push(from, to);

        // Fetch historical & future Refunds and Exchanges directly from sales_transaction
        if (filterBy === 'sales' || filterBy === '') {
            queries.push(`
                SELECT 
                    st.transDateTime AS dateTime,
                    CONCAT(u.firstName, ' ', u.lastName) AS userName,
                    u.role AS userType,
                    IF(st.paymentStatus = 'Refunded', 'Refund', 'Exchange') AS category,
                    CONCAT(IF(st.paymentStatus = 'Refunded', 'Refund', 'Exchange'), ' - Transaction ', st.transactionCode, ' - Amount: ₱', ABS(st.totalAmount)) AS action
                FROM sales_transaction st
                JOIN users u ON st.userID = u.userID
                WHERE DATE(st.transDateTime) BETWEEN ? AND ?
                AND st.paymentStatus IN ('Refunded', 'Exchanged')
                ${userFilter}
            `);
            params.push(from, to);
        }
    }

    if (includeInventory) {
        let invFilter = '';
        if (filterBy === 'product') {
            invFilter = "AND ir.productID IS NOT NULL AND ir.supplierID IS NULL";
        } else if (filterBy === 'supplier') {
            invFilter = "AND ir.supplierID IS NOT NULL";
        }

        queries.push(`
            SELECT 
                ir.inventoryDate AS dateTime,
                CONCAT(u.firstName, ' ', u.lastName) AS userName,
                u.role AS userType,
                ir.actionType AS category,
                CONCAT(
                    ir.actionType, ' - ',
                    CASE 
                        WHEN ir.productID IS NOT NULL THEN CONCAT('Product: ', IFNULL(p.productName, CONCAT('ID ', ir.productID)))
                        WHEN ir.supplierID IS NOT NULL THEN CONCAT('Supplier: ', IFNULL(s.supplierName, CONCAT('ID ', ir.supplierID)))
                        ELSE ''
                    END,
                    CASE WHEN ir.quantityChange != 0 THEN CONCAT(' (Qty: ', IF(ir.quantityChange > 0, '+', ''), ir.quantityChange, ')') ELSE '' END,
                    IFNULL(CONCAT(' - ', ir.details), '')
                ) AS action
            FROM inventory_record ir
            JOIN users u ON ir.userID = u.userID
            LEFT JOIN product p ON ir.productID = p.productID
            LEFT JOIN supplier s ON ir.supplierID = s.supplierID
            WHERE DATE(ir.inventoryDate) BETWEEN ? AND ?
            ${userFilter}
            ${invFilter}
        `);
        params.push(from, to);
    }

    if (queries.length === 0) {
        return res.json([]);
    }

    const sql = `(${queries.join(') UNION ALL (')}) ORDER BY dateTime DESC`;

    db.query(sql, params, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to generate user logs report' });
        }
        res.json(results);
    });
});

// Stock Alerts Report
app.get('/api/reports/stocks', (req, res) => {
    const { status } = req.query;

    let stockFilter = 'WHERE p.isActive = 1 AND p.stockQuantity <= p.lowStockThreshold';
    if (status === 'low') stockFilter += ' AND p.stockQuantity > 0';
    else if (status === 'out') stockFilter += ' AND p.stockQuantity = 0';

    const sql = `
        SELECT 
            p.productID,
            p.productName AS product,
            p.category,
            p.stockQuantity AS stocks,
            p.lowStockThreshold AS threshold,
            CASE 
                WHEN p.stockQuantity = 0 THEN 'Out of Stock'
                ELSE 'Low Stock'
            END AS status,
            GROUP_CONCAT(DISTINCT s.supplierName ORDER BY s.supplierName SEPARATOR ',') AS suppliers
        FROM product p
        LEFT JOIN supplier_products sp ON p.productID = sp.productID
        LEFT JOIN supplier s ON sp.supplierID = s.supplierID AND s.isActive = 1
        ${stockFilter}
        GROUP BY p.productID, p.productName, p.category, p.stockQuantity, p.lowStockThreshold
        ORDER BY p.stockQuantity ASC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to generate stock alerts report' });
        }
        res.json(results);
    });
});

// GET threshold suggestions for all products
app.get('/api/reports/thresholds', async (req, res) => {
    try {
        const ANALYSIS_DAYS = 90;

        // 1. Get all active products with their age and lead time
        const [products] = await db.promise().query(`
            SELECT 
                p.productID, 
                p.productName, 
                p.category, 
                p.lowStockThreshold AS currentThreshold,
                COALESCE(DATEDIFF(NOW(), MIN(ir.inventoryDate)), 0) AS ageDays,
                (SELECT AVG(leadTimeDays) FROM purchase_item pi WHERE pi.productID = p.productID AND pi.leadTimeDays IS NOT NULL) AS avgLeadDays
            FROM product p
            LEFT JOIN inventory_record ir ON p.productID = ir.productID
            WHERE p.isActive = 1
            GROUP BY p.productID
        `);

        // 2. Get sales for all products in the last 90 days
        const [sales] = await db.promise().query(`
            SELECT 
                si.productID,
                SUM(si.quantity) AS totalSold
            FROM sales_item si
            JOIN sales_transaction st ON si.transactionID = st.transactionID
            WHERE st.transDateTime >= DATE_SUB(NOW(), INTERVAL ? DAY)
              AND st.paymentStatus = 'Paid'
            GROUP BY si.productID
        `, [ANALYSIS_DAYS]);

        const salesMap = {};
        sales.forEach(s => {
            salesMap[s.productID] = parseFloat(s.totalSold) || 0;
        });

        const results = products.map(p => {
            const productAge = Math.max(1, parseInt(p.ageDays) || 0);
            const actualAnalysisDays = Math.min(ANALYSIS_DAYS, productAge);

            const totalSold = salesMap[p.productID] || 0;
            const avgDailySales = totalSold / actualAnalysisDays;

            const avgLeadDays = parseFloat(p.avgLeadDays) || 7;
            const safetyDays = 7;
            const suggested = Math.max(Math.ceil(avgDailySales * (avgLeadDays + safetyDays)), 5);

            // Generate reason
            let reason = '';
            if (totalSold === 0) {
                reason = `No sales data found in the last ${actualAnalysisDays} days. Using minimum baseline of ${suggested} units.`;
            } else {
                reason = `Avg daily sales: ${avgDailySales.toFixed(2)}. Lead time: ${Math.round(avgLeadDays)} days + ${safetyDays} day buffer.`;
                if (productAge < ANALYSIS_DAYS) {
                    reason += ` (Based on ${productAge} days of history).`;
                }
            }

            return {
                productID: p.productID,
                productName: p.productName,
                category: p.category || 'N/A',
                currentThreshold: parseInt(p.currentThreshold) || 0,
                suggestedThreshold: suggested,
                reason: reason
            };
        });

        res.json(results);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Failed to generate threshold suggestions" });
    }
});
// Losses / Defective Report
// Combines: (1) defective units from PO receipts, (2) manual stock write-offs from inventory_record, (3) defective returns from refunds/exchanges
app.get('/api/reports/losses', (req, res) => {
    const { from, to } = req.query;
    if (!from || !to) return res.status(400).json({ error: 'Date range required' });

    // Source 1: Defective items from purchase orders (Partially Completed only — Completed orders are resolved)
    const poSql = `
        SELECT
            DATE(po.orderDateTime) AS lossDate,
            'PO Defective' AS source,
            'po' AS sourceType,
            p.productName AS product,
            pi.defectiveQty AS qtyLost,
            CONCAT('PO-', po.orderID, ' (', po.status, ') - Supplier: ', IFNULL(s.supplierName, 'N/A')) AS reason
        FROM purchase_item pi
        JOIN purchase_order po ON pi.orderID = po.orderID
        JOIN product p ON pi.productID = p.productID
        LEFT JOIN supplier s ON po.supplierID = s.supplierID
        WHERE pi.defectiveQty > 0
          AND po.status = 'Partially Completed'
          AND DATE(po.orderDateTime) BETWEEN ? AND ?
    `;

    // Source 2: Manual stock write-offs logged in inventory_record
    const adjSql = `
        SELECT
            DATE(ir.inventoryDate) AS lossDate,
            'Stock Write-off' AS source,
            'adjustment' AS sourceType,
            IFNULL(p.productName, CONCAT('Product ID ', ir.productID)) AS product,
            ABS(ir.quantityChange) AS qtyLost,
            IFNULL(ir.details, ir.actionType) AS reason
        FROM inventory_record ir
        LEFT JOIN product p ON ir.productID = p.productID
        WHERE ir.quantityChange < 0
          AND ir.actionType IN ('Damaged goods', 'Lost / Stolen', 'Inventory count correction', 'Stock Adjustment')
          AND DATE(ir.inventoryDate) BETWEEN ? AND ?
    `;

    // Source 3: Defective returns from refunds/exchanges
    const returnDefSql = `
        SELECT
            DATE(st.transDateTime) AS lossDate,
            'Return Defective' AS source,
            'return' AS sourceType,
            COALESCE(si.productName, p.productName) AS product,
            ABS(si.quantity) AS qtyLost,
            CONCAT(st.paymentStatus, ' - Txn: ', st.transactionCode) AS reason
        FROM sales_item si
        JOIN sales_transaction st ON si.transactionID = st.transactionID
        LEFT JOIN product p ON si.productID = p.productID
        WHERE si.returnStatus = 'DEFECTIVE'
          AND DATE(st.transDateTime) BETWEEN ? AND ?
    `;

    db.query(poSql, [from, to], (err1, poResults) => {
        if (err1) {
            console.error('Losses PO Query Error:', err1);
            return res.status(500).json({ error: 'Failed to fetch PO defective data' });
        }

        db.query(adjSql, [from, to], (err2, adjResults) => {
            if (err2) {
                console.error('Losses Adjustment Query Error:', err2);
                return res.status(500).json({ error: 'Failed to fetch stock write-off data' });
            }

            db.query(returnDefSql, [from, to], (err3, returnResults) => {
                if (err3) {
                    console.error('Losses Return Defective Query Error:', err3);
                    return res.status(500).json({ error: 'Failed to fetch return defective data' });
                }

                const combined = [...poResults, ...adjResults, ...returnResults].sort((a, b) =>
                    new Date(b.lossDate) - new Date(a.lossDate)
                );

                res.json(combined);
            });
        });
    });
});

// Pay Later Report - All active unpaid/partial debts
app.get('/api/reports/pay-later', (req, res) => {
    // Ignore date filters to show ALL active debts as requested
    const sql = `
        SELECT 
            DATE(st.transDateTime) as transDate,
            st.transactionCode,
            COALESCE(st.customerName, 'Unknown') as customerName,
            st.contactInfo,
            st.totalAmount,
            COALESCE(st.cashReceived, 0) + COALESCE(st.digitalAmount, 0) as paidAmount,
            COALESCE(st.refundOffset, 0) as refundOffset,
            st.totalAmount - (COALESCE(st.cashReceived, 0) + COALESCE(st.digitalAmount, 0) + COALESCE(st.refundOffset, 0)) as balanceDue,
            st.dueDate
        FROM sales_transaction st
        WHERE st.paymentStatus IN ('Unpaid', 'Partial')
        ORDER BY st.transDateTime DESC
    `;
    db.query(sql, (err, results) => {
        if (err) {
            console.error('Pay Later Report Error:', err);
            return res.status(500).json({ error: 'Failed to fetch pay later report' });
        }
        res.json(results);
    });
});

// --- SALES SYSTEM API ---

// Get product by barcode for scanner
app.get('/api/getProduct', (req, res) => {
    const barcode = req.query.barcode ? req.query.barcode.trim() : "";

    // FIX: Added 'barcode' to the SELECT statement
    const sql = `SELECT productID, barcode, productName, price, stockQuantity 
                 FROM product 
                 WHERE TRIM(barcode) = ?`;

    db.query(sql, [barcode], (err, results) => {
        if (err) {
            console.error("SQL Error:", err);
            return res.status(500).json({ error: "Database error" });
        }

        if (results.length === 0) {
            console.log(`Failed lookup for: "${barcode}" (Length: ${barcode.length})`);
            return res.status(404).json({ error: "Product not found" });
        }

        res.json(results[0]);
    });
});

// Search products by name, brand, or barcode
app.get('/api/searchProducts', (req, res) => {
    const q = req.query.q ? req.query.q.trim() : "";
    if (!q) return res.json([]);

    const sql = `SELECT productID, barcode, productName, price, stockQuantity, category, brand, imagePath
                FROM product 
                WHERE isActive = 1 
                AND (productName LIKE ? OR barcode LIKE ? OR brand LIKE ?)
                ORDER BY 
                CASE WHEN TRIM(barcode) = ? THEN 0 ELSE 1 END,
                productName ASC
                LIMIT 10`;

    const wildcard = `%${q}%`;
    db.query(sql, [wildcard, wildcard, wildcard, q], (err, results) => {
        if (err) {
            console.error("Search Error:", err);
            return res.status(500).json({ error: "Search failed" });
        }
        res.json(results);
    });
});

// GET aggregated customer records based on sales_transaction
app.get('/api/customers', (req, res) => {
    const sql = `
        SELECT 
            customerName,
            MAX(contactInfo) as contactInfo,
            MAX(address) as address,
            COUNT(transactionID) as totalTransactions,
            SUM(totalAmount) as totalSpent,
            SUM(totalAmount - (COALESCE(cashReceived, 0) + COALESCE(digitalAmount, 0))) as outstandingBalance,
            MAX(transDateTime) as lastTransactionDate
        FROM sales_transaction
        WHERE customerName IS NOT NULL AND TRIM(customerName) != ''
        GROUP BY customerName
        ORDER BY customerName ASC
    `;
    db.query(sql, (err, results) => {
        if (err) {
            console.error("Customers Error:", err);
            return res.status(500).json({ error: "Failed to load customers" });
        }
        res.json(results);
    });
});

// GET recent sales transactions (for dashboard)
app.get('/api/transactions', (req, res) => {
    const limit = parseInt(req.query.limit) || 20;
    const sessionUserID = req.session?.user?.id;
    let sql = `
        SELECT st.transactionID, st.transactionCode, st.transDateTime,
               st.totalAmount, st.paymentMethod, st.paymentStatus,
               st.cashReceived, st.digitalAmount, st.discountAmount,
               st.customerName, st.contactInfo, st.address, st.dueDate,
               u.firstName, u.lastName
        FROM sales_transaction st
        LEFT JOIN users u ON st.userID = u.userID
    `;
    const params = [];

    // No user filter — all staff can see all transactions for settlement purposes

    sql += ` ORDER BY st.transDateTime DESC LIMIT ? `;
    params.push(limit);

    db.query(sql, params, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to fetch transactions' });
        }
        res.json(results);
    });
});


// GET top/most bought products (for dashboard)
app.get('/api/dashboard/top-products', (req, res) => {
    const sql = `
        SELECT 
            COALESCE(si.productName, p.productName, CONCAT('Product #', si.productID)) AS productName,
            SUM(CASE WHEN si.quantity > 0 THEN si.quantity ELSE 0 END) AS totalSold
        FROM sales_item si
        JOIN sales_transaction st ON si.transactionID = st.transactionID
        LEFT JOIN product p ON si.productID = p.productID
        WHERE st.paymentStatus IN ('Paid', 'Partial', 'Exchanged')
          AND si.quantity > 0
        GROUP BY si.productID, COALESCE(si.productName, p.productName, CONCAT('Product #', si.productID))
        ORDER BY totalSold DESC
        LIMIT 8
    `;
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to fetch top products' });
        }
        res.json(results);
    });
});

// GET collected payments (actual cash inflow) for a date range
// Uses: Initial payments, settled pay later payments, and paid installments logged in payment_log
app.get('/api/dashboard/collections', (req, res) => {
    const { startDate, endDate, types } = req.query;

    let typeFilter = "'Initial', 'Settlement', 'Installment'";
    if (types) {
        // Sanitize to prevent SQL injection, though it's an internal API
        const allowedTypes = ['Initial', 'Settlement', 'Installment'];
        const requestedTypes = types.split(',').filter(t => allowedTypes.includes(t.trim()));
        if (requestedTypes.length > 0) {
            typeFilter = requestedTypes.map(t => `'${t}'`).join(',');
        }
    }

    let sql = `
        SELECT COALESCE(SUM(cashAmount + digitalAmount), 0) AS totalCollected
        FROM payment_log
        WHERE status = 'Paid' AND paymentType IN (${typeFilter})
    `;
    const params = [];

    if (startDate && endDate) {
        sql += ` AND DATE(paymentDate) BETWEEN ? AND ?`;
        params.push(startDate, endDate);
    }

    db.query(sql, params, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to fetch collections' });
        }
        res.json({ totalCollected: parseFloat(results[0]?.totalCollected || 0) });
    });
});

// GET overall unpaid receivables
app.get('/api/dashboard/overall-receivables', (req, res) => {
    const sql = `
        SELECT SUM(totalAmount - COALESCE(cashReceived, 0) - COALESCE(digitalAmount, 0) - COALESCE(refundOffset, 0)) AS totalReceivables
        FROM sales_transaction
        WHERE paymentStatus IN ('Unpaid', 'Partial')
    `;
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to fetch overall receivables' });
        }
        res.json({ totalReceivables: parseFloat(results[0]?.totalReceivables || 0) });
    });
});

// GET customers with pay later (Unpaid / Partial) transactions (for dashboard)
app.get('/api/dashboard/pay-later', (req, res) => {
    const sql = `
        SELECT 
            st.transactionID,
            st.transactionCode,
            st.customerName,
            st.contactInfo,
            st.address,
            st.totalAmount,
            st.cashReceived,
            st.digitalAmount,
            st.refundOffset,
            st.paymentStatus,
            st.dueDate,
            st.transDateTime,
            (SELECT MIN(pl.dueDate) FROM payment_log pl 
             WHERE pl.transactionCode = st.transactionCode 
             AND pl.paymentType = 'Installment' AND pl.status != 'Paid') AS nextInstallmentDue
        FROM sales_transaction st
        WHERE st.paymentStatus IN ('Unpaid', 'Partial')
        ORDER BY COALESCE(
            (SELECT MIN(pl2.dueDate) FROM payment_log pl2 
             WHERE pl2.transactionCode = st.transactionCode 
             AND pl2.paymentType = 'Installment' AND pl2.status != 'Paid'),
            st.dueDate,
            st.transDateTime
        ) ASC
    `;
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to fetch pay-later customers' });
        }
        res.json(results);
    });
});

// GET transaction items detail by transaction ID
app.get('/api/transactions/:id/items', (req, res) => {
    const { id } = req.params;
    const sql = `
        SELECT si.productID, 
               COALESCE(si.productName, p.productName) AS productName, 
               p.barcode, 
               si.quantity, 
               si.subtotal, 
               COALESCE(si.unitPrice, p.price) AS price
        FROM sales_item si
        LEFT JOIN product p ON si.productID = p.productID
        WHERE si.transactionID = ?
        ORDER BY si.salesItemID
    `;
    db.query(sql, [id], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Failed to fetch transaction items' });
        }
        res.json(results);
    });
});


// Settle payment for Unpaid/Partial transaction
app.put('/api/transactions/:id/pay', (req, res) => {
    const { id } = req.params;
    const { paymentMethod, referenceNumber, cashAmount, digitalAmount } = req.body;
    const sessionUserID = req.session?.user?.id;

    if (!sessionUserID) return res.status(401).json({ error: "Unauthorized" });

    const cAmt = parseFloat(cashAmount) || 0;
    const dAmt = parseFloat(digitalAmount) || 0;
    const totalNewPaid = cAmt + dAmt;

    if (totalNewPaid <= 0) return res.status(400).json({ error: "Invalid payment amount" });

    db.query(`SELECT totalAmount, cashReceived, digitalAmount, transactionCode FROM sales_transaction WHERE transactionID = ?`, [id], (err, results) => {
        if (err || results.length === 0) return res.status(500).json({ error: "Failed to fetch transaction" });

        const txn = results[0];
        const total = parseFloat(txn.totalAmount);
        let cash = parseFloat(txn.cashReceived || 0) + cAmt;
        let digital = parseFloat(txn.digitalAmount || 0) + dAmt;

        // Add 0.01 tolerance for floating point
        const totalPaid = cash + digital;
        const newStatus = (totalPaid >= (total - 0.01)) ? 'Paid' : 'Partial';

        let sqlUpdate = `UPDATE sales_transaction SET cashReceived = ?, digitalAmount = ?, paymentStatus = ?`;
        let params = [cash, digital, newStatus];

        if (referenceNumber) {
            sqlUpdate += `, referenceNumber = CONCAT_WS(', ', NULLIF(referenceNumber, ''), ?)`;
            params.push(referenceNumber);
        }

        sqlUpdate += ` WHERE transactionID = ?`;
        params.push(id);

        db.query(sqlUpdate, params, (updateErr, updateRes) => {
            if (updateErr) return res.status(500).json({ error: "Failed to update payment" });

            // Log the collected payment
            db.query(`INSERT INTO payment_log (transactionCode, cashAmount, digitalAmount, paymentDate, paymentMethod, referenceNumber, status, paymentType) VALUES (?, ?, ?, NOW(), ?, ?, 'Paid', 'Settlement')`,
                [txn.transactionCode, cAmt, dAmt, paymentMethod, referenceNumber || null]);

            db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Payment Settled', ?)`,
                [sessionUserID, `Settled payment (Cash: ₱${cAmt.toFixed(2)}, Digital: ₱${dAmt.toFixed(2)}) for TXN: ${txn.transactionCode} (Status: ${newStatus})`]
            );

            res.json({ message: "Payment updated successfully", paymentStatus: newStatus });
        });
    });
});

// Get installments for a transaction
app.get('/api/transactions/:id/installments', (req, res) => {
    const { id } = req.params;
    const sql = `
        SELECT 
            i.paymentID as scheduleID, i.transactionCode, i.dueDate, i.amountDue, 
            i.status, i.paymentDate as paidDate, i.paymentMethod, i.referenceNumber,
            i.cashAmount, i.digitalAmount
        FROM payment_log i
        JOIN sales_transaction st ON i.transactionCode = st.transactionCode
        WHERE st.transactionID = ? AND i.paymentType = 'Installment'
        ORDER BY i.dueDate ASC
    `;
    db.query(sql, [id], (err, results) => {
        if (err) return res.status(500).json({ error: "Failed to fetch installments" });
        res.json(results);
    });
});

// Pay a specific installment
app.put('/api/transactions/:id/installments/:scheduleId/pay', (req, res) => {
    const { id, scheduleId } = req.params;
    const { paymentMethod, referenceNumber, cashAmount, digitalAmount } = req.body;
    const sessionUserID = req.session?.user?.id;

    if (!sessionUserID) return res.status(401).json({ error: "Unauthorized" });

    const cAmt = parseFloat(cashAmount) || 0;
    const dAmt = parseFloat(digitalAmount) || 0;
    const totalNewPaid = cAmt + dAmt;

    if (totalNewPaid <= 0) return res.status(400).json({ error: "Invalid payment amount" });

    db.query(`
        SELECT i.amountDue, i.status, i.paymentID as scheduleID, i.cashAmount, i.digitalAmount
        FROM payment_log i
        JOIN sales_transaction st ON i.transactionCode = st.transactionCode
        WHERE i.paymentID = ? AND st.transactionID = ? AND i.paymentType = 'Installment'
    `, [scheduleId, id], (err, instRes) => {
        if (err || instRes.length === 0) return res.status(500).json({ error: "Failed to fetch installment" });

        const inst = instRes[0];
        if (inst.status === 'Paid') return res.status(400).json({ error: "Installment is already paid" });

        const currentPaid = parseFloat(inst.cashAmount || 0) + parseFloat(inst.digitalAmount || 0);
        const newInstTotalPaid = currentPaid + totalNewPaid;
        const expected = parseFloat(inst.amountDue);

        const instStatus = (newInstTotalPaid >= (expected - 0.01)) ? 'Paid' : 'Partial';

        let sqlInst = `UPDATE payment_log SET status = ?, paymentDate = NOW(), paymentMethod = ?, referenceNumber = ?, cashAmount = cashAmount + ?, digitalAmount = digitalAmount + ? WHERE paymentID = ?`;
        db.query(sqlInst, [instStatus, paymentMethod, referenceNumber || null, cAmt, dAmt, scheduleId], (updErr) => {
            if (updErr) return res.status(500).json({ error: "Failed to update installment" });

            db.query(`SELECT totalAmount, cashReceived, digitalAmount, transactionCode FROM sales_transaction WHERE transactionID = ?`, [id], (stErr, stRes) => {
                if (stErr || stRes.length === 0) return res.status(500).json({ error: "Failed to fetch main transaction" });

                const txn = stRes[0];
                const total = parseFloat(txn.totalAmount);
                let cash = parseFloat(txn.cashReceived || 0) + cAmt;
                let digital = parseFloat(txn.digitalAmount || 0) + dAmt;

                const totalPaid = cash + digital;
                const newStatus = (totalPaid >= (total - 0.01)) ? 'Paid' : 'Partial';

                let sqlTxn = `UPDATE sales_transaction SET cashReceived = ?, digitalAmount = ?, paymentStatus = ?`;
                let paramsTxn = [cash, digital, newStatus];

                if (referenceNumber) {
                    sqlTxn += `, referenceNumber = CONCAT_WS(', ', NULLIF(referenceNumber, ''), ?)`;
                    paramsTxn.push(referenceNumber);
                }

                sqlTxn += ` WHERE transactionID = ?`;
                paramsTxn.push(id);

                db.query(sqlTxn, paramsTxn, (txUpdErr) => {
                    if (txUpdErr) return res.status(500).json({ error: "Failed to update main transaction payment" });

                    // Auto-close any remaining installments if the full balance is paid
                    if (newStatus === 'Paid') {
                        db.query(`UPDATE payment_log SET status = 'Paid' WHERE transactionCode = ? AND paymentType = 'Installment'`, [txn.transactionCode]);
                    }

                    db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Payment Settled', ?)`,
                        [sessionUserID, `Settled Installment (₱${totalNewPaid.toFixed(2)}) for TXN: ${txn.transactionCode} (Status: ${newStatus})`]
                    );

                    res.json({ message: "Installment paid successfully", paymentStatus: newStatus });
                });
            });
        });
    });
});


// Optimized Complete Transaction (Handles Sale + Stock in one logic flow)
app.post('/api/saveTransaction', (req, res) => {
    const sessionUserID = req.session?.user?.id || null;

    const {
        userID,
        totalAmount,
        paymentMethod,
        items,
        transactionId,
        referenceNumber,
        discountAmount,
        paymentStatus,
        cashReceived,
        digitalAmount,
        customerName,
        contactInfo,
        address,
        dueDate,
        installments
    } = req.body;

    const finalUserID = userID || sessionUserID;

    if (!finalUserID) {
        return res.status(400).json({ error: "No valid User ID found. Please re-login." });
    }

    if (!items || items.length === 0) {
        return res.status(400).json({ error: "Cannot process an empty cart." });
    }

    db.beginTransaction(err => {
        if (err) return res.status(500).json({ error: "Transaction initiation failed" });

        // 1. Determine base prefix
        let basePrefix = 'UT';
        if (paymentStatus === 'Refunded') basePrefix = 'UTR';
        else if (paymentStatus === 'Exchanged') basePrefix = 'UTE';

        // Extract Orig part if passed by client
        let origMatch = transactionId ? transactionId.match(/\(Orig:\s*(.+?)\)/) : null;
        let origSuffix = origMatch ? ` (Orig: ${origMatch[1]})` : '';

        // 2. Generate MMDDYY
        const now = new Date();
        const mm = String(now.getMonth() + 1).padStart(2, '0');
        const dd = String(now.getDate()).padStart(2, '0');
        const yy = String(now.getFullYear()).slice(-2);
        const datePart = `${mm}${dd}${yy}`;
        const searchPattern = `${basePrefix}-${datePart}-%`;

        // 3. Get sequence number
        db.query(`SELECT COUNT(*) as count FROM sales_transaction WHERE transactionCode LIKE ?`, [searchPattern], (countErr, countRes) => {
            if (countErr) {
                console.error("❌ DB ERROR (Code Gen):", countErr.message);
                return db.rollback(() => res.status(500).json({ error: "Failed to generate transaction code" }));
            }

            const nextSeq = String(countRes[0].count + 1).padStart(4, '0');
            const newTransactionCode = `${basePrefix}-${datePart}-${nextSeq}${origSuffix}`;

            const sqlTxn = `
                INSERT INTO sales_transaction 
                (transactionCode, userID, transDateTime, totalAmount, paymentMethod, referenceNumber, discountAmount, paymentStatus, cashReceived, digitalAmount, customerName, contactInfo, address, dueDate) 
                VALUES (?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            `;

            const txnParams = [
                newTransactionCode,
                finalUserID,
                totalAmount,
                paymentMethod || 'Cash',
                referenceNumber || null,
                discountAmount || 0.00,
                paymentStatus || 'Paid',
                cashReceived || 0.00,
                digitalAmount || 0.00,
                customerName || null,
                contactInfo || null,
                address || null,
                dueDate || null
            ];

            db.query(sqlTxn, txnParams, (err, result) => {
                if (err) {
                    console.error("❌ DB ERROR (Header):", err.message);
                    return db.rollback(() => res.status(500).json({ error: "Failed to save header: " + err.message }));
                }

                const dbAutoId = result.insertId;

                const itemValues = items.map(item => [
                    dbAutoId,
                    item.productID,
                    item.name || item.productName || null,
                    parseFloat(item.price) || 0,
                    item.qty,
                    parseFloat((item.price * item.qty).toFixed(2))
                ]);

                const sqlItems = `INSERT INTO sales_item (transactionID, productID, productName, unitPrice, quantity, subtotal) VALUES ?`;

                db.query(sqlItems, [itemValues], (itemErr) => {
                    if (itemErr) {
                        console.error("❌ DB ERROR (Items):", itemErr.message);
                        return db.rollback(() => res.status(500).json({ error: "Failed to save items: " + itemErr.message }));
                    }

                    const finalizeTransaction = () => {
                        const updatePromises = items.map(item => {
                            return new Promise((resolve, reject) => {
                                db.query(`UPDATE product SET stockQuantity = stockQuantity - ? WHERE productID = ?`,
                                    [item.qty, item.productID], (sErr, sRes) => {
                                        if (sErr) reject(sErr); else resolve(sRes);
                                    });
                            });
                        });

                        Promise.all(updatePromises)
                            .then(() => {
                                db.commit(cErr => {
                                    if (cErr) return db.rollback(() => res.status(500).json({ error: "Commit failed" }));

                                    // Log the initial collected payment
                                    const initCash = parseFloat(cashReceived) || 0;
                                    const initDigital = parseFloat(digitalAmount) || 0;
                                    if (initCash > 0 || initDigital > 0) {
                                        db.query(`INSERT INTO payment_log (transactionCode, cashAmount, digitalAmount, paymentDate, paymentMethod, referenceNumber, status, paymentType) VALUES (?, ?, ?, NOW(), ?, ?, 'Paid', 'Initial')`,
                                            [newTransactionCode, initCash, initDigital, paymentMethod || 'Cash', referenceNumber || null]);
                                    }

                                    db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Sale', ?)`,
                                        [finalUserID, `Transaction ${newTransactionCode} - Amount: ₱${parseFloat(totalAmount).toFixed(2)} - ${paymentMethod}`]);
                                    res.status(201).json({ message: "Transaction completed successfully.", transactionCode: newTransactionCode });
                                });
                            })
                            .catch(pErr => {
                                console.error("❌ STOCK ERROR:", pErr.message);
                                db.rollback(() => res.status(500).json({ error: "Stock update failed" }));
                            });
                    };

                    if (installments && installments.length > 0) {
                        const instValues = installments.map(inst => [
                            newTransactionCode,
                            inst.dueDate,
                            parseFloat(inst.amountDue) || 0,
                            'Scheduled',
                            'Installment'
                        ]);
                        const sqlInst = `INSERT INTO payment_log (transactionCode, dueDate, amountDue, status, paymentType) VALUES ?`;
                        db.query(sqlInst, [instValues], (instErr) => {
                            if (instErr) {
                                console.error("❌ DB ERROR (Installments):", instErr.message);
                                return db.rollback(() => res.status(500).json({ error: "Failed to save installments: " + instErr.message }));
                            }
                            finalizeTransaction();
                        });
                    } else {
                        finalizeTransaction();
                    }
                });
            });
        }); // End count query
    });
});

// Keep reduceStock as a standalone helper if needed for other features
app.post('/api/reduceStock', (req, res) => {
    const { items } = req.body;
    const updatePromises = items.map(item => {
        return new Promise((resolve, reject) => {
            const sql = `UPDATE product SET stockQuantity = stockQuantity - ? WHERE productID = ?`;
            db.query(sql, [item.qty, item.productID], (err, result) => {
                if (err) reject(err);
                else resolve(result);
            });
        });
    });

    Promise.all(updatePromises)
        .then(() => res.json({ message: "Inventory updated" }))
        .catch(err => res.status(500).json({ error: "Stock update failed" }));
});

//REFUND and CHANGE

// 1. GET TRANSACTION DETAILS BY CODE (with per-item refund tracking)
app.get('/api/getTransactionForRefund', (req, res) => {
    const txnCode = req.query.code;

    // Step 1: Get original items from the transaction
    const originalSql = `
        SELECT 
            i.productID, p.productName, p.price, i.quantity,
            t.transactionID, t.paymentMethod, t.paymentStatus, 
            t.totalAmount, t.cashReceived, t.digitalAmount,
            t.customerName, t.contactInfo, t.address, t.dueDate
        FROM sales_transaction t
        JOIN sales_item i ON t.transactionID = i.transactionID
        JOIN product p ON i.productID = p.productID
        WHERE t.transactionCode LIKE ? AND i.quantity > 0`;

    db.query(originalSql, [txnCode + '%'], (err, origItems) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Database error" });
        }
        if (origItems.length === 0) {
            return res.status(404).json({ error: "No transaction found with that code." });
        }

        const txnData = origItems[0]; // Header info is the same for all items

        // Step 2: Check how many of each product have already been refunded/exchanged
        // by looking at refund transactions (UTR/UTE) that reference the same original transaction
        const refundSql = `
            SELECT si.productID, SUM(ABS(si.quantity)) AS refundedQty
            FROM sales_item si
            JOIN sales_transaction st ON si.transactionID = st.transactionID
            WHERE st.transactionCode LIKE ?
            AND si.quantity < 0
            AND si.productID IN (?)
            GROUP BY si.productID`;

        const productIDs = origItems.map(i => i.productID);
        const origTxnPattern = `%Orig: ${txnCode}%`;

        db.query(refundSql, [origTxnPattern, productIDs], (err2, refundedItems) => {
            if (err2) {
                console.error(err2);
                return res.status(500).json({ error: "Database error" });
            }

            // Build a map of already-refunded quantities
            const refundedMap = {};
            refundedItems.forEach(r => refundedMap[r.productID] = r.refundedQty);

            // Filter out items that are fully refunded
            const remaining = origItems.map(i => {
                const refunded = refundedMap[i.productID] || 0;
                return {
                    productID: i.productID,
                    productName: i.productName,
                    price: parseFloat(i.price),
                    originalQty: i.quantity,
                    refundedQty: refunded,
                    availableQty: i.quantity - refunded,

                    // Transaction details
                    paymentMethod: txnData.paymentMethod,
                    paymentStatus: txnData.paymentStatus,
                    totalAmount: parseFloat(txnData.totalAmount),
                    cashReceived: parseFloat(txnData.cashReceived || 0),
                    digitalAmount: parseFloat(txnData.digitalAmount || 0),
                    customerName: txnData.customerName,
                    contactInfo: txnData.contactInfo,
                    address: txnData.address,
                    dueDate: txnData.dueDate
                };
            }).filter(i => i.availableQty > 0);

            if (remaining.length === 0) {
                return res.status(400).json({ error: "All items in this transaction have already been refunded or exchanged." });
            }

            res.json(remaining);
        });
    });
});

// 2. PROCESS ADJUSTMENT (Refund or Exchange)
app.post('/api/processAdjustment', async (req, res) => {
    const {
        mode,
        transactionCode,  // Format: UTE-20260510-041943 (Orig: UT-...)
        originalTxnCode,
        returns,          // Each item has .condition = 'Resellable' | 'Defective'
        exchanges,
        paymentMethod,
        cashReceived,
        digitalAmount,
        referenceNumber,
        netBalance,
        creditToPayLater,
        payLaterDetails
    } = req.body;

    const sessionUserID = req.session?.user?.id || null;
    if (!sessionUserID) return res.status(401).json({ error: "Unauthorized. Please re-login." });

    try {
        await db.promise().beginTransaction();

        let finalStatus = (mode === 'exchange') ? 'Exchanged' : 'Refunded';

        let basePrefix = (mode === 'exchange') ? 'UTE' : 'UTR';
        let origMatch = transactionCode ? transactionCode.match(/\(Orig:\s*(.+?)\)/) : null;
        let origSuffix = origMatch ? ` (Orig: ${origMatch[1]})` : '';

        const now = new Date();
        const mm = String(now.getMonth() + 1).padStart(2, '0');
        const dd = String(now.getDate()).padStart(2, '0');
        const yy = String(now.getFullYear()).slice(-2);
        const datePart = `${mm}${dd}${yy}`;
        const searchPattern = `${basePrefix}-${datePart}-%`;

        const [countRes] = await db.promise().query(`SELECT COUNT(*) as count FROM sales_transaction WHERE transactionCode LIKE ?`, [searchPattern]);
        const nextSeq = String(countRes[0].count + 1).padStart(4, '0');
        const generatedTransactionCode = `${basePrefix}-${datePart}-${nextSeq}${origSuffix}`;

        // Handle Pay Later offsets (Refund offsetting debt)
        if (creditToPayLater && creditToPayLater > 0) {
            // Treat the refund amount as a payment to the original invoice
            await db.promise().query(`
                UPDATE sales_transaction 
                SET refundOffset = refundOffset + ?,
                    paymentStatus = CASE WHEN (cashReceived + digitalAmount + refundOffset + ?) >= (totalAmount - 0.01) THEN 'Paid' ELSE 'Partial' END
                WHERE transactionCode = ?
            `, [creditToPayLater, creditToPayLater, originalTxnCode]);

            // Insert into payment log for auditing
            await db.promise().query(`
                INSERT INTO payment_log (transactionCode, cashAmount, paymentDate, paymentMethod, status, paymentType)
                VALUES (?, ?, NOW(), 'Refund Credit', 'Paid', 'Refund Offset')
            `, [originalTxnCode, creditToPayLater]);
        }

        // Handle Exchange Upcharge added to Pay Later
        let insertCustomerName = null;
        let insertContactInfo = null;
        let insertAddress = null;
        let insertDueDate = null;

        if (paymentMethod === 'Pay Later' && netBalance < -0.01) {
            finalStatus = 'Unpaid';
            if (payLaterDetails) {
                insertCustomerName = payLaterDetails.customerName;
                insertContactInfo = payLaterDetails.contactInfo;
                insertAddress = payLaterDetails.address;
                insertDueDate = payLaterDetails.dueDate;
            }
        }

        /**
         * INSERT INTO HEADER TABLE
         * Note: totalAmount is stored as -netBalance. 
         * If netBalance is 500 (Refund), we store -500 to reduce total daily sales.
         * If netBalance is -500 (Customer paid extra), we store 500 as additional revenue.
         */
        const logSql = `
            INSERT INTO sales_transaction 
            (transactionCode, userID, transDateTime, totalAmount, paymentMethod, paymentStatus, referenceNumber, cashReceived, digitalAmount, customerName, contactInfo, address, dueDate) 
            VALUES (?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;

        const [txnResult] = await db.promise().query(logSql, [
            generatedTransactionCode,
            sessionUserID,
            -netBalance,
            paymentMethod,
            finalStatus,
            referenceNumber || null,
            cashReceived || 0,
            digitalAmount || 0,
            insertCustomerName,
            insertContactInfo,
            insertAddress,
            insertDueDate
        ]);

        const dbAutoId = txnResult.insertId;

        // --- LOG ADJUSTMENT CASH FLOW TO PAYMENT LOG ---
        if (cashReceived !== 0 || digitalAmount !== 0) {
            await db.promise().query(`
                INSERT INTO payment_log (transactionCode, cashAmount, digitalAmount, paymentDate, paymentMethod, referenceNumber, status, paymentType) 
                VALUES (?, ?, ?, NOW(), ?, ?, 'Paid', 'Adjustment')
            `, [generatedTransactionCode, cashReceived || 0, digitalAmount || 0, paymentMethod || 'Cash', referenceNumber || null]);
        }

        // --- 1. HANDLE RETURNS ---
        for (const item of returns) {
            // Determine returnStatus based on item condition
            const returnStatus = (item.condition === 'Defective') ? 'DEFECTIVE' : 'RESELLABLE';

            // Only add back to inventory if the item is resellable (not defective)
            if (returnStatus === 'RESELLABLE') {
                await db.promise().query(
                    `UPDATE product SET stockQuantity = stockQuantity + ? WHERE productID = ?`,
                    [item.qty, item.productID]
                );
            }

            // Record in sales_item with negative quantity for reporting clarity
            await db.promise().query(
                `INSERT INTO sales_item (transactionID, productID, productName, unitPrice, quantity, subtotal, returnStatus) VALUES (?, ?, ?, ?, ?, ?, ?)`,
                [dbAutoId, item.productID, item.name || null, item.price || 0, -item.qty, -(item.price * item.qty), returnStatus]
            );
        }

        // --- 2. HANDLE EXCHANGES (REDUCE STOCK) ---
        for (const item of exchanges) {
            // Subtract from inventory
            await db.promise().query(
                `UPDATE product SET stockQuantity = stockQuantity - ? WHERE productID = ?`,
                [item.qty, item.productID]
            );

            // Record in sales_item as a normal sale entry (returnStatus stays 'NONE')
            await db.promise().query(
                `INSERT INTO sales_item (transactionID, productID, productName, unitPrice, quantity, subtotal) VALUES (?, ?, ?, ?, ?, ?)`,
                [dbAutoId, item.productID, item.name || null, item.price || 0, item.qty, (item.price * item.qty)]
            );
        }

        await db.promise().commit();

        res.json({
            success: true,
            message: "Adjustment processed successfully",
            transactionCode: generatedTransactionCode
        });

    } catch (error) {
        await db.promise().rollback();
        console.error("❌ Adjustment DB Error:", error);
        res.status(500).json({ error: "Database transaction failed: " + error.message });
    }
});

// BACK UP FUNCTIONS & SCHEDULES

let fullBackupJob;
let incBackupJob;

function performDatabaseBackup(backupType, userID) {
    return new Promise((resolve, reject) => {
        const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
        const fileName = `backup_${timestamp}.sql`;
        const filePath = path.join(backupDir, fileName);

        const dbUser = process.env.DB_USER;
        const dbPass = process.env.DB_PASSWORD;
        const dbName = process.env.DB_NAME;
        const dbHost = process.env.DB_HOST || 'localhost';

        const dumpCommand = `mysqldump -u ${dbUser} --password="${dbPass}" -h ${dbHost} ${dbName} > "${filePath}"`;

        exec(dumpCommand, (error, stdout, stderr) => {
            if (error) {
                console.error(`❌ Backup failed: ${error.message}`);
                return reject(error);
            }

            const sql = `INSERT INTO backup (userID, backupDate, fileName, backupType) VALUES (?, NOW(), ?, ?)`;
            db.query(sql, [userID, fileName, backupType], (dbErr) => {
                if (dbErr) {
                    console.error('❌ Failed to log backup in DB:', dbErr);
                    return reject(dbErr);
                }
                console.log(`✅ ${backupType} Backup completed successfully: ${fileName}`);
                resolve(fileName);
            });
        });
    });
}

// True Incremental Backup using MySQL Binary Logs (mysqlbinlog)
// Extracts only the SQL events that occurred SINCE the last backup timestamp.
// Falls back to a full mysqldump if no prior backup exists.
function performIncrementalBackup(userID) {
    return new Promise((resolve, reject) => {
        db.query(`SELECT backupDate FROM backup ORDER BY backupDate DESC LIMIT 1`, (err, results) => {

            const nowTimestamp = new Date().toISOString().replace(/[:.]/g, '-');
            const fileName = `incremental_backup_${nowTimestamp}.sql`;
            const filePath = path.join(backupDir, fileName);

            const dbUser = process.env.DB_USER;
            const dbPass = process.env.DB_PASSWORD;
            const dbName = process.env.DB_NAME;
            const dbHost = process.env.DB_HOST || 'localhost';

            // If no prior backup exists, fall back to a full dump for safety
            if (err || results.length === 0) {
                console.log('ℹ️ No previous backup found. Running full dump as baseline for incremental.');
                const dumpCmd = `mysqldump -u ${dbUser} --password="${dbPass}" -h ${dbHost} ${dbName} > "${filePath}"`;
                exec(dumpCmd, (execErr) => {
                    if (execErr) {
                        console.error(`❌ Fallback full dump failed: ${execErr.message}`);
                        return reject(execErr);
                    }
                    logAndResolve(fileName, filePath, userID, resolve, reject);
                });
                return;
            }

            // Format the last backup time as a MySQL-compatible datetime string
            const lastBackupDate = new Date(results[0].backupDate);
            const sinceStr = lastBackupDate.toISOString()
                .replace('T', ' ')
                .replace(/\.\d{3}Z$/, '');

            console.log(`⏳ Running TRUE incremental backup using mysqlbinlog since: ${sinceStr}`);

            // Locate all binary log files that were modified AT OR AFTER the last backup time
            const binlogDir = 'C:/ProgramData/MySQL/MySQL Server 8.0/Data';
            const binlogIndexFile = path.join(binlogDir, 'ASHLEY-bin.index');

            fs.readFile(binlogIndexFile, 'utf8', (readErr, indexData) => {
                if (readErr) {
                    console.error('❌ Could not read binlog index file:', readErr.message);
                    return reject(readErr);
                }

                // Get all binlog file paths from the index
                const allBinlogs = indexData
                    .split('\n')
                    .map(l => l.trim().replace(/\//g, path.sep))
                    .filter(l => l.length > 0)
                    .map(l => path.isAbsolute(l) ? l : path.join(binlogDir, path.basename(l)));

                // Filter to only binlogs that were last modified at or after (lastBackupDate - 1 hour buffer)
                // We include a 1-hour buffer to ensure we don't miss events at the edge boundary
                const bufferTime = new Date(lastBackupDate.getTime() - 3600000); // 1 hour back

                const relevantBinlogs = allBinlogs.filter(f => {
                    try {
                        const stat = fs.statSync(f);
                        return stat.mtime >= bufferTime;
                    } catch (e) {
                        return false;
                    }
                });

                if (relevantBinlogs.length === 0) {
                    console.log('ℹ️ No new binary log activity since last backup. Writing empty incremental.');
                    const emptyContent = '-- Udicon Incremental Backup\n-- No changes since: ' + sinceStr + '\n-- Generated: ' + new Date().toISOString() + '\n';
                    fs.writeFileSync(filePath, emptyContent);
                    return logAndResolve(fileName, filePath, userID, resolve, reject);
                }

                console.log(`📋 Processing ${relevantBinlogs.length} binlog file(s): ${relevantBinlogs.map(f => path.basename(f)).join(', ')}`);

                // Build the mysqlbinlog command:
                // --start-datetime: only extract events at or after the last backup time
                // --database: filter to only our database's changes
                // --base64-output=DECODE-ROWS --verbose: decode ROW format to readable SQL
                const binlogFileArgs = relevantBinlogs.map(f => `"${f}"`).join(' ');
                const mysqlbinlogCmd = [
                    `mysqlbinlog`,
                    `--start-datetime="${sinceStr}"`,
                    `--database="${dbName}"`,
                    `--base64-output=DECODE-ROWS`,
                    `--verbose`,
                    binlogFileArgs,
                    `> "${filePath}"`
                ].join(' ');

                exec(mysqlbinlogCmd, { maxBuffer: 1024 * 1024 * 50 }, (execErr, stdout, stderr) => {
                    if (execErr) {
                        console.error(`❌ mysqlbinlog extraction failed: ${execErr.message}`);
                        return reject(execErr);
                    }
                    console.log(`✅ mysqlbinlog extraction complete → ${fileName}`);
                    logAndResolve(fileName, filePath, userID, resolve, reject);
                });
            });
        });
    });
}

// Helper to record the backup in the DB after the file has been written
function logAndResolve(fileName, filePath, userID, resolve, reject) {
    const stat = fs.existsSync(filePath) ? fs.statSync(filePath) : null;
    const sizeKB = stat ? Math.round(stat.size / 1024) : 0;
    console.log(`📦 Backup file size: ${sizeKB} KB`);

    const sql = `INSERT INTO backup (userID, backupDate, fileName, backupType) VALUES (?, NOW(), ?, 'Incremental')`;
    db.query(sql, [userID, fileName], (dbErr) => {
        if (dbErr) {
            console.error('❌ Failed to log incremental backup in DB:', dbErr);
            return reject(dbErr);
        }
        console.log(`✅ Incremental Backup logged: ${fileName}`);
        resolve(fileName);
    });
}

const backupConfigPath = path.join(__dirname, 'backup-config.json');

// Dynamically Initialize Schedules
function initializeSchedules(fullCronStr = null, incCronStr = null) {
    if (fullCronStr && incCronStr) {
        fs.writeFileSync(backupConfigPath, JSON.stringify({ fullSchedule: fullCronStr, incSchedule: incCronStr }, null, 2), 'utf8');
    } else {
        if (fs.existsSync(backupConfigPath)) {
            try {
                const config = JSON.parse(fs.readFileSync(backupConfigPath, 'utf8'));
                fullCronStr = config.fullSchedule || '0 0 * * *';
                incCronStr = config.incSchedule || '30 * * * *';
            } catch (e) {
                console.error("Error reading backup config:", e);
                fullCronStr = '0 0 * * *';
                incCronStr = '30 * * * *';
            }
        } else {
            fullCronStr = '0 0 * * *';
            incCronStr = '30 * * * *';
        }
    }

    if (fullBackupJob) fullBackupJob.stop();
    if (incBackupJob) incBackupJob.stop();

    fullBackupJob = cron.schedule(fullCronStr, () => {
        console.log(`⏳ Running scheduled FULL database backup... (${fullCronStr})`);
        performDatabaseBackup('Scheduled', 1).catch(err => console.error(err));
    });

    incBackupJob = cron.schedule(incCronStr, () => {
        console.log(`⏳ Running scheduled INCREMENTAL database backup... (${incCronStr})`);
        performIncrementalBackup(1).catch(err => console.error(err));
    });

    console.log(`✅ Backup schedules updated: Full [${fullCronStr}], Incremental [${incCronStr}]`);
}

initializeSchedules();

// Trigger Manual Backup
app.post('/api/backups/manual', async (req, res) => {
    const userID = req.session.user ? req.session.user.id : null;
    if (!userID) return res.status(401).json({ error: "Unauthorized" });

    try {
        const fileName = await performDatabaseBackup('Manual', userID);
        res.status(201).json({ message: "Manual backup created successfully!", fileName });
    } catch (error) {
        res.status(500).json({ error: "Failed to generate backup." });
    }
});

// Get List of Backups
app.get('/api/backups', (req, res) => {
    const sql = `SELECT * FROM backup ORDER BY backupDate DESC`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: "Failed to fetch backups" });
        res.json(results);
    });
});

// Delete a Backup (Database Record + Actual File)
app.delete('/api/backups/:id', (req, res) => {
    const { id } = req.params;

    db.query(`SELECT fileName FROM backup WHERE backupID = ?`, [id], (err, results) => {
        if (err || results.length === 0) return res.status(404).json({ error: "Backup not found" });

        const fileName = results[0].fileName;
        const filePath = path.join(backupDir, fileName);
        if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
        }
        db.query(`DELETE FROM backup WHERE backupID = ?`, [id], (delErr) => {
            if (delErr) return res.status(500).json({ error: "Failed to delete backup record" });
            res.json({ message: "Backup deleted successfully" });
        });
    });
});

// Restore a Backup
app.post('/api/backups/:id/restore', (req, res) => {
    const { id } = req.params;
    const userID = req.session.user ? req.session.user.id : null;
    if (!userID) return res.status(401).json({ error: "Unauthorized" });

    db.query(`SELECT fileName FROM backup WHERE backupID = ?`, [id], (err, results) => {
        if (err || results.length === 0) return res.status(404).json({ error: "Backup not found" });

        const fileName = results[0].fileName;
        const filePath = path.join(backupDir, fileName);

        if (!fs.existsSync(filePath)) {
            return res.status(404).json({ error: "Backup file is missing on the server" });
        }

        const dbUser = process.env.DB_USER;
        const dbPass = process.env.DB_PASSWORD;
        const dbName = process.env.DB_NAME;
        const dbHost = process.env.DB_HOST || 'localhost';

        const restoreCommand = `mysql -u ${dbUser} --password="${dbPass}" -h ${dbHost} ${dbName} < "${filePath}"`;

        exec(restoreCommand, (execErr, stdout, stderr) => {
            if (execErr) {
                console.error(`❌ Restore failed: ${execErr.message}`);
                return res.status(500).json({ error: "Failed to restore database." });
            }

            console.log(`✅ Database restored successfully from: ${fileName}`);

            // Log the activity
            db.query(`INSERT INTO activity_log (userID, actionType, details) VALUES (?, 'Restore Backup', ?)`,
                [userID, `Restored backup: ${fileName}`]);

            res.json({ message: "Database restored successfully!" });
        });
    });
});

// Update Backup Schedule Settings
app.post('/api/backups/schedule', (req, res) => {
    const { fullSchedule, incSchedule } = req.body;

    if (!fullSchedule || !incSchedule) {
        return res.status(400).json({ error: 'Missing schedule parameters' });
    }

    if (!cron.validate(fullSchedule) || !cron.validate(incSchedule)) {
        return res.status(400).json({ error: "Invalid cron expression format" });
    }

    try {
        initializeSchedules(fullSchedule, incSchedule);
        res.json({ message: 'Schedules updated successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to update cron schedules' });
    }
});

// Get current backup schedule
app.get('/api/backups/schedule', (req, res) => {
    let config = { fullSchedule: '0 0 * * *', incSchedule: '30 * * * *' };
    if (fs.existsSync(backupConfigPath)) {
        try {
            const parsed = JSON.parse(fs.readFileSync(backupConfigPath, 'utf8'));
            if (parsed.fullSchedule) config.fullSchedule = parsed.fullSchedule;
            if (parsed.incSchedule) config.incSchedule = parsed.incSchedule;
        } catch (e) { }
    }
    res.json(config);
});

