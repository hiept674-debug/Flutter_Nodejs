let users = [];
let id = 1;

class User {
  static getAll() {
    return users;
  }

  static getByEmail(email) {
    return users.find(u => u.email === email);
  }

  static create(data) {
    const newUser = {
      id: id++,
      ...data
    };

    users.push(newUser);

    console.log("USER SAVED:", users);

    return newUser;
  }
}

module.exports = User;