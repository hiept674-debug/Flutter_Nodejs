const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

router.post("/signup", userController.signup);
router.post("/login", userController.login);
router.get("/users", userController.getUsers);
router.get("/user/:id", userController.getUser);

module.exports = router;