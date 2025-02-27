import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/user_login/page/login.dart';
import 'package:wed_crew/view/user_modules/user_register/service/user_reg_service.dart';
import 'package:wed_crew/view/user_home_page.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    // Dispose all controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


   
  // Function to handle form submission
  Future<void> _registerUser() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        final responseMessage = await UserRegistrationService(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phone: _phoneController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${responseMessage}')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
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
      backgroundColor:  Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(194, 154, 119, 1.0),

                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField('Name', _nameController),
                          const SizedBox(height: 15),
                          _buildTextField('Email', _emailController,
                              validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]').hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          }),
                          const SizedBox(height: 15),
                          _buildTextField('Phone Number', _phoneController,
                              keyboardType: TextInputType.phone),
                          const SizedBox(height: 15),
                          _buildPasswordField('Password', _passwordController, _obscurePassword, () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          }),
                          const SizedBox(height: 15),
                          _buildPasswordField('Confirm Password', _confirmPasswordController, _obscureConfirmPassword, () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          }, validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(194, 154, 119, 1.0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed:_registerUser,
                              // () {
                              //   if (_formKey.currentState!.validate()) {
                              //     Navigator.push(context, MaterialPageRoute(builder: (context) => const UserHomePage()));
                              //   }
                              // },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                        color: Color.fromRGBO(194, 154, 119, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        ),
                    ),
                    ),
                ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color.fromRGBO(194, 154, 119, 1.0),)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscureText, VoidCallback toggleVisibility, {String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color.fromRGBO(194, 154, 119, 1.0),)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: toggleVisibility,
            ),
          ),
          validator: validator ?? (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
