import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color mainColor = const Color(0xFF00C9A7);

  Map<String, dynamic>? profile;

  bool isLoading = true;

  // =========================
  // GET PROFILE API
  // =========================
  Future getProfile() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/profile"),
      );

      print("PROFILE STATUS: ${response.statusCode}");
      print("PROFILE BODY: ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          profile = jsonDecode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print("PROFILE ERROR: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            // =========================
            // HEADER
            // =========================
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,

              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,

                  child: Image.asset(profile!["cover"], fit: BoxFit.cover),
                ),

                Positioned(
                  top: 40,
                  right: 15,

                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 28,
                    ),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                  ),
                ),

                // =========================
                // AVATAR
                // =========================
                Positioned(
                  bottom: -40,

                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),

                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10),
                          ],
                        ),

                        child: CircleAvatar(
                          radius: 50,

                          backgroundImage: AssetImage(profile!["avatar"]),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        profile!["name"],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        profile!["email"],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100),

            // =========================
            // MY PHOTOS
            // =========================
            _buildSectionHeader("My Photos", () {}),

            SizedBox(
              height: 120,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),

                itemCount: profile!["photos"].length,

                itemBuilder: (context, index) {
                  return _buildPhotoItem(profile!["photos"][index]);
                },
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // MY JOURNEYS
            // =========================
            _buildSectionHeader("My Journeys", () {}),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),

              child: Column(
                children: List.generate(profile!["journeys"].length, (index) {
                  final item = profile!["journeys"][index];

                  return _buildJourneyCard(
                    item["title"],
                    item["location"],
                    item["date"],
                    item["likes"],
                    item["image"],
                    mainColor,
                  );
                }),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      // =========================
      // BOTTOM NAV
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey,
        currentIndex: 4,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: "",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // =========================
  // SECTION HEADER
  // =========================
  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  // =========================
  // PHOTO ITEM
  // =========================
  Widget _buildPhotoItem(String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }

  // =========================
  // JOURNEY CARD
  // =========================
  Widget _buildJourneyCard(
    String title,
    String location,
    String date,
    String likes,
    String imagePath,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),

        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),

            child: Image.asset(
              imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: color),

                    const SizedBox(width: 4),

                    Text(
                      location,
                      style: TextStyle(color: color, fontSize: 13),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),

                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 4),

                        Text(
                          likes,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
