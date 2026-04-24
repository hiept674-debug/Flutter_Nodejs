const User = require("../models/userModel");

// SIGNUP
exports.signup = (req, res) => {
  const { firstName, lastName, email, password, country, userType } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: "Missing data" });
  }

  const existing = User.getByEmail(email);
  if (existing) {
    return res.status(400).json({ message: "Email already exists" });
  }

  const newUser = User.create({
    firstName,
    lastName,
    email,
    password,
    country,
    userType
  });

  res.json({
    message: "Signup success",
    user: newUser
  });
};


// LOGIN
exports.login = (req, res) => {
  const { email, password } = req.body;

  const user = User.getByEmail(email);

  if (!user || user.password !== password) {
    return res.status(401).json({ message: "Invalid credentials" });
  }

  res.json({
    message: "Login success",
    user
  });
};


// GET ALL USERS
exports.getUsers = (req, res) => {
  res.json(User.getAll());
};


// GET USER BY ID
exports.getUser = (req, res) => {
  const id = parseInt(req.params.id);

  const user = User.getById(id);

  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }

  res.json(user);
};