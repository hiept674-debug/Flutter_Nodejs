const express = require("express");
const router = express.Router();
const multer = require("multer");

// lưu file vào folder uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname);
  }
});

const upload = multer({ storage });

// API UPLOAD
router.post("/", upload.single("image"), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ message: "No file uploaded" });
  }

  const imageUrl = `http://localhost:3000/uploads/${req.file.filename}`;

  res.json({
    message: "Upload success",
    imageUrl
  });
});

module.exports = router;