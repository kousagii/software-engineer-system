require('dotenv').config(); 

const express = require('express');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const session = require('express-session');
const path = require('path');
const multer = require('multer');
const fs = require('fs');
const { exec } = require('child_process');
const cron = require('node-cron');

const backupDir = path.join(__dirname, 'backups');
if (!fs.existsSync(backupDir)){
    fs.mkdirSync(backupDir, { recursive: true });
}

const uploadDir = path.join(__dirname, 'program_codes', 'uploads');
if (!fs.existsSync(uploadDir)){
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

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

db.connect((err) => {
    if (err) {
        console.error('❌ DATABASE CONNECTION ERROR:', err.message);
        return;
    }
    console.log('✅ Connected to MySQL Database!');
});


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
            return res.status(401).json({ error: "User not found" });
        }

        const user = results[0];

        const match = await bcrypt.compare(password, user.userPassword);
        
        if (match) {
            req.session.user = {
                id: user.userID,
                username: user.username,
                role: user.role,
                name: user.firstName
            };
            res.json({ message: "Login successful", role: user.role });
        } else {
            res.status(401).json({ error: "Incorrect password" });
        }
    });
});

// Route to check current session status
app.get('/api/auth-status', (req, res) => {
    if (req.session.user) {
        res.json({ loggedIn: true, role: req.session.user.role });
    } else {
        res.json({ loggedIn: false });
    }
});

app.post('/api/logout', (req, res) => {
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

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`✅ Server is successfully running on http://localhost:${PORT}/log-in.html`);
});

// GET route to fetch products for the inventory product list page
app.get('/api/products', (req, res) => {
    const sql = `SELECT * FROM product WHERE isActive = 1 ORDER BY productID DESC`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: "Failed to fetch products" });
        res.json(results);
    });
});

