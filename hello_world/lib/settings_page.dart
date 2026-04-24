import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFF00C9A7);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Thẻ thông tin người dùng (Profile Card)
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/avartar.png'),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Yoo Jin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Traveler",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  // Nút Edit Profile
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "EDIT PROFILE",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Danh sách các mục cài đặt
            _buildSettingItem(
              Icons.notifications_none,
              "Notifications",
              trailing: Switch(
                value: true,
                onChanged: (val) {},
                activeColor: mainColor,
              ),
            ),
            _buildSettingItem(Icons.public, "Languages"),
            _buildSettingItem(Icons.payment, "Payment"),
            _buildSettingItem(Icons.security, "Privacy & Policies"),
            _buildSettingItem(Icons.mail_outline, "Feedback"),
            _buildSettingItem(Icons.book_outlined, "Usage"),

            const SizedBox(height: 50),

            // 3. Nút Sign out
            TextButton(
              onPressed: () {
                // Xử lý đăng xuất tại đây
              },
              child: const Text(
                "Sign out",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget tạo từng dòng cài đặt
  Widget _buildSettingItem(IconData icon, String title, {Widget? trailing}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.grey, size: 28),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          trailing:
              trailing ??
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 5,
          ),
          onTap: () {},
        ),
        const Divider(height: 1, indent: 30, endIndent: 30), // Đường gạch mờ
      ],
    );
  }
}
