import 'package:flutter/material.dart';
import 'my_trip.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  String error = '';

  bool isLoading = false;

  final Color mainColor = const Color(0xFF00C9A7);

  // =========================
  // LOGIN API + AUTH
  // =========================
  void login() async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:3000/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": userCtrl.text.trim(),
          "password": passCtrl.text.trim(),
        }),
      );

      debugPrint(response.body);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // =========================
        // LƯU TOKEN
        // =========================
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", data["token"]);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyTripsPage()),
        );
      } else {
        setState(() {
          error = data["message"];
        });
      }
    } catch (e) {
      debugPrint(e.toString());

      setState(() {
        error = "Không kết nối server";
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
            // =========================
            // HEADER
            // =========================
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

            // =========================
            // FORM
            // =========================
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

                  // =========================
                  // EMAIL
                  // =========================
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

                  // =========================
                  // PASSWORD
                  // =========================
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

                  // =========================
                  // ERROR
                  // =========================
                  if (error.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),

                      child: Text(
                        error,

                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),

                  // =========================
                  // FORGOT PASSWORD
                  // =========================
                  Align(
                    alignment: Alignment.centerRight,

                    child: TextButton(
                      onPressed: () {
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

                  // =========================
                  // LOGIN BUTTON
                  // =========================
                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: isLoading ? null : login,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                        elevation: 0,
                      ),

                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
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

                  // =========================
                  // SOCIAL BUTTON
                  // =========================
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

                  // =========================
                  // SIGN UP
                  // =========================
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

  // =========================
  // SOCIAL BUTTON
  // =========================
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
