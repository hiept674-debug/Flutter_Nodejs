let trips = [];
let id = 1;

class Trip {
  static getAll() {
    return trips;
  }

  static create(data) {
    const trip = {
      id: id++,
      title: data.title,
      location: data.location,
      date: data.date,
      time: data.time,
      guide: data.guide,
      image: data.image || ""
    };

    trips.push(trip);
    return trip;
  }

  static update(idTrip, data) {
  const trip = trips.find(t => t.id === idTrip);

  if (!trip) return null;

  trip.title = data.title ?? trip.title;
  trip.location = data.location ?? trip.location;
  trip.date = data.date ?? trip.date;
  trip.time = data.time ?? trip.time;
  trip.guide = data.guide ?? trip.guide;
  trip.image = data.image ?? trip.image; // 👈 QUAN TRỌNG

  return trip;
}

  static getById(idTrip) {
    return trips.find(t => t.id === idTrip);
  }

  static delete(idTrip) {
    const index = trips.findIndex(t => t.id === idTrip);
    if (index === -1) return false;

    trips.splice(index, 1);
    return true;
  }
}

module.exports = Trip;