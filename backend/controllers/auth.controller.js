const jwt = require("jsonwebtoken");

const SECRET_KEY = "MY_SECRET_KEY";

const users = [
  {
    id: 1,
    firstName: "Thanh",
    lastName: "Hiệp",
    email: "hiep@gmail.com",
    password: "123",
    country: "Vietnam",
    userType: 1,
  },
];

exports.login = (req, res) => {

  const { email, password } = req.body;

  // FIND USER
  const user = users.find(
    (u) => u.email === email
  );

  // EMAIL NOT FOUND
  if (!user) {
    return res.status(401).json({
      message: "Email not found",
    });
  }

  // WRONG PASSWORD
  if (user.password !== password) {
    return res.status(401).json({
      message: "Wrong password",
    });
  }

  // CREATE TOKEN
  const token = jwt.sign(
    {
      id: user.id,
      email: user.email,
    },
    SECRET_KEY,
    {
      expiresIn: "1d",
    }
  );

  // RESPONSE
  res.json({
    message: "Login success",
    token: token,
    user: user,
  });
};