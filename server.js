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