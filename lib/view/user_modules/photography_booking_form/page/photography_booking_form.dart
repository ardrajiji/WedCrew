import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wed_crew/view/payment.dart';
import 'package:wed_crew/view/user_modules/photography_booking_form/service/booking_service.dart';

class PhotographyVendorBookingForm extends StatefulWidget {
  final String vendor_id;
  final String convenienceFee;
  final List selectedServiceIds;
  const PhotographyVendorBookingForm({
    super.key,
    required this.vendor_id,
    required this.convenienceFee,
    required this.selectedServiceIds,
  });

  @override
  _PhotographyVendorBookingFormState createState() =>
      _PhotographyVendorBookingFormState();
}

class _PhotographyVendorBookingFormState
    extends State<PhotographyVendorBookingForm> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController advancePriceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController dateController = TextEditingController();

@override
void initState() {
  super.initState();
  advancePriceController.text = widget.convenienceFee;
  dateController.text = ""; // Initialize date controller
}


  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate =
            DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
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
        timeController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _bookService() async {
  if (_formKey.currentState?.validate() == true) {
    try {
      String formattedTime;
      try {
        DateTime parsedTime = DateFormat.jm().parse(timeController.text);
        formattedTime = DateFormat.Hms().format(parsedTime);
      } catch (e) {
        formattedTime = "00:00:00";
      }

      // Format the date to only include the date part (YYYY-MM-DD)
      String formattedDate = selectedDate != null 
          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
          : "";

      final responseMessage = await confirmBookingService(
        service_ids: widget.selectedServiceIds,
        advanced_price: widget.convenienceFee,
        time: formattedTime,
        date: formattedDate,  // Use the formatted date without time
        address: addressController.text.trim(),
        vendor: widget.vendor_id,
      );

      if (responseMessage.status == 'success') {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Proceed to Payment"),
                content: const Text(
                    "Do you want to continue to the payment page?\nIf there is any cancellation please contact the shop."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentOpp(advance: widget.convenienceFee,),
                        ),
                      );
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseMessage.message ?? "Unknown error"),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking failed: $e'),
          ),
        );
      }
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photography Booking",
            style: TextStyle(fontWeight: FontWeight.bold)),
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
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
                        readOnly:
                            true, // Make it read-only since it's pre-filled
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Advance price is required';
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
                          text: selectedDate == null
                              ? ""
                              : DateFormat('yyyy-MM-dd')
                                  .format(selectedDate!), // Keeps only date
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
                        controller: timeController,
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
                          onPressed: _bookService,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text("Book Now",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
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
