const Trip = require("../models/tripModel");

// GET ALL
exports.getTrips = (req, res) => {
  res.json(Trip.getAll());
};

// CREATE
exports.createTrip = (req, res) => {
  const trip = Trip.create(req.body);

  res.json({
    message: "Trip created",
    trip
  });
};

// GET DETAIL
exports.getTripById = (req, res) => {
  const trip = Trip.getById(parseInt(req.params.id));

  if (!trip) {
    return res.status(404).json({ message: "Not found" });
  }

  res.json(trip);
};
exports.updateTrip = (req, res) => {
  const id = parseInt(req.params.id);

  const trip = Trip.update(id, req.body);

  if (!trip) {
    return res.status(404).json({ message: "Trip not found" });
  }

  res.json({
    message: "Trip updated",
    trip
  });
};
exports.deleteTrip = (req, res) => {

  const id = parseInt(req.params.id);

  const deleted = Trip.delete(id);

  if (!deleted) {
    return res.status(404).json({
      message: "Trip not found",
    });
  }

  res.json({
    message: "Delete success",
  });
};