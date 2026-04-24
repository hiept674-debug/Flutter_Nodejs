let users = [];

const UserModel = {
  getAll: () => users,

  getById: (id) => users.find(u => u.id === id),

  getByEmail: (email) => users.find(u => u.email === email),

  create: (user) => {
    user.id = users.length + 1;
    users.push(user);
    return user;
  }
};

module.exports = UserModel;