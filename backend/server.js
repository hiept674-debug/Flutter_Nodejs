const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

const userRoutes = require("./routes/userRoutes");
const tripRoutes = require("./routes/trip.routes");
const profileRoutes = require("./routes/profile.routes");
const notificationRoutes = require("./routes/notification.routes")
const authRoutes = require("./routes/auth.routes");
// dùng routes
app.use("/api", userRoutes);
app.use("/api/trips", tripRoutes);
app.use("/api/notifications", notificationRoutes);
const uploadRoute = require("./routes/upload.routes");
app.use("/api/upload", uploadRoute);
app.use("/uploads", express.static("uploads"));
app.use("/api/profile", profileRoutes);
app.use("/api/auth", authRoutes);

app.listen(3000, () => {
  console.log("Server running at http://localhost:3000");
});