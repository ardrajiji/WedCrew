import 'package:flutter/material.dart';
import 'package:wed_crew/view/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _districtController = TextEditingController();

  final TextEditingController _placeController = TextEditingController();

  // Function to validate and submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process form data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign Up Successful!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            // Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(1),
              child: Image.asset(
                'assets/icons/wedcrewLogo.png',
                height: 100,
                width: 200,
              ),
            ),
            SizedBox(height: 10),

            // Header Text
            Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Name", _nameController, Icons.person, (value) {
                    if (value == null || value.isEmpty) return "Name is required";
                    return null;
                  }),

                  _buildTextField("Email ID", _emailController, Icons.email, (value) {
                    if (value == null || value.isEmpty) return "Email is required";
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Enter a valid email";
                    return null;
                  }, keyboardType: TextInputType.emailAddress),

                  _buildTextField("Address", _addressController, Icons.location_on, (value) {
                    if (value == null || value.isEmpty) return "Address is required";
                    return null;
                  }),

                  _buildTextField("Mobile Number", _mobileController, Icons.phone, (value) {
                    if (value == null || value.isEmpty) return "Mobile number is required";
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return "Enter a valid 10-digit mobile number";
                    return null;
                  }, keyboardType: TextInputType.phone),

                  _buildTextField("District", _districtController, Icons.map, (value) {
                    if (value == null || value.isEmpty) return "District is required";
                    return null;
                  }),

                  _buildTextField("Place", _placeController, Icons.place, (value) {
                    if (value == null || value.isEmpty) return "Place is required";
                    return null;
                  }),

                  SizedBox(height: 20),

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
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                   Text("Already have an account?"),
                    TextButton(
                    onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                        ),
                        );
                    },
                    child: const Text(
                        'Login',
                        style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        ),
                    ),
                    ),
                ],
                ),
          ],
        ),
      ),
    );
  }

  // Function to create a text field with validation
  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon, String? Function(String?) validator,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,

        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(icon, color: Colors.grey,size: 17,),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
      ),
    );
  }
}
