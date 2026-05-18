const Profile = require("../models/profileModel");

// GET PROFILE
exports.getProfile = (req, res) => {
  res.json(Profile.getProfile());
};

// UPDATE PROFILE
exports.updateProfile = (req, res) => {
  const updated = Profile.updateProfile(req.body);

  res.json({
    message: "Profile updated",
    data: updated
  });
};