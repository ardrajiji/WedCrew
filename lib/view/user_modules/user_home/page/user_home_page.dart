import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wed_crew/view/constants/urls.dart';

import 'package:wed_crew/view/luxury_package_home.dart';
import 'package:wed_crew/view/premium_package_home.dart';
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
   // {'image': 'assets/image/basic.png', 'page': PackageDetailsPage(package_id: '',)},
    {'image': 'assets/image/premium.png', 'page': PremiumPackageHome()},
    {'image': 'assets/image/luxury.png', 'page': LuxuryPackageHome()},
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.refresh, size: 30), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromRGBO(34, 125, 69, 1),
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
            const Text("Welcome to WedCrew",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromRGBO(34, 125, 69, 1))),
            
            const SizedBox(height: 20),
           
            _buildCarousel(),
            const SizedBox(height: 40),
             const Text('Select Your Wedding Package',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromRGBO(34, 125, 69, 1))),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            _buildPackageSelection(),
            // const Text('Our Services',
            //     style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromRGBO(34, 125, 69, 1))),
            // // const SizedBox(height: 10),
            // _buildServiceList(),
          ],
        ),
      ),
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
                                builder: (context) =>
                                    PackageDetailsPage(package_id: category.id.toString() ?? "0"),
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
                            '${UserUrl.baseUrl}/${category.image!}',
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) => const Icon(
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
                        category.name!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 78, 2, 91),
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
        height: 300,
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

  // Widget _buildServiceList() {
  //   final services = [
  //     {'title': 'Photography', 'image': 'assets/image/Homephotographer.jpg', 'page': PhotographyPage()},
  //     {'title': 'Venue', 'image': 'assets/image/homeVenue.webp', 'page': VenuePage()},
  //     {'title': 'Decoration', 'image': 'assets/image/homeDecor.jpg', 'page': DecorationPage()},
  //     {'title': 'Makeup', 'image': 'assets/image/homemakeup.jpg', 'page': MakeupPage()},
  //   ];

  //   return SizedBox(
  //     height: 140,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: services.length,
  //       itemBuilder: (context, index) {
  //         return GestureDetector(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => services[index]['page'] as Widget),
  //             );
  //           },
  //           child: Container(
  //             width: 100,
  //             margin: const EdgeInsets.symmetric(horizontal: 8),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(12),
  //               color: const Color.fromRGBO(246, 216, 190, 1),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.circular(8),
  //                   child: Image.asset(services[index]['image'] as String,
  //                       width: 80, height: 80, fit: BoxFit.cover),
  //                 ),
  //                 const SizedBox(height: 10),
  //                 Text(services[index]['title'] as String,
  //                     style: const TextStyle(color: Color.fromRGBO(34, 125, 69, 1), fontSize: 16, fontWeight: FontWeight.bold)),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}