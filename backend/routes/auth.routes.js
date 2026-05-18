const express = require("express");

const router = express.Router();

const AuthController = require(
  "../controllers/auth.controller"
);

// LOGIN
router.post(
  "/login",
  AuthController.login
);

module.exports = router;