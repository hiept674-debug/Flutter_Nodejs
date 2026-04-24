import 'package:flutter/material.dart';
import 'my_trip.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  String error = '';
  final Color mainColor = const Color(
    0xFF00C9A7,
  ); // Màu xanh đặc trưng trong ảnh

  void login() async {
    final prefs = await SharedPreferences.getInstance();

    // Lấy dữ liệu đã lưu
    String? savedUser = prefs.getString(
      'username',
    ); // Đây là Email ta đã lưu ở trên
    String? savedPass = prefs.getString('password');

    // Chuyển controller text thành biến để xử lý trim()
    String inputUser = userCtrl.text.trim();
    String inputPass = passCtrl.text;

    if (savedUser == null || savedPass == null) {
      setState(() => error = 'Chưa có tài khoản, vui lòng đăng ký');
      return;
    }

    // So khớp dữ liệu
    if (inputUser == savedUser && inputPass == savedPass) {
      setState(() => error = ''); // Xóa lỗi cũ
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyTripsPage()),
      );
    } else {
      setState(() => error = 'Sai email hoặc mật khẩu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER BO CONG ---
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            // --- FORM NHẬP LIỆU ---
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Welcome back, Yoo Jin",
                    style: TextStyle(color: mainColor, fontSize: 18),
                  ),

                  const SizedBox(height: 40),
                  // Username Field
                  TextField(
                    controller: userCtrl,
                    decoration: InputDecoration(
                      labelText: "Email/Username",
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

                  const SizedBox(height: 25),
                  // Password Field
                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "••••••",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                    ),
                  ),

                  // Báo lỗi nếu có
                  if (error.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // THÊM SỰ KIỆN CHUYỂN TRANG TẠI ĐÂY
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Nút Sign In
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      "or sign in with",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Social Media Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialBtn(Icons.facebook, Colors.blue),
                      const SizedBox(width: 20),
                      _buildSocialBtn(Icons.chat_bubble, Colors.yellow[700]!),
                      const SizedBox(width: 20),
                      _buildSocialBtn(Icons.phone_android, Colors.green),
                    ],
                  ),

                  const SizedBox(height: 30),
                  // Chuyển sang Sign Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget tạo nút Social nhanh
  Widget _buildSocialBtn(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
