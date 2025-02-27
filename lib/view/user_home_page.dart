import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wed_crew/view/basic_package_home.dart';
import 'package:wed_crew/view/decoration_page.dart';
import 'package:wed_crew/view/luxury_package_home.dart';
import 'package:wed_crew/view/makeup_page.dart';
import 'package:wed_crew/view/photography_list_page.dart';
import 'package:wed_crew/view/premium_package_home.dart';
import 'package:wed_crew/view/service_list_page.dart';
import 'package:wed_crew/view/user_profile.dart';
import 'package:wed_crew/view/venue_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final List<String> imageUrls = [
    'assets/image/basic.png',
    'assets/image/premium.png',
    'assets/image/luxury.png',
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
      backgroundColor: Colors.black,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          _buildHomePage(),
          ServiceListPage(),
          const UserProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text("Welcome Ardra!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 20),
            const Text('Select Your Wedding Package', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 20),
            _buildCarousel(),
            const SizedBox(height: 40),
            const Text('Our Services', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            _buildServiceList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        hintText: 'Search for services...',
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInOut,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: imageUrls.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(url, fit: BoxFit.cover, width: double.infinity),
        );
      }).toList(),
    );
  }

  Widget _buildServiceList() {
    final services = [
      {'title': 'Photography', 'image': 'assets/image/photography.jpg', 'page': PhotographyPage()},
      {'title': 'Venue', 'image': 'assets/image/venue.jpg', 'page': VenuePage()},
      {'title': 'Decoration', 'image': 'assets/image/decoration.jpg', 'page': DecorationPage()},
      {'title': 'Makeup', 'image': 'assets/image/makeup.jpg', 'page': MakeupPage()},
    ];

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => services[index]['page'] as Widget));
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[900],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(services[index]['image'] as String, width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 10),
                  Text(services[index]['title'] as String, style: const TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
