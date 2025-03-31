import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wed_crew/view/utils/preference_values.dart';
import 'package:wed_crew/view/vendor_module/vendor_login/page/vendor_login.dart';
import 'dart:io';

import 'package:wed_crew/view/vendor_module/vendor_shop_register/service/shop_register_service.dart';

class ShopRegistrationPage extends StatefulWidget {
  const ShopRegistrationPage({super.key});

  @override
  State<ShopRegistrationPage> createState() => _ShopRegistrationPageState();
}

class _ShopRegistrationPageState extends State<ShopRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  File? _shopImage;
  final ImagePicker _picker = ImagePicker();


    // Function to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        final responseMessage = await shopRegistrationService(
          name: _shopNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          yearInBusiness: _yearsController.text.trim(),
          address: _addressController.text.trim(),
          shopImage: _shopImage ??File('assets/image/image.png'),
          
        );

         await PreferenceValues.tempVendorLogout();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registered successfully')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const VendorLoginPage(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _shopImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFCE4EC), Color.fromARGB(255, 168, 224, 234)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                "Shop Registration",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Shop Name", _shopNameController, Icons.store, (value) {
                      if (value == null || value.isEmpty) return "Shop name is required";
                      return null;
                    }),
                    _buildTextField("Address", _addressController, Icons.location_on, (value) {
                      if (value == null || value.isEmpty) return "Address is required";
                      return null;
                    }),
                    _buildTextField("Phone Number", _phoneController, Icons.phone, (value) {
                      value = value?.trim();
                      if (value == null || value.isEmpty) return "Phone number is required";
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) return "Enter a valid 10-digit phone number";
                      return null;
                    }, keyboardType: TextInputType.phone),
                    _buildTextField("Email", _emailController, Icons.email, (value) {
                      if (value == null || value.isEmpty) return "Email is required";
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Enter a valid email";
                      return null;
                    }, keyboardType: TextInputType.emailAddress),
                    _buildTextField("Years in Business", _yearsController, Icons.timeline, (value) {
                      if (value == null || value.isEmpty) return "This field is required";
                      if (int.tryParse(value) == null) return "Enter a valid number";
                      return null;
                    }, keyboardType: TextInputType.number),
                    const SizedBox(height: 20),
                    // Image Upload Field
                    Column(
                      children: [
                        if (_shopImage != null)
                          Image.file(_shopImage!, height: 150, width: 150, fit: BoxFit.cover),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.image),
                          label: const Text("Upload Shop Image"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          elevation: 5,
                          shadowColor: Colors.grey.withOpacity(0.5),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon, String? Function(String?) validator,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(icon, color: Colors.grey, size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: validator,
        ),
      ),
    );
  }

 
}
