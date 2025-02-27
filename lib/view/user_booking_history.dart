import 'package:flutter/material.dart';
import 'package:wed_crew/view/basic_package_home.dart';
import 'package:wed_crew/view/decoration_page.dart';
import 'package:wed_crew/view/luxury_package_home.dart';
import 'package:wed_crew/view/makeup_page.dart';
import 'package:wed_crew/view/photography_list_page.dart';
import 'package:wed_crew/view/premium_package_home.dart';
import 'package:wed_crew/view/service_list_page.dart';
import 'package:wed_crew/view/user_profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
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
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 30), label: 'Services'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 30), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 242, 239, 213),
      //appBar: AppBar(title: Text("home"),),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Welcome Ardra!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    //color:  Color(0xFFB2C8ED),
                  ),
                ),
                const Text(
                  'What are you looking for?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(221, 97, 93, 93),
                  ),
                ),
               
                const SizedBox(height: 20),
                const Text(
                  'Our Services',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 240, // Adjusted height to fit two rows
                  child: GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 2, 
                    childAspectRatio: 1, 
                    crossAxisSpacing: 7,
                    children: [
                      _buildServiceCard('Photography', Icons.camera_alt, 'assets/image/photography.jpg', PhotographyPage()),
                      _buildServiceCard('Venue', Icons.other_houses, 'assets/image/venue.jpg', VenuePage()),
                      _buildServiceCard('Decoration', Icons.celebration, 'assets/image/decoration.jpg', DecorationPage()),
                      _buildServiceCard('Makeup', Icons.brush, 'assets/image/makeup.jpg', MakeupPage()),
                    ],
                  ),
                ),

                SizedBox(height: 30,),
                Row(
                  children: [
                    const Text(
                      'Get Started Now!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    // SizedBox(
                    //   width: 100,
                    //   height: 100,
                    //   child: Lottie.asset(
                    //     'assets/icons/arrow.json',
                    //   ),
                    // )
                  ],
                ),
                SizedBox(height: 30,),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.easeInOut,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                  items: imageUrls.map((url) {
                    return GestureDetector(
                      onTap: () {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Clicked on image: $url')),
                        // );

                        if (_currentIndex == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BasicPackageHome()),
                          );
                        } else if (_currentIndex == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PremiumPackageHome()),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LuxuryPackageHome()),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
               
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      String title, IconData icon, String imagePath, Widget destinationPage)
{
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath), // Background image
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 40,
                  color:
                      Colors.white), // Set icon color to white for visibility
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white, // Set text color to white
                  backgroundColor:
                      Colors.black54, // Slight background for readability
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
