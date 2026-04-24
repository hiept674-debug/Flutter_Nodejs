import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFF00C9A7);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 1. Header giống các trang chính khác (My Trips, Chat)
          SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            backgroundColor: mainColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/a.jpg', // Dùng chung ảnh cầu rồng
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withOpacity(0.3)),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),

          // 2. Danh sách thông báo
          SliverList(
            delegate: SliverChildListDelegate([
              _buildNotificationItem(
                "Tuan Tran accepted your request for the trip in Danang, Vietnam on Jan 20, 2020",
                "Jan 16",
                'assets/images/avartar.png',
                icon: Icons.check_circle,
                iconColor: Colors.green,
              ),
              _buildNotificationItem(
                "Emmy sent you an offer for the trip in Ho Chi Minh, Vietnam on Feb 12, 2020",
                "Jan 16",
                'assets/images/avartar.png',
                icon: Icons.local_offer,
                iconColor: Colors.orange,
              ),
              _buildNotificationItem(
                "Thanks! Your trip in Danang, Vietnam on Jan 20, 2020 has been finished. Please leave a review for the guide Tuan Tran.",
                "Jan 24",
                'assets/images/avartar.png', // Icon app hoặc logo
                isAction: true,
                mainColor: mainColor,
              ),
            ]),
          ),
        ],
      ),
      // Giữ nguyên BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey,
        currentIndex: 3, // Notifications là mục thứ 4 (index 3)
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
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    String content,
    String date,
    String imagePath, {
    IconData? icon,
    Color? iconColor,
    bool isAction = false,
    Color? mainColor,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ảnh đại diện có icon nhỏ đi kèm
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(imagePath),
                  ),
                  if (icon != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 14, color: iconColor),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 15),
              // Nội dung thông báo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content,
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (isAction) ...[
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Leave Review",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
