import 'package:flutter/material.dart';
import 'package:wed_crew/view/vendor/vendor_service_add.dart';

class VendorServicePage extends StatefulWidget {
  const VendorServicePage({super.key});

  @override
  _VendorServicePageState createState() => _VendorServicePageState();
}

class _VendorServicePageState extends State<VendorServicePage> {
  final List<Map<String, dynamic>> shootOptions = [
    {
      'Name': '3 Functions - 4 Member Team',
      'details':
          '1 Traditional + 1 Candid Photographer, 1 Traditional + 1 Cinematic Videographer\n1 Min Teaser, 4 Min Trailer, 1000 Images\nFull Frame Cameras, Gimbal, and Lights',
      'price': 150000.0,
    },
    {
      'Name': '5 Functions - 5 Member Team',
      'details':
          '1 Traditional + 2 Candid Photographer, 1 Traditional + 1 Cinematic Videographer\n1 Min Teaser, 4 Min Trailer, 1000 Images\nSenior Team, High-end Cameras, Gimbal, and Lights',
      'price': 250000.0,
    },
    {
      'Name': '7 Functions - 6 Member Team',
      'details':
          '1 Traditional + 2 Candid Photographer, 1 Traditional + 2 Cinematic Videographer\n1 Min Teaser, 4 Min Trailer, 2000 Images\nBoutique Wedding Team, Wedding Scripting, Mood Boarding',
      'price': 350000.0,
    },
  ];

  void _deleteOption(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Service"),
        content: Text("Are you sure you want to delete this service?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                shootOptions.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _updateOption(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Service"),
        content: Text("Update functionality will be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: shootOptions.length,
        itemBuilder: (context, index) {
          final option = shootOptions[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option['Name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(option['details']),
                  SizedBox(height: 8),
                  Text('Price: ₹${option['price']}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _updateOption(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _deleteOption(index),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddServicePage()),
          );
        },
        backgroundColor: Colors.black54,
        tooltip: "Add service",
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
