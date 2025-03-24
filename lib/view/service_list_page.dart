import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/photography_list/page/photography_list_page.dart';
import 'package:wed_crew/view/venue_page.dart';
import 'package:wed_crew/view/decoration_page.dart';
import 'package:wed_crew/view/makeup_page.dart';

class ServiceListPage extends StatelessWidget {
  ServiceListPage({super.key});

  final List<Map<String, dynamic>> services = [
    {
      'title': 'Photography',
      'image': 'assets/image/photographer2.jpg',
      'page': PhotographyPage(),
    },
    {
      'title': 'Venue',
      'image': 'assets/image/decor2.jpg',
      'page': VenuePage(),
    },
    {
      'title': 'Decoration',
      'image': 'assets/image/decoration2.jpg',
      'page': DecorationPage(),
    },
    {
      'title': 'Makeup',
      'image': 'assets/image/makeup2.jpg',
      'page': MakeupPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Services"),
        backgroundColor: Color.fromARGB(255, 212, 179, 151),
      ),
      backgroundColor: const Color.fromARGB(244, 242, 248, 243),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            return _buildServiceCard(
              context,
              services[index]['title'],
              services[index]['image'],
              services[index]['page'],
            );
          },
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String title, String imagePath, Widget destinationPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(34, 125, 69, 1)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}