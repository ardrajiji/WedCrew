import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wed_crew/view/constants/urls.dart';
import 'dart:io';
import 'package:wed_crew/view/vendor_module/portfolio/model/shop_view_model.dart';
import 'package:wed_crew/view/vendor_module/portfolio/service/add_images.dart';
import 'package:wed_crew/view/vendor_module/portfolio/service/shop_view_service.dart';

class ShopPortfolioPage extends StatefulWidget {
  const ShopPortfolioPage({super.key});

  @override
  _ShopPortfolioPageState createState() => _ShopPortfolioPageState();
}
class _ShopPortfolioPageState extends State<ShopPortfolioPage> {
  late Future<PortfolioModel> _shopDetailsFuture;
  final List<File> _uploadedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize the Future in initState to avoid late initialization error
    _shopDetailsFuture = shopViewService();
  }

  Future<void> _pickImage() async {
    if (_uploadedImages.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only upload up to 4 images!')),
      );
      return;
    }

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        setState(() {
          _uploadedImages.add(imageFile);
        });

        final response = await addImages(productImages: [imageFile]);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(response.message ?? 'Image uploaded successfully!')),
        );

        // Refresh the shop details after uploading the image
        setState(() {
          _shopDetailsFuture = shopViewService();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Portfolio'),
      ),
      body: FutureBuilder<PortfolioModel>(
        future: _shopDetailsFuture, // Use the initialized Future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/image/noResponse.jpg'),
                  Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No data found"));
          }

          final shopDetails = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: shopDetails.shopImage != null &&
                                      shopDetails.shopImage!.isNotEmpty
                                  ? NetworkImage(
                                      '${UserUrl.baseUrl}/${shopDetails.shopImage!}')
                                  : const AssetImage('assets/image/profile.jpg')
                                      as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            shopDetails.name!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address: ${shopDetails.address!}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Email: ${shopDetails.email!}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Phone: ${shopDetails.mobileNo!}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Years in Business: ${shopDetails.yearInBusiness!}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 39, 41, 42),
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: shopDetails.workImages!.isEmpty
                      ? const Center(child: Text('No images uploaded yet.'))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: shopDetails.workImages!.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                '${UserUrl.baseUrl}/${shopDetails.workImages![index].image}',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