// POST route to add a new product 
app.post('/api/products', upload.single('productImage'), (req, res) => {
    const { productName, barcode, category, stockQuantity, price, brand, productDescription } = req.body;
    const imagePath = req.file ? `/uploads/${req.file.filename}` : null; 
    
    const sql = `INSERT INTO product (productName, barcode, category, stockQuantity, price, brand, productDescription, imagePath) 
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;
    
    db.query(sql, [productName, barcode, category, stockQuantity, price, brand, productDescription, imagePath], (err, result) => {
        if (err) {
            console.error(err);
            if (err.code === 'ER_DUP_ENTRY') {
                return res.status(400).json({ error: "That barcode already exists!" });
            }
            return res.status(500).json({ error: "Database error" });
        }
        res.status(201).json({ message: "Success!" });
    });
});

// PUT route to UPDATE an existing product 
app.put('/api/products/:id', upload.single('productImage'), (req, res) => {
    const { id } = req.params;
    const { productName, category, stockQuantity, price, brand, productDescription } = req.body;
    
    const newImagePath = req.file ? `/uploads/${req.file.filename}` : null;

    let sql, params;

    if (newImagePath) {
        sql = `UPDATE product 
               SET productName = ?, category = ?, stockQuantity = ?, price = ?, brand = ?, productDescription = ?, imagePath = ? 
               WHERE productID = ?`;
        params = [productName, category, stockQuantity, price, brand, productDescription, newImagePath, id];
    } else {
        sql = `UPDATE product 
               SET productName = ?, category = ?, stockQuantity = ?, price = ?, brand = ?, productDescription = ? 
               WHERE productID = ?`;
        params = [productName, category, stockQuantity, price, brand, productDescription, id];
    }
                 
    db.query(sql, params, (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to update product" });
        }
        res.status(200).json({ message: "Product updated successfully!" });
    });
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
        res.status(200).json({ message: "Product removed!" });
    });
});


// SUPPLIER MANAGEMENT 

// GET route to fetch all suppliers with their associated products
app.get('/api/suppliers', (req, res) => {
    const query = `
        SELECT 
            s.supplierID,
            s.supplierName,
            s.contactNumber,
            s.email,
            s.address,
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

// POST route to add a new supplier
app.post('/api/suppliers', (req, res) => {
    const { supplierName, contactNumber, email, address, productIDs } = req.body;
    
    const sql = `INSERT INTO supplier (supplierName, contactNumber, email, address) VALUES (?, ?, ?, ?)`;
    
    db.query(sql, [supplierName, contactNumber, email, address], (err, result) => {
        if (err) return res.status(500).json({ error: "Database error" });
        
        const newSupplierId = result.insertId;
    
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
    const { supplierName, contactNumber, email, address, productIDs } = req.body;
    
    const sql = `UPDATE supplier SET supplierName = ?, contactNumber = ?, email = ?, address = ? WHERE supplierID = ?`;
                 
    db.query(sql, [supplierName, contactNumber, email, address, id], (err, result) => {
        if (err) return res.status(500).json({ error: "Failed to update supplier" });
        
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
        res.status(200).json({ message: "Supplier removed!" });
    });
});


// PURCHASE ORDER / ORDERS MANAGEMENT

// GET all orders with their items
app.get('/api/orders', (req, res) => {
    const sql = `
        SELECT po.*, s.supplierName
        FROM purchase_order po
        LEFT JOIN supplier s ON po.supplierID = s.supplierID
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
            SELECT pi.orderID, pi.productID, pi.quantity, pi.unitCost, p.productName
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
                itemsByOrder[it.orderID].push({ productID: it.productID, productName: it.productName, qty: it.quantity, unitCost: it.unitCost });
            });

            const result = orders.map(o => ({
                orderID: o.orderID,
                userID: o.userID,
                supplierID: o.supplierID,
                supplierName: o.supplierName,
                orderDate: o.orderDateTime || o.orderDate || null,
                status: o.status,
                contact: o.contact || null,
                shipmentInfo: o.shipmentInfo || null,
                items: itemsByOrder[o.orderID] || []
            }));

            res.json(result);
        });
    });
});

// POST create a new order 
app.post('/api/orders', (req, res) => {
    const userID = req.session && req.session.user ? req.session.user.id : 1; 
    const { supplierID, contact, shipmentInfo, status, items } = req.body;

    if (!supplierID) return res.status(400).json({ error: "supplierID is required" });

    const orderDateTime = new Date();
    const insertSql = `INSERT INTO purchase_order (userID, supplierID, orderDateTime, status, contact, shipmentInfo) VALUES (?, ?, ?, ?, ?, ?)`;

    db.query(insertSql, [userID, supplierID, orderDateTime, status || 'Pending', contact || null, shipmentInfo || null], (err, result) => {
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
            });
            });
        });
    });
});

// PUT update an existing order (replace items)
app.put('/api/orders/:id', async (req, res) => {
    const { id } = req.params;
    const { supplierID, contact, shipmentInfo, status, items } = req.body;

    try {

        const [existingOrders] = await db.promise().query(
            `SELECT status FROM purchase_order WHERE orderID = ?`,
            [id]
        );

        if (existingOrders.length === 0) {
            return res.status(404).json({
                error: "Order not found"
            });
        }

        const oldStatus = existingOrders[0].status;

        if (oldStatus === 'Completed') {
            return res.status(400).json({
                error: "Completed orders cannot be modified."
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
                shipmentInfo = ?
            WHERE orderID = ?
        `;

        await db.promise().query(updateOrderSql, [
            supplierID,
            status || 'Pending',
            contact || null,
            shipmentInfo || null,
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

            if (oldStatus !== 'Completed' && status === 'Completed') {

                for (const item of items) {

                    const updateStockSql = `
                        UPDATE product
                        SET stockQuantity = stockQuantity + ?
                        WHERE productID = ?
                    `;

                    await db.promise().query(updateStockSql, [
                        item.qty || item.quantity || 0,
                        item.productID
                    ]);
                }
            }
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

// DELETE an order
app.delete('/api/orders/:id', (req, res) => {
    const { id } = req.params;
    db.query(`DELETE FROM purchase_item WHERE orderID = ?`, [id], (err) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to delete order items" });
        }
        db.query(`DELETE FROM purchase_order WHERE orderID = ?`, [id], (err2) => {
            if (err2) {
                console.error(err2);
                return res.status(500).json({ error: "Failed to delete order" });
            }
            res.json({ message: "Order deleted" });
        });
    });
});


// USER MANAGEMENT 

// GET route to fetch all users (excluding passwords for security)
app.get('/api/users', (req, res) => {
    const sql = `SELECT userID, username, firstName, lastName, role, contactInfo FROM users ORDER BY userID DESC`;
    
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

            res.status(200).json({ message: "User updated successfully!" });
        });

    } catch (error) {
        res.status(500).json({ error: "Server error" });
    }
});

// DELETE route to REMOVE a user
app.delete('/api/users/:id', (req, res) => {
    const { id } = req.params;
    
    const sql = `DELETE FROM users WHERE userID = ?`;
    
    db.query(sql, [id], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to delete user" });
        }
        res.status(200).json({ message: "User deleted successfully!" });
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
        digitalAmount
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

        const sqlTxn = `
            INSERT INTO sales_transaction 
            (transactionCode, userID, transDateTime, totalAmount, paymentMethod, referenceNumber, discountAmount, paymentStatus, cashReceived, digitalAmount) 
            VALUES (?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?)
        `;
        
        const txnParams = [
            transactionId, 
            finalUserID, 
            totalAmount, 
            paymentMethod || 'Cash',
            referenceNumber || null,
            discountAmount || 0.00,
            paymentStatus || 'Paid',
            cashReceived || 0.00,
            digitalAmount || 0.00
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
                item.qty, 
                parseFloat((item.price * item.qty).toFixed(2))
            ]);

            const sqlItems = `INSERT INTO sales_item (transactionID, productID, quantity, subtotal) VALUES ?`;

            db.query(sqlItems, [itemValues], (itemErr) => {
                if (itemErr) {
                    console.error("❌ DB ERROR (Items):", itemErr.message);
                    return db.rollback(() => res.status(500).json({ error: "Failed to save items: " + itemErr.message }));
                }

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
                            res.status(201).json({ message: "Transaction completed successfully.", transactionCode: transactionId });
                        });
                    })
                    .catch(pErr => {
                        console.error("❌ STOCK ERROR:", pErr.message);
                        db.rollback(() => res.status(500).json({ error: "Stock update failed" }));
                    });
            });
        });
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

        const dumpCommand = `mysqldump -u ${dbUser} --password="${dbPass}" -h ${dbHost} ${dbName} --ignore-table=${dbName}.backup > "${filePath}"`;

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

