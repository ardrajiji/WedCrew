import 'package:flutter/material.dart';
import 'package:wed_crew/view/basic_package_booking.dart';

class BasicPackageHome extends StatelessWidget {
  const BasicPackageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bridal Package"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Package Title
                  Text(
                    "Basic Bridal Package",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Package Image
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(15),
                  //   child: Image.asset(
                  //     'assets/image/bridal_package.jpg', // Add your image in assets
                  //     height: 180,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),

                  SizedBox(height: 20),

                  // Package Details
                  _buildFeature(
                      Icons.shopping_bag, "Bridal & Groom Wear Rental"),
                  _buildFeature(Icons.brush, "Basic Makeup Services"),
                  _buildFeature(Icons.local_florist, "Minimal Decor Setup"),
                  _buildFeature(Icons.photo_camera, "6 Hours of Photography"),
                  _buildFeature(Icons.event, "Venue Booking Assistance"),
                  _buildFeature(Icons.money, "Affordable for Small Weddings"),

                  SizedBox(height: 20),

                  // Book Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add booking action
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BasicPackageBooking()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to create a feature with an icon
  Widget _buildFeature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 15,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
