let notifications = [
  {
    id: 1,
    content:
      "Phung Thanh Do accepted your request for the trip in Cao Bang, Vietnam on Jan 20, 2020",
    date: "Jan 16",
    image: "assets/images/Domixi.jpg",
    type: "accept",
    isAction: false,
    isRead: false,
  },

  {
    id: 2,
    content:
      "Phung Thanh Do sent you an offer for the trip in Ho Chi Minh, Vietnam on Feb 12, 2020",
    date: "Jan 16",
    image: "assets/images/Domixi.jpg",
    type: "offer",
    isAction: false,
    isRead: false,
  },
];

class Notification {
  // GET ALL
  static getAll() {
    return notifications;
  }

  // GET BY ID
  static getById(id) {
    return notifications.find((n) => n.id == id);
  }

  // CREATE
  static create(data) {
    const newNotification = {
      id: notifications.length + 1,
      content: data.content,
      date: data.date,
      image: data.image,
      type: data.type,
      isAction: data.isAction || false,
      isRead: false,
    };

    notifications.push(newNotification);

    return newNotification;
  }

  // UPDATE
  static update(id, data) {
    const index = notifications.findIndex(
      (n) => n.id == id
    );

    if (index === -1) return null;

    notifications[index] = {
      ...notifications[index],
      ...data,
    };

    return notifications[index];
  }

  // DELETE
  static delete(id) {
    const index = notifications.findIndex(
      (n) => n.id == id
    );

    if (index === -1) return false;

    notifications.splice(index, 1);

    return true;
  }

  // MARK READ
  static markRead(id) {
    const notification = notifications.find(
      (n) => n.id == id
    );

    if (!notification) return null;

    notification.isRead = true;

    return notification;
  }

  // SEARCH
  static search(keyword) {
    return notifications.filter((n) =>
      n.content.toLowerCase().includes(
        keyword.toLowerCase()
      )
    );
  }
}

module.exports = Notification;