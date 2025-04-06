import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/booking_status/service/booking_list_service.dart';
import 'package:wed_crew/view/user_modules/booking_status/model/booking_list_model.dart';
import 'package:wed_crew/view/user_modules/package_booking_view/page/package_view.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: Color.fromARGB(255, 212, 179, 151),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.access_alarm, color: Color.fromARGB(255, 37, 121, 40),size: 30,),
            onPressed: () {
              // Navigate to the booking screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MarriageEventsPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<BookingListModel>>(
        future: servicehistoryList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // if (snapshot.hasError) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Image.asset(
          //           'assets/image/empty_list.jpg',
          //           width: screenSize.width * 0.6,
          //         ),
          //         SizedBox(height: screenSize.height * 0.02),
          //         Text(
          //           "Error: ${snapshot.error}",
          //           style: TextStyle(
          //             fontSize: screenSize.width * 0.045,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          // }

             if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/empty_list.jpg',
                    width: screenSize.width * 0.6,
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Text(
                    "Booking is Empty",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No bookings found",
                style: TextStyle(fontSize: screenSize.width * 0.045),
              ),
            );
          }

          final bookings = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildBookingCard(
                  context,
                  serviceName: booking.serviceName ?? 'N/A',
                  price: booking.advancedPrice ?? '0.00',
                  time: booking.time ?? '00:00:00',
                  date: booking.date?.toString() ?? 'N/A',
                  address: booking.address ?? 'N/A',
                  status: booking.status?.name.toLowerCase() ?? 'N/A',
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBookingCard(
    BuildContext context, {
    required String serviceName,
    required String price,
    required String time,
    required String date,
    required String address,
    required String status,
  }) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              serviceName,
              style: TextStyle(
                fontSize: isWideScreen ? 22 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow("Date", _formatDate(date), isWideScreen),
            _buildDetailRow("Time", time, isWideScreen),
            _buildDetailRow("Address", address, isWideScreen),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Advance Payment:",
                  style: TextStyle(fontSize: isWideScreen ? 18 : 16),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: isWideScreen ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildDetailRow(String label, String value, bool isWideScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: isWideScreen ? 120 : 80,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'booked':
        return Colors.blue;
      case 'confirm':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'cancelled':
        return Colors.orange;
      default:
        return const Color.fromARGB(255, 86, 160, 68);
    }
  }
}
