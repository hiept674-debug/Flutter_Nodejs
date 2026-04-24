import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controller cho các trường nhập liệu
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  int userType = 1; // 1: Traveler, 2: Guide
  String error = '';
  final Color mainColor = const Color(0xFF00C9A7);

  void signUp() async {
    try {
      final url = Uri.parse("http://localhost:3000/api/signup");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstName": firstNameCtrl.text,
          "lastName": lastNameCtrl.text,
          "email": emailCtrl.text,
          "password": passCtrl.text,
          "country": countryCtrl.text,
          "userType": userType,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // ✅ Hiện thông báo
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(data['message'])));

        // ✅ Quay về login
        Navigator.pop(context);
      } else {
        setState(() {
          error = data['message'];
        });
      }
    } catch (e) {
      setState(() {
        error = "Không kết nối được server";
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
            // --- HEADER BO CONG ---
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
              child: const Center(
                child: Icon(Icons.beach_access, color: Colors.white, size: 50),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),
                  // --- CHỌN TRAVELER / GUIDE ---
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: userType,
                        activeColor: mainColor,
                        onChanged: (val) =>
                            setState(() => userType = val as int),
                      ),
                      const Text("Traveler"),
                      const SizedBox(width: 20),
                      Radio(
                        value: 2,
                        groupValue: userType,
                        activeColor: mainColor,
                        onChanged: (val) =>
                            setState(() => userType = val as int),
                      ),
                      const Text("Guide"),
                    ],
                  ),

                  const SizedBox(height: 15),
                  // --- HỌ VÀ TÊN ---
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          firstNameCtrl,
                          "First Name",
                          "Yoo",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildTextField(
                          lastNameCtrl,
                          "Last Name",
                          "Jin",
                        ),
                      ),
                    ],
                  ),

                  _buildTextField(countryCtrl, "Country", "Vietnam"),
                  _buildTextField(emailCtrl, "Email", "yoojin@gmail.com"),
                  _buildTextField(passCtrl, "Password", "••••••", isPass: true),
                  _buildTextField(
                    confirmCtrl,
                    "Confirm Password",
                    "••••••",
                    isPass: true,
                  ),

                  if (error.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),

                  const SizedBox(height: 20),
                  const Text(
                    "By Signing Up, you agree to our Terms & Conditions",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),

                  const SizedBox(height: 25),
                  // --- NÚT SIGN UP ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper để tạo TextField nhanh
  Widget _buildTextField(
    TextEditingController ctrl,
    String label,
    String hint, {
    bool isPass = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: ctrl,
        obscureText: isPass,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
        ),
      ),
    );
  }
}
