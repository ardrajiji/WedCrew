

import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/user_home/page/user_home_page.dart';
import 'package:wed_crew/view/user_view_bookings.dart';
import 'package:wed_crew/view/vendor_module/bookigs_view/page/vendor_booking.dart';
import 'package:wed_crew/view/vendor_module/portfolio/page/protfoilo_page.dart';
import 'package:wed_crew/view/vendor_module/vendor_profile/page/vendor_profile.dart';
import 'package:wed_crew/view/vendor_module/service_display/page/vendor_service.dart';
import 'package:wed_crew/view/vendor_module/vendor_register/page/vendor_signup.dart';

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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              title: const Text("WEDCREW"),
              backgroundColor: const Color.fromARGB(255, 240, 244, 243),
            )
          : null,
      drawer: _currentIndex == 0
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 231, 239, 199),
                    ),
                    child: Text(
                      'Welcome to WEDCREW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('SignUp'),
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const SignUpPage(),
                    //     ),
                    //   );
                    // },
                  ),
                  ListTile(
                    leading: const Icon(Icons.visibility),
                    title: const Text('User home'),
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const UserHomePage()),
                    //   );
                    // },
                  ),
                  ListTile(
                    leading: const Icon(Icons.charging_station_outlined),
                    title: const Text('View user side booking '),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  BookingRequestPage()),
                      );
                    },
                  ),
                //   ListTile(
                //     leading: const Icon(Icons.history),
                //     title: const Text('View Purchase History'),
                //     onTap: () {
                     
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const PurchaseHistoryPage()),
                //       );
                //     },
                //   ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () async {
                      // await PreferenceValues.userLogout();
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const LoginPage()),
                      // );
                    },
                  ),
                ],
              ),
            )
          : null,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(206, 206, 206, 0.995),
                  Color.fromARGB(255, 230, 244, 241),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              // Home Page
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
                          SizedBox(height: screenHeight * 0.01),
                          const Text(
                            'Explore our services  with ease.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
               VendorServicePage(),
               ViewBookingPage(),
               ShopPortfolioPage(),
               VendorProfileScreen(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ''),
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
        selectedItemColor:  Colors.black,
        unselectedItemColor:  Colors.grey,
      ),
    );
  }
}
