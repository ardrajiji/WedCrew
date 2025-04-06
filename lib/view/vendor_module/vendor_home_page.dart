import 'package:flutter/material.dart';
import 'package:wed_crew/view/vendor_module/bookigs_view/page/vendor_booking.dart';
import 'package:wed_crew/view/vendor_module/portfolio/page/protfoilo_page.dart';
import 'package:wed_crew/view/vendor_module/vendor_profile/page/vendor_profile.dart';
import 'package:wed_crew/view/vendor_module/service_display/page/vendor_service.dart';
import 'package:carousel_slider/carousel_slider.dart';

class VendorHomePages extends StatefulWidget {
  const VendorHomePages({super.key});

  @override
  State<VendorHomePages> createState() => _VendorHomePagesState();
}

class _VendorHomePagesState extends State<VendorHomePages> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  int _currentCarouselIndex = 0;

  // Sample images for the carousel - replace with your actual images
  final List<String> carouselImages = [
    'assets/image/decor2.jpg',
    'assets/image/decoration2.jpg',
    'assets/image/photography.jpg',
    'assets/image/venue.jpg',
  ];

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(236, 240, 240, 0.996),
            Color.fromARGB(255, 253, 255, 255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _currentIndex == 0
            ? AppBar(
                automaticallyImplyLeading: false,
                title: const Text(
                  "WEDCREW",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 12, 12, 12),
              )
            : null,
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.06),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Column(
                      children: [
                        const Text(
                          'Welcome to WEDCREW',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const Text(
                          'Explore our services with ease.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        // Carousel Slider
                        Column(
                          children: [
                            CarouselSlider(
                              items: carouselImages.map((imagePath) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: screenWidth,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: AssetImage(imagePath),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: screenHeight * 0.4,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentCarouselIndex = index;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  carouselImages.asMap().entries.map((entry) {
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(
                                            _currentCarouselIndex == entry.key
                                                ? 0.9
                                                : 0.4),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.06),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded corners
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black26,
                              //     blurRadius: 8,
                              //     offset: Offset(2, 4),
                              //   ),
                              // ],
                            ),
                            child: Text(
                              "Connecting vendors..\n creating experiences!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Text color
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
            VendorServicePage(),
            BookedServicesScreen(),
            ShopPortfolioPage(),
            VendorProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onBottomNavTapped,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home, size: 30), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add, size: 30), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.manage_search, size: 30), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.image, size: 30), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle, size: 30), label: ''),
              ],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
