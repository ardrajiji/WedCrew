import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wed_crew/view/user_modules/package_booking_view/model/package_view_model.dart';
import 'package:wed_crew/view/user_modules/package_booking_view/service/package_service.dart';

class MarriageEventsPage extends StatelessWidget {
  const MarriageEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upcoming Marriage Events',
          style: TextStyle(fontSize: screenSize.width * 0.05),
        ),
      ),
      body: FutureBuilder<List<PackageBookingView>>(
        future: packageHistoryList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

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
                    "Error loading events",
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/empty_list.jpg',
                    width: screenSize.width * 0.6,
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Text(
                    "No upcoming events found",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final event = snapshot.data![index];
              return EventCard(event: event, screenSize: screenSize);
            },
          );
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final PackageBookingView event;
  final Size screenSize;

  const EventCard({super.key, required this.event, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    final formattedDate = event.dateOfMarriage != null 
        ? DateFormat('MMM dd, yyyy').format(event.dateOfMarriage!)
        : 'Date not specified';
    
    final daysLeft = event.dateOfMarriage != null 
        ? event.dateOfMarriage!.difference(DateTime.now()).inDays 
        : 0;

    return Card(
      margin: EdgeInsets.all(screenSize.width * 0.03),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + Package
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    event.name ?? 'No name',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (event.eventPackageName != null)
                  Chip(
                    label: Text(
                      event.eventPackageName!.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenSize.width * 0.03,
                      ),
                    ),
                    backgroundColor: event.eventPackageName!.toLowerCase() == 'premium'
                        ? Colors.deepPurple
                        : Colors.blue,
                  ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.01),

            // Date & Location
            Row(
              children: [
                Icon(Icons.calendar_today, size: screenSize.width * 0.04),
                SizedBox(width: screenSize.width * 0.02),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: screenSize.width * 0.035),
                ),
                SizedBox(width: screenSize.width * 0.04),
                Icon(Icons.location_on, size: screenSize.width * 0.04),
                SizedBox(width: screenSize.width * 0.02),
                Flexible(
                  child: Text(
                    event.location ?? 'Location not specified',
                    style: TextStyle(fontSize: screenSize.width * 0.035),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.01),

            // Participants & Days Left
            Row(
              children: [
                Icon(Icons.people, size: screenSize.width * 0.04),
                SizedBox(width: screenSize.width * 0.02),
                Text(
                  '${event.numberOfParticipants ?? 0} participants',
                  style: TextStyle(fontSize: screenSize.width * 0.035),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    '$daysLeft days left',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenSize.width * 0.03,
                    ),
                  ),
                  backgroundColor: daysLeft < 7 ? Colors.red : Colors.green,
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.01),

            // Contact info
            Row(
              children: [
                Icon(Icons.phone, size: screenSize.width * 0.04),
                SizedBox(width: screenSize.width * 0.02),
                Text(
                  event.mobileNumber ?? 'No phone number',
                  style: TextStyle(fontSize: screenSize.width * 0.035),
                ),
                SizedBox(width: screenSize.width * 0.04),
                Icon(Icons.email, size: screenSize.width * 0.04),
                SizedBox(width: screenSize.width * 0.02),
                Flexible(
                  child: Text(
                    event.email ?? 'No email',
                    style: TextStyle(fontSize: screenSize.width * 0.035),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.01),

            // View Details Button
           
          ],
        ),
      ),
    );
  }
}
