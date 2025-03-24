import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wed_crew/view/user_modules/package_book_form/service/booking_form_service.dart';
import 'package:wed_crew/view/user_modules/package_payment/page/package_payment.dart';

class PackageBookingForm extends StatefulWidget {
  final String package_id;
  final String amount;
  const PackageBookingForm({super.key,
  required this.package_id,
  required this.amount});

  @override
  _PackageBookingFormState createState() => _PackageBookingFormState();
}

class _PackageBookingFormState extends State<PackageBookingForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();

  
  // Function to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        final responseMessage = await userbookService(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          mobile_number: _mobileController.text.trim(), 
          location:_locationController.text.trim(), 
          date_of_marriage: _dateController.text.trim(), 
          number_of_participants:_participantsController.text.trim(),          
          package_id: widget.package_id, 
         
        );
        if (responseMessage.message == 'Booking created successfully!') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking created successfully!')),
          );
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserPayment(total_price:widget.amount, booking_id:responseMessage.id.toString(),),
          ),
        );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseMessage.message ?? "Unknown error")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking  failed: $e')),
        );
      }
    }
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wedding Inquiry Form"),
        backgroundColor:  const Color.fromARGB(255, 41, 163, 94),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
          

            // Header Text
            Text(
              "Please let us know a little about yourself",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SizedBox(height: 20),

            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Name", _nameController, Icons.person,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  }),

                  _buildTextField(
                    "Mobile Number",
                    _mobileController,
                    Icons.phone,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return "Mobile number is required";
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return "Enter a valid 10-digit mobile number";
                      }
                      return null;
                    },
                    keyboardType: TextInputType
                        .phone, // Ensure this is inside the function parameters
                  ),

                  _buildTextField("Email ID", _emailController, Icons.email,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  }, keyboardType: TextInputType.emailAddress),

                  _buildTextField("Preferred Location", _locationController,
                      Icons.location_on, (value) {
                    if (value == null || value.isEmpty) {
                      return "Location is required";
                    }
                    return null;
                  }),

                  _buildDateField("Date of Marriage", _dateController,
                      Icons.calendar_today),

                  _buildTextField("Number of Participants",
                      _participantsController, Icons.people, (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter number of participants";
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return "Enter a valid number";
                    }
                    return null;
                  }, keyboardType: TextInputType.number),

                  SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 27, 95, 51),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to create a text field with validation
  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, String? Function(String?) validator,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
            size: 15,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
      ),
    );
  }

  // Function to create a date picker field
  Widget _buildDateField(
      String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
            size: 15,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 2),
          );
          if (pickedDate != null) {
            setState(() {
              controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) return "Date is required";
          return null;
        },
      ),
    );
  }
}