// Dynamically Initialize Schedules
function initializeSchedules(fullCronStr = '0 0 * * *', incCronStr = '30 * * * *') {
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
    const userID = req.session.user ? req.session.user.id : 1; // Fallback to 1 if testing without auth
    
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

// --- INCREMENTAL BACKUP FUNCTION ---
function performIncrementalBackup(userID) {
    return new Promise((resolve, reject) => {
        db.query('SHOW MASTER STATUS', (err, results) => {
            if (err) {
                console.error('❌ Failed to get master status. Does this DB user have SUPER or REPLICATION CLIENT privileges?', err);
                return reject(err);
            }

            if (!results || results.length === 0) {
                return reject(new Error('Binary logging is not enabled on the MySQL server.'));
            }

            const activeLogFile = results[0].File;
        
            db.query('FLUSH LOGS', (flushErr) => {
                if (flushErr) {
                    console.error('❌ Failed to flush logs:', flushErr);
                    return reject(flushErr);
                }

                const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
                const fileName = `incremental_${timestamp}.sql`;
                const filePath = path.join(backupDir, fileName);

                const dbUser = process.env.DB_USER;
                const dbPass = process.env.DB_PASSWORD;
                const dbHost = process.env.DB_HOST || 'localhost';

                const binlogCmd = `mysqlbinlog --read-from-remote-server --host=${dbHost} --user=${dbUser} --password="${dbPass}" ${activeLogFile} > "${filePath}"`;

                exec(binlogCmd, (execErr) => {
                    if (execErr) {
                        console.error(`❌ Incremental backup failed: ${execErr.message}`);
                        return reject(execErr);
                    }

                    const sql = `INSERT INTO backup (userID, backupDate, fileName, backupType) VALUES (?, NOW(), ?, 'Incremental')`;
                    db.query(sql, [userID, fileName], (dbErr) => {
                        if (dbErr) return reject(dbErr);
                        
                        console.log(`✅ Incremental Backup completed successfully: ${fileName}`);
                        resolve(fileName);
                    });
                });
            });
        });
    });
}
