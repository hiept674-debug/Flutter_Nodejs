import 'package:flutter/material.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFF00C9A7);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header: Ảnh bìa + Avatar + Thông tin người dùng
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Ảnh bìa (Cover Photo)
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/pro1.png', // Thay bằng ảnh núi non của bạn
                    fit: BoxFit.cover,
                  ),
                ),
                // Nút cài đặt trên góc phải
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
                      // Chuyển sang trang Settings
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                  ),
                ),
                // Avatar đè lên ảnh bìa
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
                          backgroundImage: AssetImage(
                            'assets/images/avartar.png',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Yoo Jin",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "yoojin@gmail.com",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100), // Khoảng cách cho phần Avatar nhô ra
            // 2. Section: My Photos
            _buildSectionHeader("My Photos", () {}),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  _buildPhotoItem('assets/images/add1.jpg'),
                  _buildPhotoItem('assets/images/add2.jpg'),
                  _buildPhotoItem('assets/images/add3.jpg'),
                  _buildPhotoItem('assets/images/add4.jpg'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. Section: My Journeys
            _buildSectionHeader("My Journeys", () {}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  _buildJourneyCard(
                    "A memory in Danang",
                    "Danang, Vietnam",
                    "Jan 30, 2020",
                    "236 Likes",
                    'assets/images/a.jpg',
                    mainColor,
                  ),
                  _buildJourneyCard(
                    "Sapa in spring",
                    "Sapa, Vietnam",
                    "Jan 20, 2020",
                    "234 Likes",
                    'assets/images/a.jpg',
                    mainColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      // Giữ nguyên BottomNavigationBar đồng bộ với các trang khác
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey,
        currentIndex: 4, // Profile là mục cuối (index 4)
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

  // Tiêu đề các mục (My Photos, My Journeys)
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

  // Widget hiển thị ảnh nhỏ trong My Photos
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

  // Widget hiển thị thẻ hành trình trong My Journeys
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
