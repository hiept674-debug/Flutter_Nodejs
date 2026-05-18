const multer = require("multer");

// cấu hình lưu file
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname);
  }
});

const upload = multer({ storage }).single("image");

exports.uploadImage = (req, res) => {
  upload(req, res, (err) => {
    if (err) {
      return res.status(500).json({ message: "Upload failed" });
    }

    if (!req.file) {
      return res.status(400).json({ message: "No file" });
    }

    res.json({
      message: "Upload success",
      imageUrl: `http://localhost:3000/uploads/${req.file.filename}`
    });
  });
};
exports.updateTrip = (req, res) => {
  const id = parseInt(req.params.id);

  const trip = Trip.update(id, req.body);

  if (!trip) {
    return res.status(404).json({ message: "Trip not found" });
  }

  res.json({
    message: "Trip updated",
    trip
  });
};