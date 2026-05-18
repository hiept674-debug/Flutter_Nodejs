const Notification = require(
  "../models/notification.model"
);

// GET ALL
exports.getAllNotifications = (req, res) => {
  res.json(Notification.getAll());
};

// GET BY ID
exports.getNotificationById = (req, res) => {
  const notification = Notification.getById(
    req.params.id
  );

  if (!notification) {
    return res.status(404).json({
      message: "Notification not found",
    });
  }

  res.json(notification);
};

// CREATE
exports.createNotification = (req, res) => {
  const newNotification =
    Notification.create(req.body);

  res.status(201).json(newNotification);
};

// UPDATE
exports.updateNotification = (req, res) => {
  const updated = Notification.update(
    req.params.id,
    req.body
  );

  if (!updated) {
    return res.status(404).json({
      message: "Notification not found",
    });
  }

  res.json(updated);
};

// DELETE
exports.deleteNotification = (req, res) => {
  const deleted = Notification.delete(
    req.params.id
  );

  if (!deleted) {
    return res.status(404).json({
      message: "Notification not found",
    });
  }

  res.json({
    message: "Deleted successfully",
  });
};

// MARK READ
exports.markRead = (req, res) => {
  const notification =
    Notification.markRead(req.params.id);

  if (!notification) {
    return res.status(404).json({
      message: "Notification not found",
    });
  }

  res.json(notification);
};

// SEARCH
exports.searchNotifications = (req, res) => {
  const result = Notification.search(
    req.params.keyword
  );

  res.json(result);
};