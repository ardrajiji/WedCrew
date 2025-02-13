import 'package:flutter/material.dart';
import 'package:wed_crew/view/payment.dart';


class PhotographyVendorDetailsPage extends StatefulWidget {
  const PhotographyVendorDetailsPage({super.key});

  @override
  _PhotographyVendorDetailsPageState createState() => _PhotographyVendorDetailsPageState();
}

class _PhotographyVendorDetailsPageState extends State<PhotographyVendorDetailsPage> {
  final List<bool> selectedOptions = [false, false, false];
  double totalPrice = 0.0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController addressController = TextEditingController();

  final List<Map<String, dynamic>> shootOptions = [
    {
      'Name': '3 Functions - 4 Member Team',
      'details': '1 Traditional + 1 Candid Photographer, 1 Traditional + 1 Cinematic Videographer',
      'price': 150000.0,
    },
    {
      'Name': '5 Functions - 5 Member Team',
      'details': '1 Traditional + 2 Candid Photographer, 1 Traditional + 1 Cinematic Videographer',
      'price': 250000.0,
    },
    {
      'Name': '7 Functions - 6 Member Team',
      'details': '1 Traditional + 2 Candid Photographer, 1 Traditional + 2 Cinematic Videographer',
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Photography Booking"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Your Package", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: shootOptions.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    child: CheckboxListTile(
                      title: Text(shootOptions[index]['Name'], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(shootOptions[index]['details']),
                      value: selectedOptions[index],
                      onChanged: (bool? value) {
                        setState(() {
                          selectedOptions[index] = value ?? false;
                          updateTotalPrice();
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Select Date"),
              readOnly: true,
              onTap: () => selectDate(context),
              controller: TextEditingController(
                text: selectedDate == null ? "" : selectedDate.toString().split(' ')[0],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Select Time"),
              readOnly: true,
              onTap: () => selectTime(context),
              controller: TextEditingController(
                text: selectedTime == null ? "" : selectedTime!.format(context),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: InputDecoration(labelText: "Enter Your Address", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Total Price (₹)", border: OutlineInputBorder()),
              readOnly: true,
              controller: TextEditingController(text: totalPrice.toStringAsFixed(2)),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: totalPrice > 0
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentOpp()),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Book Now", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
