import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class AddPhotosPage extends StatefulWidget {
  const AddPhotosPage({super.key});

  @override
  State<AddPhotosPage> createState() => _AddPhotosPageState();
}

class _AddPhotosPageState extends State<AddPhotosPage> {
  final Color mainColor = const Color(0xFF00C9A7);

  Uint8List? imageBytes;

  List<String> images = [
    'assets/images/add1.jpg',
    'assets/images/add2.jpg',
    'assets/images/add3.jpg',
    'assets/images/add4.jpg',
    'assets/images/add5.jpg',
    'assets/images/add6.jpg',
  ];

  // =========================
  // PICK IMAGE
  // =========================
  Future pickImage() async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      imageBytes = await picked.readAsBytes();
      setState(() {});
    }
  }

  // =========================
  // UPLOAD IMAGE
  // =========================
  Future<String?> uploadImage(Uint8List bytes) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("http://localhost:3000/api/upload"),
      );

      request.files.add(
        http.MultipartFile.fromBytes("image", bytes, filename: "image.jpg"),
      );

      var response = await request.send();
      var resBody = await response.stream.bytesToString();

      final data = jsonDecode(resBody);
      return data["imageUrl"];
    } catch (e) {
      print("UPLOAD ERROR: $e");
      return null;
    }
  }

  // =========================
  // DONE
  // =========================
  Future done() async {
    if (imageBytes != null) {
      String? url = await uploadImage(imageBytes!);

      if (url != null) {
        setState(() {
          images.add(url);
        });
      }
    }

    Navigator.pop(context, images);
  }

  // =========================
  // UI
  // =========================
  @override
  Widget build(BuildContext context) {
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
          "Add Photos",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),

        actions: [
          TextButton(
            onPressed: done,
            child: Text(
              "DONE",
              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // ❌ ĐÃ XÓA "No image selected"
          // ❌ ĐÃ XÓA Pick Photo button
          const SizedBox(height: 10),

          // =========================
          // GRID ẢNH
          // =========================
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: images.length + 1,

              itemBuilder: (context, index) {
                // 👉 Ô CAMERA (chọn ảnh)
                if (index == 0) {
                  return GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColor),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.camera_alt, color: mainColor, size: 40),
                    ),
                  );
                }

                String img = images[index - 1];

                return Image(
                  image: img.startsWith("http")
                      ? NetworkImage(img)
                      : AssetImage(img) as ImageProvider,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
