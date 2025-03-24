import 'package:flutter/material.dart';
import 'package:wed_crew/view/photography_booking_page.dart';
import 'package:wed_crew/view/user_modules/photography_list/model/photography_model.dart';

class PhotographyVendorPage extends StatefulWidget {
  const PhotographyVendorPage({super.key, required PhotographyModel studio});

  @override
  _PhotographyVendorPageState createState() => _PhotographyVendorPageState();
}

class _PhotographyVendorPageState extends State<PhotographyVendorPage> {
  final Map<String, dynamic> vendor = {
    'name': 'Studio One Photography',
    'address': '123, Photography Street, Thrissur, Kerala, India',
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

  int _currentIndex = 0;

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
              // Large Swipable Image Gallery
              SizedBox(
                height: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      itemCount: vendor['images'].length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _showFullScreenImage(context, vendor['images'][index]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              vendor['images'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    // Indicator Dots
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          vendor['images'].length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: _currentIndex == index ? 12 : 8,
                            height: _currentIndex == index ? 12 : 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Studio Details Card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vendor['name'],
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                      SizedBox(height: 10),
                      _buildDetailRow(Icons.location_on, vendor['address']),
                      _buildDetailRow(Icons.phone, vendor['phone']),
                      _buildDetailRow(Icons.email, vendor['email']),
                      _buildDetailRow(Icons.money, "Starts from ₹${vendor['price']}"),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // View Services Button
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
                        builder: (context) => PhotographyVendorDetailsPage(),
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

  // Widget for Studio Details Row
  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 16, color: Colors.black)),
          ),
        ],
      ),
    );
  }

  // Full-Screen Image Viewer
  void _showFullScreenImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
