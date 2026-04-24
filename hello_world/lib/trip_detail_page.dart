import 'package:flutter/material.dart';

class TripDetailPage extends StatelessWidget {
  const TripDetailPage({super.key});

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
          "Trip Detail",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Ảnh địa danh và Avatar Guide
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/a.jpg', // Dùng ảnh cầu rồng bạn đã có
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                    bottom: 10,
                    left: 15,
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white, size: 18),
                        Text(
                          " Danang, Vietnam",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Avatar hình tròn có viền xanh
                  Positioned(
                    bottom: -30,
                    right: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: mainColor, width: 3),
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          'assets/images/avartar.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // 2. Thông tin chi tiết (Date, Time, Guide...)
              _buildInfoRow("Date", "Feb 2, 2020"),
              _buildInfoRow("Time", "8:00AM - 10:00AM"),
              _buildInfoRow("Guide", "Emmy", valueColor: mainColor),
              _buildInfoRow("Number of Travelers", "2"),

              const SizedBox(height: 20),
              const Text(
                "Attractions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // 3. Danh sách địa điểm (Chips)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildAttractionChip("Ho Guom"),
                  _buildAttractionChip("Ho Hoan Kiem"),
                  _buildAttractionChip("Pho 12 Pho Kim Ma"),
                ],
              ),

              const SizedBox(height: 30),
              const Divider(),

              // 4. Phần giá tiền (Fee)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Fee",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$20.00",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 5. Nút Mark Finished
              SizedBox(
                width: 150,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check, color: Colors.black54),
                  label: const Text(
                    "Mark Finished",
                    style: TextStyle(color: Colors.black54),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm tạo dòng thông tin trái-phải
  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tạo chip địa điểm
  Widget _buildAttractionChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on, color: Color(0xFF00C9A7), size: 16),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
