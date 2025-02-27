import 'package:flutter/material.dart';
import 'package:wed_crew/view/photography_booking_form.dart';

class PhotographyVendorDetailsPage extends StatefulWidget {
  const PhotographyVendorDetailsPage({super.key});

  @override
  _PhotographyVendorDetailsPageState createState() =>
      _PhotographyVendorDetailsPageState();
}

class _PhotographyVendorDetailsPageState
    extends State<PhotographyVendorDetailsPage> {
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

  List<bool> selectedItems = [false, false, false];
  double totalPrice = 0.0;

  void calculateTotal() {
    totalPrice = 0.0;
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        totalPrice += shootOptions[i]['price'];
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double convenienceFee = totalPrice * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Text('Photography Booking'),
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: shootOptions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    color: selectedItems[index]
                        ? Colors.deepPurple[100]
                        : Colors.white,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          selectedItems[index] = !selectedItems[index];
                          calculateTotal();
                        });
                      },
                      title: Text(
                        shootOptions[index]['Name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(shootOptions[index]['details']),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('₹${shootOptions[index]['price']}'),
                          if (selectedItems[index])
                            Icon(Icons.check_circle, color: Colors.black),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text('Total Price: ₹${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Convenience Fee (5%): ₹${convenienceFee.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: totalPrice > 0
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PhotographyVendorBookingForm()), // Navigate to BookingPage
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Book Now', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
