import 'package:flutter/material.dart';
import 'package:wed_crew/view/vendor_module/bookigs_view/page/vendor_booking.dart';
import 'package:wed_crew/view/vendor_module/portfolio/page/protfoilo_page.dart';
import 'package:wed_crew/view/vendor_module/vendor_profile/page/vendor_profile.dart';
import 'package:wed_crew/view/vendor_module/service_display/page/vendor_service.dart';

class VendorHomePages extends StatefulWidget {
  const VendorHomePages({super.key});

  @override
  State<VendorHomePages> createState() => _VendorHomePagesState();
}

class _VendorHomePagesState extends State<VendorHomePages> {
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
 @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(250, 250, 251, 0.996),
          Color.fromARGB(255, 253, 255, 255),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent, // Make Scaffold background transparent
      appBar: _currentIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              title: const Text("WEDCREW"),
              backgroundColor: const Color.fromARGB(255, 240, 244, 243),
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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
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
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'Explore our services with ease.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Image.asset(
                        'assets/image/img2.png',
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.3,
                        fit: BoxFit.fitHeight,
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
              BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.add, size: 30), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.manage_search, size: 30), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.image, size: 30), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: ''),
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
