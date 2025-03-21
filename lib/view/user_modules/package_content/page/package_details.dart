
import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/package_content/model/package_selection_model.dart';
import 'package:wed_crew/view/user_modules/package_content/service/basic_package_service.dart';

class PackageDetailsPage extends StatelessWidget {
  final String package_id;
  final Map<String, dynamic> packageData = {
    "id": 3,
    "image": "assets/image/decor2.jpg",
    "name": "premium",
    "price": "10000.00",
    "max_guests": 1000,
    "services":
        "1. Wedding Photography Capture your special moments with professional wedding photography, ensuring beautiful memories that last a lifetime. \n2. Catering Services Enjoy delicious, high-quality food with customized menus to suit your event, served with excellence.",
    "extra_services": "",
  };

   PackageDetailsPage({super.key,
   required this.package_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Details'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: 
      
      FutureBuilder<PackageSelectionModel>(
        future:singleProductService(package_id: ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}", style: const TextStyle(fontSize: 18, color: Colors.black54)),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No items found", style: TextStyle(fontSize: 18, color: Colors.black54)));
          }
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Package Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets${packageData["image"]}', // Update the path as per your project structure
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
        
              // Package Name
              Text(
                packageData["name"].toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 10),
        
              // Package Price
              Text(
                "Price: \$${packageData["price"]}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
        
              // Maximum Guests
              Text(
                "Max Guests: ${packageData["max_guests"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
        
              // Services
              Text(
                "Services Included:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 10),
              Text(
                packageData["services"],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
        
              // Extra Services (if available)
              if (packageData["extra_services"].isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Extra Services:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      packageData["extra_services"],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
        }
      ),
      //
    );
  }
}
