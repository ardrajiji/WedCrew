import 'package:flutter/material.dart';
import 'package:wed_crew/view/photography_list_page.dart';
import 'package:wed_crew/view/venue_page.dart';
import 'package:wed_crew/view/decoration_page.dart';
import 'package:wed_crew/view/makeup_page.dart';

class ServiceListPage extends StatelessWidget {
  ServiceListPage({super.key});

  final List<Map<String, dynamic>> services = [
    {
      'title': 'Photography',
      'icon': Icons.camera_alt,
      'image': 'assets/image/photography.jpg',
      'page': PhotographyPage(),
    },
    {
      'title': 'Venue',
      'icon': Icons.other_houses,
      'image': 'assets/image/venue.jpg',
      'page': VenuePage(),
    },
    {
      'title': 'Decoration',
      'icon': Icons.celebration,
      'image': 'assets/image/decoration.jpg',
      'page': DecorationPage(),
    },
    {
      'title': 'Makeup',
      'icon': Icons.brush,
      'image': 'assets/image/makeup.jpg',
      'page': MakeupPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Services"),
        backgroundColor: const Color.fromARGB(255, 0, 128, 129),
      ),
      backgroundColor: const Color.fromARGB(244, 246, 244, 226),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // 1 columns
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.0, // Square shape
          ),
          itemBuilder: (context, index) {
            return _buildServiceCard(
              context,
              services[index]['title'],
              services[index]['icon'],
              services[index]['image'],
              services[index]['page'],
            );
          },
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String title, IconData icon, String imagePath, Widget destinationPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
