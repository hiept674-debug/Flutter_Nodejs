let users = [
  {
    id: 1,
    email: "admin@gmail.com",
    password: "123456",
    name: "Admin",
  },
];

class User {
  static login(email, password) {
    return users.find(
      (u) =>
        u.email === email &&
        u.password === password
    );
  }
}

module.exports = User;