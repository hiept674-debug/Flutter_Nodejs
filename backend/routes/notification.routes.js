const express = require("express");

const router = express.Router();

const notificationController = require(
  "../controllers/notification.controller"
);

// GET ALL
router.get(
  "/",
  notificationController.getAllNotifications
);

// GET BY ID
router.get(
  "/:id",
  notificationController.getNotificationById
);

// CREATE
router.post(
  "/",
  notificationController.createNotification
);

// UPDATE
router.put(
  "/:id",
  notificationController.updateNotification
);

// DELETE
router.delete(
  "/:id",
  notificationController.deleteNotification
);

// MARK READ
router.patch(
  "/:id/read",
  notificationController.markRead
);

// SEARCH
router.get(
  "/search/:keyword",
  notificationController.searchNotifications
);

module.exports = router;