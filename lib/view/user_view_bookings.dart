import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_booking_confirm.dart';

class BookingRequestPage extends StatefulWidget {
  const BookingRequestPage({super.key});

  @override
  _BookingRequestPageState createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  List<Map<String, dynamic>> bookingDetails = [
    {
      'vendor_image': 'assets/images/vendor1.jpg',
      'service_list': ['3 Functions - 4 Member Team'],
      'price': '150000',
      'date': '2025-03-10',
      'time': '5:00 PM',
      'address': '123 Wedding Street, City',
      'email': 'vendor@example.com',
      'phone': '+91 9876543210',
      'advance': '50000',
      'status': 'Requested',
    },
    {
      'vendor_image': 'assets/images/vendor2.jpg',
      'service_list': ['4 Functions - 5 Member Team'],
      'price': '180000',
      'date': '2025-04-15',
      'time': '6:00 PM',
      'address': '456 Celebration Avenue, City',
      'email': 'vendor@example.com',
      'phone': '+91 9876543220',
      'advance': '60000',
      'status': 'Accepted',
    },
    {
      'vendor_image': 'assets/images/vendor2.jpg',
      'service_list': ['4 Functions - 5 Member Team'],
      'price': '180000',
      'date': '2025-04-15',
      'time': '6:00 PM',
      'address': '456 Celebration Avenue, City',
      'email': 'vendor@example.com',
      'phone': '+91 9876543220',
      'advance': '60000',
      'status': 'Rejected',
    },
    {
      'vendor_image': 'assets/images/vendor1.jpg',
      'service_list': ['3 Functions - 4 Member Team'],
      'price': '150000',
      'date': '2025-03-10',
      'time': '5:00 PM',
      'address': '123 Wedding Street, City',
      'email': 'vendor@example.com',
      'phone': '+91 9876543210',
      'advance': '50000',
      'status': 'Unavailable',
    },
  ];

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
          Color statusColor;
          switch (booking['status']) {
            case 'Requested':
              statusColor = Colors.orange;
              break;
            case 'Accepted':
              statusColor = Colors.green;
              break;
            case 'Rejected':
              statusColor = Colors.red;
              break;
            default:
              statusColor = Colors.grey;
          }

          return GestureDetector(
            onTap: booking['status'] == 'Accepted'
                ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserBookingLastPayment(),
                      ),
                    )
                : null,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(booking['vendor_image']),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(booking['email'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(booking['phone'], style: TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text("Date: ${booking['date']}", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Time: ${booking['time']}", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Total Price: ₹${booking['price']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                    Text("Advance Paid: ₹${booking['advance']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        booking['status'],
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


