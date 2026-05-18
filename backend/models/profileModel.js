let profile = {
  id: 1,
  name: "Yoo Jin",
  email: "yoojin@gmail.com",
  avatar: "assets/images/avartar.png",
  cover: "assets/images/pro1.png",

  photos: [
    "assets/images/add1.jpg",
    "assets/images/add2.jpg",
    "assets/images/add3.jpg",
    "assets/images/add4.jpg"
  ],

  journeys: [
    {
      id: 1,
      title: "A memory in Danang",
      location: "Danang, Vietnam",
      date: "Jan 30, 2020",
      likes: "236 Likes",
      image: "assets/images/a.jpg"
    },

    {
      id: 2,
      title: "Sapa in spring",
      location: "Sapa, Vietnam",
      date: "Jan 20, 2020",
      likes: "234 Likes",
      image: "assets/images/a.jpg"
    }
  ]
};

class Profile {
  static getProfile() {
    return profile;
  }

  static updateProfile(data) {
    profile.name = data.name || profile.name;
    profile.email = data.email || profile.email;

    return profile;
  }
}

module.exports = Profile;