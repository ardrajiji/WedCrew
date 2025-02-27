import 'package:flutter/material.dart';
import 'package:wed_crew/view/basic_package_booking.dart';

class BasicPackageHome extends StatelessWidget {
  const BasicPackageHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Combined Package Data (Package Details + Extra Services)
    final List<Map<String, dynamic>> packageData = [
      {"title": "Maximum Guests", "value": "100 People"},
      {"title": "Total Package Price", "value": "₹ 50,000"},
      {"title": "Additional Services", "value": [
        "Customized Makeup & Hairstyling",
        "Luxury Decor Upgrades",
        "Full-Day Photography & Videography",
        "Catering & Banquet Arrangements",
        "Live Music & Entertainment"
      ]},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bridal Package",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'PlayfairDisplay'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Package Title
            const Text(
              "Basic Bridal Package",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'PlayfairDisplay',
              ),
            ),
            const SizedBox(height: 10),

            // Service Description
            const Text(
              "Our Basic Bridal Package is perfect for couples looking for an elegant yet affordable wedding experience. "
              "This package includes bridal and groom wear rentals, professional makeup services, a beautifully arranged venue "
              "with minimal decor, and 6 hours of professional photography to capture your special moments. "
              "We also assist with venue booking to make your day stress-free.",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                  fontFamily: 'Lato'),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Package Details and Extra Services
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink[50]!, Colors.purple[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: packageData.map((data) {
                  if (data["value"] is List<String>) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["title"],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PlayfairDisplay'),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: (data["value"] as List<String>)
                              .map((service) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.check_circle,
                                            color: Colors.green, size: 18),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            service,
                                            style: const TextStyle(
                                                fontSize: 16, fontFamily: 'Lato'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data["title"],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Lato'),
                          ),
                          Text(
                            data["value"],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Lato'),
                          ),
                        ],
                      ),
                    );
                  }
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),

            // Book Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BasicPackageBooking()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  elevation: 5,
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
