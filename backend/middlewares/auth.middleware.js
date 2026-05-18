const jwt = require("jsonwebtoken");

const SECRET_KEY = "MY_SECRET_KEY";

function auth(req, res, next) {
  const header =
    req.headers.authorization;

  // KHÔNG CÓ TOKEN
  if (!header) {
    return res.status(401).json({
      message: "No token",
    });
  }

  // LẤY TOKEN
  const token = header.split(" ")[1];

  try {
    const decoded = jwt.verify(
      token,
      SECRET_KEY
    );

    req.user = decoded;

    next();
  } catch (err) {
    return res.status(403).json({
      message: "Invalid token",
    });
  }
}

module.exports = auth;