import 'package:flutter/material.dart';

class ViewBookingPage extends StatelessWidget {
  final List<Map<String, dynamic>> bookingDetails = [
    {
      'service_list': [
        '3 Functions - 4 Member Team',
        '4 Functions - 5 Member Team',
      ],
      'price': '150000',
      'date': '2025-03-10',
      'time': '5:00 PM',
      'address': '123 Wedding Street, City',
      'email': 'user@example.com',
      'phone': '+91 9876543210',
      'advance': '50000',
    },
    {
      'service_list': [
        '3 Functions - 4 Member Team',
        '4 Functions - 5 Member Team',
      ],
      'price': '150000',
      'date': '2025-03-10',
      'time': '5:00 PM',
      'address': '123 Wedding Street, City',
      'email': 'user@example.com',
      'phone': '+91 9876543210',
      'advance': '50000',
    },
  ];

  ViewBookingPage({super.key});

  void _showConfirmationDialog(BuildContext context, String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
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
        title: Text("View Bookings"),
        centerTitle: true,
        backgroundColor: Colors.black26,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: bookingDetails.length,
        itemBuilder: (context, index) {
          final booking = bookingDetails[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selected Services:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (booking['service_list'] as List<String>)
                        .map((service) => Text("• $service", style: TextStyle(fontSize: 16)))
                        .toList(),
                  ),
                  SizedBox(height: 10),
                  Text("Date: ${booking['date']}", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Time: ${booking['time']}", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Address: ${booking['address']}", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Email: ${booking['email']}", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Phone: ${booking['phone']}", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Total Price: ₹${booking['price']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                  Text("Advance Paid: ₹${booking['advance']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showConfirmationDialog(
                            context,
                            "Confirm Booking",
                            "Are you sure you want to confirm this booking?",
                            () {
                              // Handle Confirm Action
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: Text("Confirm"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showConfirmationDialog(
                            context,
                            "Reject Booking",
                            "Are you sure you want to reject this booking?",
                            () {
                              // Handle Reject Action
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text("Reject"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
