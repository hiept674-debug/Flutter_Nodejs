import 'package:flutter/material.dart';

class AddPhotosPage extends StatelessWidget {
  const AddPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFF00C9A7);

    // Danh sách ảnh giả lập để hiển thị
    final List<String> images = [
      'assets/images/add1.jpg',
      'assets/images/add2.jpg',
      'assets/images/add3.jpg',
      'assets/images/add4.jpg',
      'assets/images/add5.jpg',
      'assets/images/add6.jpg',
      'assets/images/add7.jpg',
      'assets/images/add3.jpg',
    ];

    // Trạng thái chọn ảnh giả lập (trong thực tế bạn sẽ dùng State)
    final List<bool> selectedStatus = [
      false,
      true,
      false,
      false,
      true,
      true,
      false,
      false,
    ];

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
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "DONE",
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Hiển thị 3 ảnh trên 1 hàng
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: images.length + 1, // +1 cho ô "Take Photo"
        itemBuilder: (context, index) {
          if (index == 0) {
            // Ô đầu tiên: Nút chụp ảnh
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor.withOpacity(0.5)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined, color: mainColor, size: 30),
                    const SizedBox(height: 8),
                    Text(
                      "Take Photo",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Các ô hiển thị ảnh từ thư viện
          int imageIndex = index - 1;
          bool isSelected = selectedStatus[imageIndex];

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(images[imageIndex], fit: BoxFit.cover),
              // Lớp phủ mờ khi ảnh được chọn
              if (isSelected) Container(color: Colors.white.withOpacity(0.2)),
              // Vòng tròn check chọn ảnh
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? mainColor
                        : Colors.white.withOpacity(0.5),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Icon(
                    isSelected ? Icons.check : null,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
