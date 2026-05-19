import 'package:flutter/material.dart';
import 'trip_detail_page.dart';
import 'inbox_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'add_photos_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyTripsPage extends StatefulWidget {
  const MyTripsPage({super.key});

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  final Color mainColor = const Color(0xFF00C9A7);

  List trips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  // ================= API =================
  Future<void> fetchTrips() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString("token") ?? "";

      final response = await http.get(
        Uri.parse("http://localhost:3000/api/trips"),

        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          trips = data;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });

        debugPrint(data["message"].toString());
      }
    } catch (e) {
      debugPrint("ERROR: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // HEADER
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: mainColor,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "My Trips",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/a.jpg', fit: BoxFit.cover),
                  Container(color: Colors.black.withValues(alpha: 0.2)),
                ],
              ),
            ),
          ),

          // TAB
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  _buildTab("Current Trips", true),
                  _buildTab("Next Trips", false),
                  _buildTab("Past Trips", false),
                  _buildTab("Wish List", false),
                ],
              ),
            ),
          ),

          // BODY
          isLoading
              ? const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildTripCard(context, trips[index]),
                    childCount: trips.isEmpty ? 0 : trips.length,
                  ),
                ),
        ],
      ),

      // FLOAT BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPhotosPage()),
          );
        },
        backgroundColor: mainColor,
        child: const Icon(Icons.add, size: 35),
      ),

      // NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        currentIndex: 1,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InboxPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsPage()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  // ================= CARD =================
  Widget _buildTripCard(BuildContext context, Map trip) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.2), blurRadius: 10),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // căn trái toàn bộ
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              'assets/images/a.jpg',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip['title'] ?? "No Title",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        trip['location'] ?? '',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.access_time, size: 18),
                    const SizedBox(width: 5),
                    Text(trip['time'] ?? '', textAlign: TextAlign.left),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.person, size: 18),
                    const SizedBox(width: 5),
                    Text(trip['guide'] ?? '', textAlign: TextAlign.left),
                  ],
                ),

                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerLeft, // nút căn trái
                  child: OutlinedButton(
                    onPressed: () {
                      print(trip);

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => TripDetailPage(
                            tripId: int.parse(trip["id"].toString()),
                          ),
                        ),
                      );
                    },

                    child: const Text("Detail"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool active) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: active ? mainColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(color: active ? Colors.white : Colors.black),
      ),
    );
  }
}
