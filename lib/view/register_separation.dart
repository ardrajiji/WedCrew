import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/user_register/page/registration.dart';
import 'package:wed_crew/view/vendor_module/vendor_register/page/vendor_signup.dart';

class SignUpSelectionPage extends StatelessWidget {
  const SignUpSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              // Glassmorphic Card
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), // Glassmorphic effect
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Join Us",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Sign Up as a User Button
                        ElevatedButton(
                          onPressed: () {
                           Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserRegistration(),
                        ),
                      );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(194, 154, 119, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            "Sign Up as a User",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Sign Up as a Vendor Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(29, 107, 59, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            "Sign Up as a Vendor",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
