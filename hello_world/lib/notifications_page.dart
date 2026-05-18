import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final Color mainColor = const Color(0xFF00C9A7);

  List notifications = [];
  bool isLoading = true;

  // =========================
  // LOAD API
  // =========================
  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  // =========================
  // GET NOTIFICATIONS API
  // =========================
  Future fetchNotifications() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/notifications"),
      );

      final data = jsonDecode(response.body);

      setState(() {
        notifications = data;
        isLoading = false;
      });
    } catch (e) {
      print("ERROR: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  // =========================
  // UI
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: CustomScrollView(
        slivers: [
          // =========================
          // HEADER (GIỮ NGUYÊN)
          // =========================
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
                  Image.asset('assets/images/a.jpg', fit: BoxFit.cover),

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

          // =========================
          // LOADING
          // =========================
          if (isLoading)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),

          // =========================
          // LIST NOTIFICATIONS
          // =========================
          if (!isLoading)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = notifications[index];

                return _buildNotificationItem(
                  item["content"] ?? "",
                  item["date"] ?? "",
                  item["image"] ?? "",

                  icon: item["type"] == "accept"
                      ? Icons.check_circle
                      : item["type"] == "offer"
                      ? Icons.local_offer
                      : Icons.notifications,

                  iconColor: item["type"] == "accept"
                      ? Colors.green
                      : item["type"] == "offer"
                      ? Colors.orange
                      : Colors.blue,

                  isAction: item["isAction"] ?? false,

                  mainColor: mainColor,
                );
              }, childCount: notifications.length),
            ),
        ],
      ),

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey,

        currentIndex: 3,

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

  // =========================
  // ITEM UI (GIỮ NGUYÊN GIAO DIỆN)
  // =========================
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
              // =========================
              // AVATAR
              // =========================
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,

                    backgroundImage: imagePath.startsWith("http")
                        ? NetworkImage(imagePath)
                        : AssetImage(imagePath) as ImageProvider,
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

              // =========================
              // CONTENT
              // =========================
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

                    // =========================
                    // ACTION BUTTON
                    // =========================
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
