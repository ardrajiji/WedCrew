import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/user_home/page/user_home_page.dart';

class PaymentOpp extends StatefulWidget {
  final String advance;
  const PaymentOpp({super.key, required this.advance});

  @override
  PaymentOppState createState() => PaymentOppState();
}

class PaymentOppState extends State<PaymentOpp> {
  String? selectedBank;
  TextEditingController priceController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  final List<Map<String, String>> banks = [
    {'name': 'Google Pay', 'image': 'assets/icons/google-pay-icon.webp'},
    {'name': 'Credit/Debit Cards', 'image': 'assets/icons/credit_card.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    selectedBank = banks.first['name'];
    priceController.text = widget.advance;
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Payment Successful"),
          content: const Text("Your payment has been processed successfully!"),
          actions: [
  TextButton(
    onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => UserHomePage()),
        (route) => false, // Removes all previous routes
      );
    },
    child: const Text("OK", style: TextStyle(color: Colors.green)),
  ),
],

        );
      },
    );
  }

  void validateAndProceed(String method) {
    if (method == "Google Pay") {
      if (upiController.text.isEmpty || !upiController.text.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please enter a valid UPI ID.")));
        return;
      }
    } else {
      if (cardNumberController.text.length != 16 ||
          cvvController.text.length != 3 ||
          expiryDateController.text.isEmpty ||
          cardNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please enter valid card details.")));
        return;
      }
    }
    Navigator.pop(context);
    showSuccessDialog();
  }

  void showGooglePayBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Enter Your UPI ID", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextField(
                  controller: upiController,
                  decoration: const InputDecoration(labelText: "UPI ID", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => validateAndProceed("Google Pay"),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 46, 110, 53)),
                  child: const Text("Proceed", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCardPaymentBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Enter Card Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextField(controller: cardNameController, decoration: const InputDecoration(labelText: "Cardholder Name", border: OutlineInputBorder())),
                const SizedBox(height: 10),
                TextField(controller: cardNumberController, decoration: const InputDecoration(labelText: "Card Number", border: OutlineInputBorder()), keyboardType: TextInputType.number, maxLength: 16),
                const SizedBox(height: 10),
                TextField(controller: expiryDateController, decoration: const InputDecoration(labelText: "Expiry Date (MM/YY)", border: OutlineInputBorder())),
                const SizedBox(height: 10),
                TextField(controller: cvvController, decoration: const InputDecoration(labelText: "CVV", border: OutlineInputBorder()), keyboardType: TextInputType.number, maxLength: 3),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => validateAndProceed("Card"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Proceed", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Option", style: TextStyle(color: Colors.white)), backgroundColor: const Color.fromARGB(255, 14, 102, 64)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: priceController, readOnly: true, decoration: const InputDecoration(border: OutlineInputBorder(), hintText: '₹0')),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedBank,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: banks.map((bank) {
                return DropdownMenuItem(value: bank['name'], child: Text(bank['name']!));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() => selectedBank = newValue);
                if (newValue == "Google Pay") {
                  showGooglePayBottomSheet();
                } else {
                  showCardPaymentBottomSheet();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
