const express = require('express');
const cors = require('cors');
const multer = require('multer');
const mysql = require('mysql');
const path = require('path');
const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads')); // Serve uploaded files

// MySQL DB connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // replace with your MySQL password
  database: 'file_upload'
});

db.connect(err => {
  if (err) {
    console.error("❌ MySQL Connection Failed:", err);
    throw err;
  }
  console.log("✅ MySQL connected");
});

// Storage setup for multer
const storage = multer.diskStorage({
  destination: './uploads/',
  filename: function (req, file, cb) {
    const safeName = Date.now() + '-' + file.originalname.replace(/\s+/g, '_');
    cb(null, safeName);
  }
});

// Multer upload middleware with extension checking
const upload = multer({
  storage: storage,
  limits: { fileSize: 10 * 1024 * 1024 }, // 10 MB max
  fileFilter: (req, file, cb) => {
    const ext = path.extname(file.originalname).toLowerCase();
    const allowedExts = ['.pdf', '.jpg', '.jpeg', '.png'];

    console.log("📦 Incoming file:");
    console.log("📄 Name:", file.originalname);
    console.log("📁 MIME Type:", file.mimetype);
    console.log("📎 Extension:", ext);

    if (allowedExts.includes(ext)) {
      cb(null, true);
    } else {
      console.log("Invalid file type:", ext);
      cb(new Error('Invalid file type'));
    }
  }
});

// Upload endpoint
app.post('/upload', upload.single('file'), (req, res) => {
  const file = req.file;
  if (!file) return res.status(400).send("No file uploaded");

  const sql = 'INSERT INTO uploaded_files (file_name, file_path, upload_date) VALUES (?, ?, NOW())';
  db.query(sql, [file.originalname, file.path], (err, result) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).send("Database error");
    }
    res.status(200).send("File uploaded");
  });
});

// Fetch uploaded files
app.get('/files', (req, res) => {
  db.query('SELECT * FROM uploaded_files ORDER BY id DESC', (err, results) => {
    if (err) {
      console.error("Fetch error:", err);
      return res.status(500).send("Database error");
    }
    res.json(results);
  });
});

// Start server
app.listen(PORT, () => {
  console.log(` Server running at: http://localhost:${PORT}`);
});
