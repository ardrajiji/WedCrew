import 'package:flutter/material.dart';
import 'package:wed_crew/view/vendor_module/vendor_profile/service/vendor_profile_service.dart';
class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 27, 29),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: vendorProfileService(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error State
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/image/noResponse.jpg', height: 200),
                  const SizedBox(height: 10),
                  Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No user profile found"));
          }

          // Extract data
          final userProfile = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                ),
                const SizedBox(height: 20),
                Text(
                  userProfile.name ?? "No Name",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email, color: Color.fromARGB(255, 87, 82, 87)),
                    title: Text(userProfile.email ?? "No Email"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone, color: Color.fromARGB(255, 63, 58, 63)),
                    title: Text(userProfile.mobileNo ?? "No Phone Number"),
                  ),
                ),
                 Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone, color: Color.fromARGB(255, 76, 70, 77)),
                    title: Text(userProfile.category ?? "No Category"),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing
               
              ],
            ),
          );
        },
      ),
    );
  }

  
}