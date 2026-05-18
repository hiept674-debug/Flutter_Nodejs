const express = require("express");
const router = express.Router();

const tripController = require("../controllers/trip.controller");
const auth = require("../middlewares/auth.middleware");

router.get("/", auth, tripController.getTrips);
router.post("/", auth, tripController.createTrip);
router.get("/:id", auth, tripController.getTripById);
router.put("/:id", auth, tripController.updateTrip);
router.delete("/:id", auth, tripController.deleteTrip);
module.exports = router;