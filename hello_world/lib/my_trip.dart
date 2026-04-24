import 'package:flutter/material.dart';
import 'trip_detail_page.dart';
import 'inbox_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'add_photos_page.dart';

class MyTripsPage extends StatelessWidget {
  const MyTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFF00C9A7);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. Header
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: mainColor,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "My Trips",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/a.jpg', fit: BoxFit.cover),
                  Container(color: Colors.black.withOpacity(0.2)),
                ],
              ),
            ),
          ),

          // 2. Tab Menu
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                children: [
                  _buildTabItem("Current Trips", true, mainColor),
                  _buildTabItem("Next Trips", false, mainColor),
                  _buildTabItem("Past Trips", false, mainColor),
                  _buildTabItem("Wish List", false, mainColor),
                ],
              ),
            ),
          ),

          // 3. Trip List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildTripCard(context, mainColor),
              childCount: 1,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Chuyển sang trang Add Photos
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPhotosPage()),
          );
        },
        backgroundColor: mainColor,
        child: const Icon(Icons.add, size: 35, color: Colors.white),
      ),

      // 4. Navigation Bar đã được cập nhật logic
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) {
          if (index == 2) {
            // Chuyển sang trang Chat
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InboxPage()),
            );
          } else if (index == 3) {
            // Chuyển sang trang Notifications
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsPage(),
              ),
            );
          } else if (index == 4) {
            // THÊM ĐIỀU HƯỚNG PROFILE TẠI ĐÂY
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "My Trips",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, bool isActive, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.asset(
                  // Đổi sang Image.asset nếu bạn dùng ảnh trong máy
                  'assets/images/a.jpg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                bottom: 10,
                left: 15,
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 20),
                    Text(
                      " Da Nang, Vietnam",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Dragon Bridge Trip",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _iconInfo(Icons.calendar_today, "Jan 30, 2020"),
                      _iconInfo(Icons.access_time, "13:00 - 15:00"),
                      _iconInfo(Icons.person_pin, "Tuan Tran"),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TripDetailPage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.info_outline, color: color),
                        label: Text("Detail", style: TextStyle(color: color)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: color),
                        ),
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/tuan.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
