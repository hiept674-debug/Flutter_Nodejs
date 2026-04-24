import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFF00C9A7);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Inbox",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Thanh tìm kiếm (Search Bar)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Chat",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // 2. Danh sách tin nhắn
          Expanded(
            child: ListView(
              children: [
                _buildChatItem(
                  "Emmy",
                  "Hahaha, that's funny",
                  "3:43 PM",
                  'assets/images/avartar.png', // Thay bằng file ảnh của bạn
                  isUnread: true,
                ),
                _buildChatItem(
                  "Tuan Tran",
                  "Hello! I'm Tuan Tran. I'm a guide...",
                  "1:30 PM",
                  'assets/images/avartar.png',
                ),
                _buildChatItem(
                  "Kien Nguyen",
                  "See you then!",
                  "Jan 28",
                  'assets/images/avartar.png',
                ),
                _buildChatItem(
                  "Hieu Trung",
                  "You're welcome!",
                  "Jan 25",
                  'assets/images/avartar.png',
                ),
              ],
            ),
          ),
        ],
      ),
      // Giữ nguyên BottomNavigationBar từ trang My Trips
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey,
        currentIndex: 2, // Chat là mục thứ 3 (index 2)
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: "Chat"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }

  // Widget con cho từng dòng hội thoại
  Widget _buildChatItem(
    String name,
    String message,
    String time,
    String imagePath, {
    bool isUnread = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Stack(
        children: [
          CircleAvatar(radius: 28, backgroundImage: AssetImage(imagePath)),
          // Dấu chấm xanh online (nếu cần)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF00C9A7),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: isUnread ? Colors.black : Colors.grey,
          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: Text(
        time,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      onTap: () {
        // Sau này sẽ dẫn vào trang chat chi tiết với từng người
      },
    );
  }
}
