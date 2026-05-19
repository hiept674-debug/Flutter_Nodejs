import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TripDetailPage extends StatefulWidget {
  final int tripId;

  const TripDetailPage({super.key, required this.tripId});

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  final Color mainColor = const Color(0xFF00C9A7);

  Map<String, dynamic>? trip;

  bool isLoading = true;

  // =========================
  // GET DETAIL API
  // =========================
  Future<void> getTripDetail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString("token") ?? "";

      final response = await http.get(
        Uri.parse("http://localhost:3000/api/trips/${widget.tripId}"),

        headers: {
          "Authorization": "Bearer $token",

          "Content-Type": "application/json",
        },
      );

      debugPrint("DETAIL STATUS: ${response.statusCode}");
      debugPrint("DETAIL BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          trip = data;
          isLoading = false;
        });
      } else {
        print(data["message"]);

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("DETAIL ERROR: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getTripDetail();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (trip == null) {
      return const Scaffold(body: Center(child: Text("Trip not found")));
    }

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
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // IMAGE
              Stack(
                clipBehavior: Clip.none,

                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child:
                        trip!["image"] != null &&
                            trip!["image"].toString().isNotEmpty
                        ? Image.network(
                            trip!["image"],

                            height: 180,

                            width: double.infinity,

                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/a.jpg",

                            height: 180,

                            width: double.infinity,

                            fit: BoxFit.cover,
                          ),
                  ),

                  Positioned(
                    bottom: 10,

                    left: 15,

                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,

                          color: Colors.white,

                          size: 18,
                        ),

                        Text(
                          " ${trip!["location"] ?? ""}",

                          style: const TextStyle(
                            color: Colors.white,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

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
                          "assets/images/avartar.png",
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Text(
                trip!["title"] ?? "",

                style: const TextStyle(
                  fontSize: 24,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              _buildInfoRow("Date", trip!["date"] ?? ""),

              _buildInfoRow("Time", trip!["time"] ?? ""),

              _buildInfoRow(
                "Guide",

                trip!["guide"] ?? "",

                valueColor: mainColor,
              ),

              _buildInfoRow("Trip ID", trip!["id"].toString()),

              const SizedBox(height: 20),

              const Text(
                "Attractions",

                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 10,

                runSpacing: 10,

                children: [
                  _buildAttractionChip(trip!["location"] ?? ""),

                  _buildAttractionChip("Travel"),

                  _buildAttractionChip("Adventure"),
                ],
              ),

              const SizedBox(height: 30),

              const Divider(),

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

              SizedBox(
                width: 150,

                child: OutlinedButton.icon(
                  onPressed: () {},

                  icon: const Icon(Icons.check, color: Colors.black54),

                  label: const Text(
                    "Mark Finished",

                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
