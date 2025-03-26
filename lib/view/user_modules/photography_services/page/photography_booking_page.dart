import 'package:flutter/material.dart';
import 'package:wed_crew/view/user_modules/photography_booking_form/page/photography_booking_form.dart';
import 'package:wed_crew/view/user_modules/photography_services/model/service_list_model.dart';
import 'package:wed_crew/view/user_modules/photography_services/service/service_list_sevice.dart';

class PhotographyServicePage extends StatefulWidget {
  final String vendor_id;
  const PhotographyServicePage({
    super.key,
    required this.vendor_id,
  });

  @override
  _PhotographyServicePageState createState() => _PhotographyServicePageState();
}

class _PhotographyServicePageState extends State<PhotographyServicePage> {
  List<ServiceListModel> serviceListData = [];
  List<bool> selectedItems = [];
  double totalPrice = 0.0;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchServiceList();
  }

  Future<void> fetchServiceList() async {
    try {
      final data = await serviceList(vendor_id: widget.vendor_id);
      setState(() {
        serviceListData = data;
        selectedItems = List<bool>.filled(data.length, false);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load services. Please try again.";
        isLoading = false;
      });
    }
  }

  void calculateTotal() {
    totalPrice = 0.0;
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        totalPrice += double.parse(serviceListData[i].totalAmount ?? '0');
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double convenienceFee = totalPrice * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photography Booking'),
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : serviceListData.isEmpty
                    ? const Center(
                        child: Text(
                          "No services available",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: serviceListData.length,
                              itemBuilder: (context, index) {
                                final service = serviceListData[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 4,
                                  color: selectedItems[index]
                                      ? Colors.deepPurple[100]
                                      : Colors.white,
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        selectedItems[index] = !selectedItems[index];
                                        calculateTotal();
                                      });
                                    },
                                    title: Text(
                                      service.serviceName ?? 'N/A',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Text(service.details ?? 'No details available'),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('₹${service.totalAmount ?? '0'}'),
                                        if (selectedItems[index])
                                          const Icon(Icons.check_circle,
                                              color: Colors.black),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Divider(),
                          Text(
                            'Total Price: ₹${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Convenience Fee (5%): ₹${convenienceFee.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: totalPrice > 0
                                ? () {
                                    // Get only IDs of selected services
                                    final selectedServiceIds = [];
                                    for (int i = 0; i < selectedItems.length; i++) {
                                      if (selectedItems[i]) {
                                        selectedServiceIds.add(serviceListData[i].id);
                                      }
                                    }

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotographyVendorBookingForm(
                                          vendor_id: widget.vendor_id,
                                          selectedServiceIds: selectedServiceIds,
                                         // totalPrice: totalPrice.toStringAsFixed(2),
                                          convenienceFee: convenienceFee.toStringAsFixed(2),
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Book Now',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
      ),
    );
  }
}