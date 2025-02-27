import 'package:flutter/material.dart';
import 'package:wed_crew/view/payment.dart';

class PhotographyVendorBookingForm extends StatefulWidget {
  const PhotographyVendorBookingForm({super.key});

  @override
  _PhotographyVendorBookingFormState createState() => _PhotographyVendorBookingFormState();
}

class _PhotographyVendorBookingFormState extends State<PhotographyVendorBookingForm> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController advancePriceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double advance = 5000.0;

  @override
  void initState() {
    super.initState();
    advancePriceController.text = advance.toStringAsFixed(2);
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
        title: const Text("Photography Booking", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Book Your Photography Service",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: advancePriceController,
                        decoration: const InputDecoration(
                          labelText: "Advance Price (₹)",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an advance price';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Select Date",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () => selectDate(context),
                        controller: TextEditingController(
                          text: selectedDate == null ? "" : selectedDate.toString().split(' ')[0],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Select Time",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.access_time),
                        ),
                        readOnly: true,
                        onTap: () => selectTime(context),
                        controller: TextEditingController(
                          text: selectedTime == null ? "" : selectedTime!.format(context),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a time';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: addressController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Enter Your Address",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PaymentOpp()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text("Book Now", style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
