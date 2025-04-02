import 'package:flutter/material.dart';
import 'package:wed_crew/view/vendor_module/confirm_booking_view/model/confirm_booking_model.dart';
import 'package:wed_crew/view/vendor_module/confirm_booking_view/service/confirm_booking_service.dart';
import 'package:intl/intl.dart';


class ConfirmedBookingsPage extends StatelessWidget {
  // final List<Map<String, dynamic>> bookings = [
  //   {
  //     "id": 1,
  //     "vendor": 1,
  //     "service_name": "wedding shoot",
  //     "advanced_price": "1000.00",
  //     "date": "2025-04-25",
  //     "address": "asff",
  //     "status": "confirm"
  //   },
  //   {
  //     "id": 4,
  //     "vendor": 1,
  //     "service_name": "wedding shoot",
  //     "advanced_price": "1500.00",
  //     "date": "2025-04-17",
  //     "address": "jyy",
  //     "status": "confirm"
  //   },
  //   {
  //     "id": 6,
  //     "vendor": 1,
  //     "service_name": "wedding shoot",
  //     "advanced_price": "1500.00",
  //     "date": "2025-04-17",
  //     "address": "jyy",
  //     "status": "confirm"
  //   },
  // ];

  const ConfirmedBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirmed Bookings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      ),
      body: FutureBuilder<List<ConfirmBookingModel>>(
        
        future:ConfirmBookingsDisplay() ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/empty_list.jpg',
                    width: 300,
                  ),
                  Text(
                    "Booking is Empty",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No booked services found"),
            );
          }
         final confirmBookings =snapshot.data!
         .where((booking)=>booking.status =='confirm').toList();

         if (confirmBookings.isEmpty) {
            return const Center(
              child: Text("No booked services found"),
            );
          }


        return ListView.builder(
          itemCount: confirmBookings.length,
          itemBuilder: (context, index) {
            final booking = confirmBookings[index];
            return Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.serviceName!,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text("Date: ${DateFormat('yyyy-MM-dd').format(booking.date!)}",
                        style: TextStyle(fontSize: 16)),
                    Text("Address: ${booking.address}",
                        style: TextStyle(fontSize: 16)),
                    Text("Advance Paid: ₹${booking.advancedPrice}",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.green)),
                  ],
                ),
              ),
            );
          },
        );
        }
      ),
    );
  }
}
