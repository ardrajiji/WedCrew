import 'package:flutter/material.dart';
import 'package:wed_crew/view/photography_booking_page.dart';

class PhotographyVendorPage extends StatelessWidget {
  final Map<String, dynamic> vendor = {
    'name': 'Studio One Photography',
    'address': '123, Photography Street, Thrissur,kerala,India',
    'phone': '+91 9876543210',
    'email': 'studioone@email.com',
    'price': 150000.0,
    'images': [
      'assets/image/photography.jpg',
      'assets/image/photography.jpg',
      'assets/image/photography.jpg',
      'assets/image/photography.jpg',
      'assets/image/photography.jpg',
    ],
  };

  PhotographyVendorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vendor['name']),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("Sample Photographs:",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: vendor['images'].map<Widget>((image) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          image,
                          width: 250, // Increased width
                          height: 600, // Increased height
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Text(vendor['name'],
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey),
                  SizedBox(width: 5),
                  Expanded(
                      child: Text(vendor['address'],
                          style: TextStyle(fontSize: 16, color: Colors.black))),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(vendor['phone'],
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.grey),
                  SizedBox(width: 5),
                  Expanded(
                      child: Text(vendor['email'],
                          style: TextStyle(fontSize: 16, color: Colors.black))),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.money_sharp, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(' Starts from ₹${vendor['price']}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700])),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhotographyVendorDetailsPage(vendor: vendor),
                      ),
                    );
                  },
                  child: Text("View Services",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
