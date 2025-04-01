import 'package:flutter/material.dart';
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/decoration_list/model/decor_model.dart';
import 'package:wed_crew/view/user_modules/photography_services/page/photography_booking_page.dart';

class DecorVendorPage extends StatefulWidget {
  final DecorModel studio;
  
  const DecorVendorPage({super.key, required this.studio});

  @override
  _DecorVendorPageState createState() => _DecorVendorPageState();
}

class _DecorVendorPageState extends State<DecorVendorPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final studio = widget.studio;
    final workImages = studio.workImages ?? [];
    //final firstImage = workImages.isNotEmpty ? workImages[0].image : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(studio.name ?? 'Decor shop'),
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
              if (workImages.isNotEmpty)
                SizedBox(
                  height: 300,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                        itemCount: workImages.length,
                        onPageChanged: (index) {
                          setState(() {


                            
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _showFullScreenImage(
                                context, '${UserUrl.baseUrl}/${workImages[index].image}'),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                '${UserUrl.baseUrl}/${workImages[index].image}',
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.broken_image,
                                        size: 50, color: Colors.grey),
                                  ),
                                ),
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
                            workImages.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentIndex == index ? 12 : 8,
                              height: _currentIndex == index ? 12 : 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.photo_camera, size: 50, color: Colors.grey),
                  ),
                ),

              const SizedBox(height: 20),

              // Studio Details Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studio.name ?? 'Photography Studio',
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      _buildDetailRow(Icons.location_on, studio.address ?? 'Address not available'),
                      _buildDetailRow(Icons.phone, studio.mobileNo ?? 'Phone not available'),
                      _buildDetailRow(Icons.email, studio.email ?? 'Email not available'),
                      _buildDetailRow(Icons.money, "Years in business: ${studio.yearInBusiness ?? 'N/A'}"),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // View Services Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotographyServicePage(vendor_id:studio.vendor.toString() ,),
                      ),
                    );
                  },
                  child: const Text("View Services",
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
  Widget _buildDetailRow(IconData icon, String? text) {
  if (text == null || text.isEmpty) {
    return const SizedBox(); // Return empty widget if no data
  }
  
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

  // Full-Screen Image Viewer
  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}