const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

const userRoutes = require("./routes/userRoutes");

// dùng routes
app.use("/api", userRoutes);

app.listen(3000, () => {
  console.log("Server running at http://localhost:3000");
});