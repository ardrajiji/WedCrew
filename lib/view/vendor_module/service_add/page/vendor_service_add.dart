import 'package:flutter/material.dart';
import 'package:wed_crew/view/vendor_module/service_add/service/service_add_service.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});

  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();


@override
  void dispose() {
    // Dispose all controllers
    _serviceNameController.dispose();
    _detailsController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() == true ) {
      try {
        final responseMessage = vendorAddService(
          service_name: _serviceNameController.text.trim(),
          details: _detailsController.text.trim(),
          amount: _amountController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Service added Successfully')),
        );

        Navigator.pop(context);
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
      appBar: AppBar(
        title: Text(
          'Shoot Options',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Add Service',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _serviceNameController,
                  decoration: InputDecoration(
                    labelText: 'Service Name',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter service name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _detailsController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Details',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter details';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Total Amount',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter total amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      elevation: 5, 
                      backgroundColor: Colors.black, 
                      foregroundColor: Colors.white, 
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12), 
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), 
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2, 
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
