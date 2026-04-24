import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailCtrl = TextEditingController();
  String message = '';
  bool isError = false;
  final Color mainColor = const Color(0xFF00C9A7);

  void resetPassword() async {
    if (emailCtrl.text.isEmpty) {
      setState(() {
        message = 'Vui lòng nhập email của bạn';
        isError = true;
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');

    // Giả lập kiểm tra email trong hệ thống (SharedPreferences)
    if (emailCtrl.text == savedEmail) {
      setState(() {
        message = 'Hướng dẫn khôi phục mật khẩu đã được gửi đến email của bạn.';
        isError = false;
      });
    } else {
      setState(() {
        message = 'Email này chưa được đăng ký trong hệ thống.';
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER BO CONG (Đồng bộ với Sign In/Up) ---
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  // Nút back để quay lại trang Sign In
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Input your email, we will send you an instruction to reset your password.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),
                  // Email Field
                  TextField(
                    controller: emailCtrl,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "yoojin@gmail.com",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                    ),
                  ),

                  // Thông báo lỗi hoặc thành công
                  if (message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: isError ? Colors.red : mainColor,
                          fontSize: 13,
                        ),
                      ),
                    ),

                  const SizedBox(height: 40),
                  // Nút SEND
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "SEND",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: RichText(
                        text: TextSpan(
                          text: "Back to ",
                          style: const TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
