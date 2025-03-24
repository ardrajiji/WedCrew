import 'package:flutter/material.dart';
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/package_book_form/page/booking_form.dart';
import 'package:wed_crew/view/user_modules/package_content/model/package_selection_model.dart';
import 'package:wed_crew/view/user_modules/package_content/service/basic_package_service.dart';

class PackageDetailsPage extends StatelessWidget {
  final String package_id;

  const PackageDetailsPage({super.key, required this.package_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Details'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 44, 146, 88),
      ),
      body: FutureBuilder<PackageSelectionModel>(
        future: singlePackageService(package_id: package_id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}",
                  style: const TextStyle(fontSize: 18, color: Colors.black54)),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
                child: Text("No package details found",
                    style: TextStyle(fontSize: 18, color: Colors.black54)));
          }

          final packageData = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Package Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    '${UserUrl.baseUrl}/${packageData.image}', // Update the path as per your project structure
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
            
                // Package Name
                Text(
                  packageData.name.toString().toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 10),
            
                // Package Price
                Text(
                  "Price: ${packageData.price}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
            
                // Maximum Guests
                Text(
                  "Max Guests: ${packageData.maxGuests}",
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
                  packageData.services ?? "No services listed",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 20),
            
                // Extra Services (if available)
                if (packageData.extraServices?.isNotEmpty ?? false)
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
                        packageData.extraServices!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PackageBookingForm(
                              package_id: packageData.id!.toString(
                              ), amount: packageData.price!,),
                        ),
                      );
                    }, // Fixed this parenthesis and comma here!
                              
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
