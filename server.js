require('dotenv').config(); 

const express = require('express');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const session = require('express-session');
const path = require('path');

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
        // We will set the password to "admin123"
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
    const sql = `SELECT * FROM product ORDER BY productID DESC`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: "Failed to fetch products" });
        res.json(results);
    });
});
// POST route to add a new product
app.post('/api/products', (req, res) => {
    const { productName, barcode, category, stockQuantity, price, brand, productDescription } = req.body;
    
    const sql = `INSERT INTO product (productName, barcode, category, stockQuantity, price, brand, productDescription) 
                 VALUES (?, ?, ?, ?, ?, ?, ?)`;
    
    db.query(sql, [productName, barcode, category, stockQuantity, price, brand, productDescription], (err, result) => {
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
app.put('/api/products/:id', (req, res) => {
    const { id } = req.params;
    // Note: We don't update the barcode, as requested.
    const { productName, category, stockQuantity, price, brand, productDescription } = req.body;
    
    const sql = `UPDATE product 
                 SET productName = ?, category = ?, stockQuantity = ?, price = ?, brand = ?, productDescription = ? 
                 WHERE productID = ?`;
                 
    db.query(sql, [productName, category, stockQuantity, price, brand, productDescription, id], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to update product" });
        }
        res.status(200).json({ message: "Product updated successfully!" });
    });
});

// DELETE route to REMOVE a product
app.delete('/api/products/:id', (req, res) => {
    const { id } = req.params;
    
    const sql = `DELETE FROM product WHERE productID = ?`;
    
    db.query(sql, [id], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to delete product" });
        }
        res.status(200).json({ message: "Product deleted successfully!" });
    });
});


// SUPPLIER MANAGEMENT 

// GET route to fetch all suppliers with their associated products
app.get('/api/suppliers', (req, res) => {
    // We use GROUP_CONCAT to get all products attached to a supplier in a single row
    const sql = `
        SELECT s.*, 
               GROUP_CONCAT(p.productName SEPARATOR ', ') AS productNames,
               GROUP_CONCAT(p.productID SEPARATOR ',') AS productIDs
        FROM supplier s
        LEFT JOIN supplier_products sp ON s.supplierID = sp.supplierID
        LEFT JOIN product p ON sp.productID = p.productID
        GROUP BY s.supplierID
        ORDER BY s.supplierID DESC
    `;
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to fetch suppliers" });
        }
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
        
        // If products were checked, insert them into the junction table
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
        
        // Clear old products for this supplier
        db.query(`DELETE FROM supplier_products WHERE supplierID = ?`, [id], (delErr) => {
            if (delErr) console.error(delErr);
            
            // Insert the newly checked products
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

// DELETE route to REMOVE a supplier
app.delete('/api/suppliers/:id', (req, res) => {
    const { id } = req.params;
    const sql = `DELETE FROM supplier WHERE supplierID = ?`;
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).json({ error: "Failed to delete supplier" });
        res.status(200).json({ message: "Supplier deleted successfully!" });
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

// PUT route to UPDATE an existing user's information 
app.put('/api/users/:id', async (req, res) => {
    const { id } = req.params;
    const { username, firstName, lastName, role, contactInfo, rawPassword } = req.body;
    
    try {
        if (rawPassword && rawPassword.trim() !== '') {
            // If the admin typed a new password, hash it and update everything
            const hashedPassword = await bcrypt.hash(rawPassword, 10);
            const sql = `UPDATE users 
                         SET username = ?, firstName = ?, lastName = ?, role = ?, contactInfo = ?, userPassword = ? 
                         WHERE userID = ?`;
                         
            db.query(sql, [username, firstName, lastName, role, contactInfo, hashedPassword, id], (err, result) => {
                if (err) return handleUpdateError(err, res);
                res.status(200).json({ message: "User and password updated successfully!" });
            });
        } else {
            // If the password field was left blank, only update the other info
            const sql = `UPDATE users 
                         SET username = ?, firstName = ?, lastName = ?, role = ?, contactInfo = ? 
                         WHERE userID = ?`;
                         
            db.query(sql, [username, firstName, lastName, role, contactInfo, id], (err, result) => {
                if (err) return handleUpdateError(err, res);
                res.status(200).json({ message: "User updated successfully!" });
            });
        }
    } catch (error) {
        res.status(500).json({ error: "Hashing error while updating password" });
    }

    // Helper function for database errors to keep the code clean
    function handleUpdateError(err, res) {
        console.error(err);
        if (err.code === 'ER_DUP_ENTRY') {
            return res.status(400).json({ error: "That username is already taken!" });
        }
        return res.status(500).json({ error: "Failed to update user" });
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