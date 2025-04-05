import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/booking_status/page/bookinglist_page.dart';
import 'package:wed_crew/view/user_modules/service_list_page.dart';
import 'package:wed_crew/view/user_modules/package_content/page/package_details.dart';
import 'package:wed_crew/view/user_modules/user_home/model/home_model.dart';
import 'package:wed_crew/view/user_modules/user_home/service/home_service.dart';
import 'package:wed_crew/view/user_modules/profile/page/user_profile.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final List<Map<String, dynamic>> packages = [
    {
      'image': 'assets/image/img1.png',
    },
    {
      'image': 'assets/image/img3.png',
    },
    {
      'image': 'assets/image/photographer2.jpg',
    },
  ];

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 242, 240, 1),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          _buildHomePage(),
          ServiceListPage(),
          BookingDetailsPage(),
          UserProfile(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onBottomNavTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.refresh, size: 30),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 30),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color.fromRGBO(34, 125, 69, 1),
            unselectedItemColor: Color.fromARGB(255, 122, 120, 119),
            elevation: 10, // Adds a smooth elevation effect
            showUnselectedLabels: true,
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontSize: 12,color: Colors.black),
            backgroundColor: const Color.fromARGB(255, 235, 249, 235),
            
          ),
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Stack(
            children: [
              // Image.asset(
              //   'assets/image/img3.png', // Replace with your image path
              //   fit: BoxFit
              //       .fitHeight, // Ensures the image covers the entire screen
              // ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 5.0, sigmaY: 5.0), // Adjust blur intensity
                  child: Container(
                    color: Colors.black12, // Transparent overlay to apply blur
                  ),
                ),
              ),
            ],
          ),
        ),
        // Content
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Welcome to WedCrew",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 109, 52), // Ensures text is visible on the background
                  ),
                ),
                const SizedBox(height: 20),
                _buildCarousel(),
                const SizedBox(height: 40),
                const Text(
                  'Select Your Wedding Package',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 31, 114, 8), // Adjust for visibility
                  ),
                ),
                const SizedBox(height: 20),
                _buildPackageSelection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPackageSelection() {
    return FutureBuilder<List<HomePackageModel>>(
      future: homePackageService(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Image.asset('assets/images/noResponse.jpg'),
                Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No service found"),
          );
        }

        List<HomePackageModel> categories = snapshot.data!;

        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PackageDetailsPage(
                          package_id: category.id.toString() ?? "0"),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            '${UserUrl.baseUrl}/${category.image}',
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.error,
                              size: 40,
                              color: Colors.red,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 96, 12),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInOut,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: packages.map((package) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(package['image'] as String,
              fit: BoxFit.cover, width: double.infinity),
        );
      }).toList(),
    );
  }
}
