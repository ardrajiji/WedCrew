import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/user_login/page/login.dart';
import 'package:wed_crew/view/vendor_module/vendor_register/service/signup_service.dart';
import 'package:wed_crew/view/vendor_module/vendor_shop_register/page/register.dart';

class VendorRegistration extends StatefulWidget {
  const VendorRegistration({super.key});

  @override
  State<VendorRegistration> createState() => _VendorRegistrationState();
}

class _VendorRegistrationState extends State<VendorRegistration> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _selectedCategory;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final List<String> _categories = [
    "Photography",
    "Venue Coordinator",
    "Decor Coordinator",
    "Beautician"
  ];

  // Function to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        final responseMessage = await vendorRegistrationService(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _mobileController.text.trim(),
          password: _passwordController.text.trim(),
          category: _selectedCategory ?? '',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registered successfully')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ShopRegistrationPage(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            //colors: [Color(0xFFFCE4EC), Color.fromARGB(255, 168, 224, 234)],
            colors: [Color.fromARGB(255, 251, 248, 243), Color.fromARGB(255, 226, 247, 206)],
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
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(37, 125, 70, 1),
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Category Dropdown
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Select Category",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: InputBorder.none,
                          prefixIcon:
                              const Icon(Icons.category, color: Colors.grey),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        items: _categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a category";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTextField("Name", _nameController, Icons.person,
                        (value) {
                      if (value == null || value.isEmpty)
                        return "Name is required";
                      return null;
                    }),
                    _buildTextField("Email ID", _emailController, Icons.email,
                        (value) {
                      if (value == null || value.isEmpty)
                        return "Email is required";
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                        return "Enter a valid email";
                      return null;
                    }, keyboardType: TextInputType.emailAddress),
                    _buildTextField(
                        "Mobile Number", _mobileController, Icons.phone,
                        (value) {
                      value = value?.trim(); // Trim leading & trailing spaces

                      if (value == null || value.isEmpty) {
                        return "Mobile number is required";
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return "Enter a valid 10-digit mobile number";
                      }
                      return null;
                    }, keyboardType: TextInputType.phone),

                    const SizedBox(height: 15),
                    _buildPasswordField("Password", _passwordController),
                    const SizedBox(height: 15),
                    _buildPasswordField(
                        "Confirm Password", _confirmPasswordController),
                    const SizedBox(height: 20),
                    // Sign Up Button
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
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Login Redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 16, fontFamily: 'Lato'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserLoginPage()),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: 'Lato',
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, String? Function(String?) validator,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade200,
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(icon, color: Colors.grey, size: 20),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade200,
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText:
              label == "Password" ? _obscurePassword : _obscureConfirmPassword,
          decoration: InputDecoration(
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(Icons.lock, color: Colors.grey, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                label == "Password"
                    ? (_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility)
                    : (_obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  if (label == "Password") {
                    _obscurePassword = !_obscurePassword;
                  } else {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  }
                });
              },
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "$label is required";
            }
            if (label == "Confirm Password" &&
                value != _passwordController.text) {
              return "Passwords do not match";
            }
            return null;
          },
        ),
      ),
    );
  }
}
