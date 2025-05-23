import 'package:flutter/material.dart';
import 'package:wed_crew/view/register_separation.dart';
import 'package:wed_crew/view/utils/preference_values.dart';
import 'package:wed_crew/view/vendor_module/feedback/page/feedback_submit.dart';
import 'package:wed_crew/view/vendor_module/vendor_login/page/vendor_login.dart';
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
                  backgroundColor:
                      Colors.grey, // Optional: Set background color
                  child: Icon(
                    Icons.person, // You can change the icon
                    size: 50, // Adjust size as needed
                    color: Colors.white, // Icon color
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  userProfile.name ?? "No Name",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email,
                        color: Color.fromARGB(255, 87, 82, 87)),
                    title: Text(userProfile.email ?? "No Email"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone,
                        color: Color.fromARGB(255, 63, 58, 63)),
                    title: Text(userProfile.mobileNo ?? "No Phone Number"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone,
                        color: Color.fromARGB(255, 76, 70, 77)),
                    title: Text(userProfile.category ?? "No Category"),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VendorFeedbackScreen()));
                      },
                      icon: const Icon(
                        Icons.feedback,
                        color: Colors.white,
                      ),
                      label: const Text('Feedback'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 40, 124, 77), // Red color for logout button
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              content: const Text(
                                  "Are you sure you want to logout?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await PreferenceValues.vendorLogout();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpSelectionPage()),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text("Logout",
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 218, 73, 73), // Red color for logout
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
