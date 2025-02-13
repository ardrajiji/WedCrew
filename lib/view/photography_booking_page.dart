import 'package:flutter/material.dart';
import 'package:wed_crew/view/payment.dart';


class PhotographyVendorDetailsPage extends StatefulWidget {
  final Map<String, dynamic> vendor;

  const PhotographyVendorDetailsPage({super.key, required this.vendor});

  @override
  _PhotographyVendorDetailsPageState createState() =>
      _PhotographyVendorDetailsPageState();
}

class _PhotographyVendorDetailsPageState
    extends State<PhotographyVendorDetailsPage> {
  final List<bool> selectedOptions = [false, false, false];
  double totalPrice = 0.0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final List<Map<String, dynamic>> shootOptions = [
    {
      'type': 'Photography + Video + Drone',
      'functions': '3 Functions - 4 Member Team',
      'details':
          '1 Traditional + 1 Candid Photographer, 1 Traditional + 1 Cinematic Videographer\n1 Min Teaser, 4 Min Trailer, 1000 Images\nFull Frame Cameras, Gimbal, and Lights',
      'price': 150000.0,
    },
    {
      'type': 'Photography + Video + Drone',
      'functions': '5 Functions - 5 Member Team',
      'details':
          '1 Traditional + 2 Candid Photographer, 1 Traditional + 1 Cinematic Videographer\n1 Min Teaser, 4 Min Trailer, 1000 Images\nSenior Team, High-end Cameras, Gimbal, and Lights',
      'price': 250000.0,
    },
    {
      'type': 'Photography + Video + Drone',
      'functions': '7 Functions - 6 Member Team',
      'details':
          '1 Traditional + 2 Candid Photographer, 1 Traditional + 2 Cinematic Videographer\n1 Min Teaser, 4 Min Trailer, 2000 Images\nBoutique Wedding Team, Wedding Scripting, Mood Boarding',
      'price': 350000.0,
    },
  ];

  void updateTotalPrice() {
    totalPrice = 0.0;
    for (int i = 0; i < shootOptions.length; i++) {
      if (selectedOptions[i]) {
        totalPrice += shootOptions[i]['price'];
      }
    }
    setState(() {});
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.vendor['name'] ?? 'Photography Vendor';
    final String address = widget.vendor['address'] ?? 'No Address Available';
    final String phone = widget.vendor['phone'] ?? 'No Contact Info';
    final String email = widget.vendor['email'] ?? 'No Email';
    final String image =
        widget.vendor['image'] ?? 'assets/image/photography.jpg';
    final double price = widget.vendor['price']?.toDouble() ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(image,
                            width: 200, height: 200, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 5),
                          Expanded(
                            child: Wrap(
                              children: [
                                Text(
                                  address,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(
                            " $phone",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(
                            " $email",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.money_outlined, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(" Starts from ₹${price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(shootOptions.length, (index) {
                return CheckboxListTile(
                  title: Text(shootOptions[index]['functions']),
                  subtitle: Text(shootOptions[index]['details']),
                  value: selectedOptions[index],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions[index] = value ?? false;
                      updateTotalPrice();
                    });
                  },
                );
              }),
              TextField(
                decoration: InputDecoration(labelText: "Select Date"),
                readOnly: true,
                onTap: () => selectDate(context),
                controller: TextEditingController(
                    text: selectedDate == null
                        ? ""
                        : selectedDate.toString().split(' ')[0]),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Select Time"),
                readOnly: true,
                onTap: () => selectTime(context),
                controller: TextEditingController(
                    text: selectedTime == null
                        ? ""
                        : selectedTime!.format(context)),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: totalPrice > 0
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentOpp(),
                            ),
                          );
                        }
                      : null, // Disable button if totalPrice is 0
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5, // Shadow effect
                  ),
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
