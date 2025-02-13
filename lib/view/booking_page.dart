import 'package:flutter/material.dart';

class PhotographyBookingPage extends StatefulWidget {
  const PhotographyBookingPage({super.key});

  @override
  _PhotographyBookingPageState createState() => _PhotographyBookingPageState();
}

class _PhotographyBookingPageState extends State<PhotographyBookingPage> {
  final List<Map<String, dynamic>> shootOptions = [
    {
      'type': 'Photography + Video + Drone',
      'functions': '3 Functions - 4 Member Team',
      'details': '1 Traditional + 1 Candid Photographer, 1 Traditional + 1 Cinematic Videographer\n1 Minute Teaser, 4 Min Trailer. 1 Full-Length Traditional Video, 1000 Images\nFull Frame Cameras, Prime and Wide Lenses, Gimbal, and Lights',
      'price': 150000.0,
    },
    {
      'type': 'Photography + Video + Drone',
      'functions': '5 Functions - 5 Member Team',
      'details': '1 Traditional + 2 Candid Photographer, 1 Traditional + 1 Cinematic Videographer\n1 Minute Teaser, 4 Min Trailer. 1 Full-Length Traditional Video, 1000 Images\nSenior Team\nFull Frame Cameras, Prime and Wide Lenses, Gimbal, and Lights',
      'price': 250000.0,
    },
    {
      'type': 'Photography + Video + Drone',
      'functions': '7 Functions - 6 Member Team',
      'details': '1 Traditional + 2 Candid Photographer, 1 Traditional + 2 Cinematic Videographer\n1 Minute Teaser, 4 Min Trailer. 1 Full-Length Traditional Video, 2000 Images\nBoutique Wedding Team\nWedding Scripting and Mood Boarding\nFull Frame High-end Cameras, Prime and Wide Lenses, Gimbal and Lights',
      'price': 350000.0,
    },
  ];

  List<bool> selectedOptions = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    selectedOptions = List.generate(shootOptions.length, (index) => false);
  }

  void updateTotalPrice() {
    totalPrice = 0.0;
    for (int i = 0; i < shootOptions.length; i++) {
      if (selectedOptions[i]) {
        totalPrice += shootOptions[i]['price'];
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Your Photography Package"),
        backgroundColor: const Color(0xFFB2C8ED),
      ),
    
      // body: 
      // SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         const Text(
      //           "Select Photography Package:",
      //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //         ),
      //         const SizedBox(height: 10),
      //         Column(
      //           children: List.generate(shootOptions.length, (index) {
      //             return Card(
      //               elevation: 4,
      //               child: CheckboxListTile(
      //                 title: Text(shootOptions[index]['functions'], style: const TextStyle(fontWeight: FontWeight.bold)),
      //                 subtitle: Text(shootOptions[index]['details']),
      //                 value: selectedOptions[index],
      //                 onChanged: (bool? value) {
      //                   setState(() {
      //                     selectedOptions[index] = value ?? false;
      //                     updateTotalPrice();
      //                   });
      //                 },
      //                 secondary: Text("₹${shootOptions[index]['price'].toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
      //               ),
      //             );
      //           }),
      //         ),
      //         const SizedBox(height: 20),
      //         Text(
      //           "Total Price: ₹${totalPrice.toStringAsFixed(2)}",
      //           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      //         ),
      //         const SizedBox(height: 30),
      //         SizedBox(
      //           width: double.infinity,
      //           child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               padding: const EdgeInsets.symmetric(vertical: 14),
      //               backgroundColor: Colors.blue,
      //             ),
      //             onPressed: totalPrice == 0.0 ? null : () {
      //               // Handle booking action
      //             },
      //             child: const Text("Proceed to Book", style: TextStyle(fontSize: 18, color: Colors.white)),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
