import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/photography_list/page/photography_single_page.dart';

class MakeupPage extends StatefulWidget {
  const MakeupPage({super.key});

  @override
  State<MakeupPage> createState() => _MakeupPageState();
}

class _MakeupPageState extends State<MakeupPage> {
  final List<Map<String, String>> studios = [
    {
      'name': 'DreamLens Studio',
      'place': 'New York, USA',
      'image': 'assets/image/makeup.jpg',
    },
    {
      'name': 'Golden Hour Photography',
      'place': 'Los Angeles, USA',
      'image': 'assets/image/makeup.jpg',
    },
    {
      'name': 'Elegance Clicks',
      'place': 'London, UK',
      'image': 'assets/image/makeup.jpg',
    },
    {
      'name': 'Frame Perfect',
      'place': 'Sydney, Australia',
      'image': 'assets/image/makeup.jpg',
    },
  ];

  List<Map<String, String>> filteredStudios = [];

  @override
  void initState() {
    super.initState();
    filteredStudios = List.from(studios); // Initially, show all studios
  }

  void _filterStudios(String query) {
    setState(() {
      filteredStudios = studios
          .where((studio) =>
              studio['name']!.toLowerCase().contains(query.toLowerCase()) ||
              studio['place']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MakeUp  Studios"),
        backgroundColor: const Color(0xFFB2C8ED),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: _filterStudios,
              decoration: InputDecoration(
                hintText: "Search makeup studios...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ),

          // ListView of Studios
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudios.length,
              itemBuilder: (context, index) {
                final studio = filteredStudios[index];

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         PhotographyStudioDetail(studio: studio),
                        //   ),
                        // );
                      },
                      child: Stack(
                        children: [
                          // Background Image with Blur Effect
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                  sigmaX: 2, sigmaY: 2), // Adjust blur level
                              child: Image.asset(
                                studio['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 180,
                              ),
                            ),
                          ),

                          // Dark overlay for better text visibility
                          Container(
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black38,
                              //color: Colors.black.withOpacity(0.3), // Dark overlay
                            ),
                          ),

                          // Studio details
                          Positioned(
                            bottom: 20,
                            left: 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  studio['name']!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: Colors.white, size: 16),
                                    const SizedBox(width: 5),
                                    Text(
                                      studio['place']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
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
                    const SizedBox(height: 15), // Adds space between each item
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
