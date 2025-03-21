// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class ShopPortfolioPage extends StatefulWidget {
//   const ShopPortfolioPage({super.key});

//   @override
//   _ShopPortfolioPageState createState() => _ShopPortfolioPageState();
// }

// class _ShopPortfolioPageState extends State<ShopPortfolioPage> {
//   final String shopName = "My Awesome Shop";
//   final String shopAddress = "123 Market Street, Cityville";
//   final String shopEmail = "awesomeshop@gmail.com";
//   final String shopPhone = "+91 9987346321";
//   final String shopYears = "10 Years in Business";
//   final String shopImage = "assets/shop_image.jpg";

//   final List<File> _uploadedImages = [];

//   Future<void> _pickImage() async {
//     if (_uploadedImages.length < 5) {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//       if (pickedFile != null) {
//         setState(() {
//           _uploadedImages.add(File(pickedFile.path));
//         });
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('You can only upload up to 5 images!')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shop Portfolio'),
//       ),
//       body: 
      
//       FutureBuilder<MainCartModel>
//       (
//          future: mainCartService(),
//         builder: (context, snapshot) 
//         {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/images/noResponse.jpg'),
//                   Text("Error: ${snapshot.error}",
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             );
//           }

//           if (!snapshot.hasData || snapshot.data!.cartItems == null) {
//             return const Center(child: Text("No cart data found"));
//           }
      
//       SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Shop Details Card
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: CircleAvatar(
//                           radius: 50,
//                           backgroundImage: AssetImage(shopImage),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         shopName,
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Address: $shopAddress',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ), SizedBox(height: 4),
//                           Text(
//                             'Email: $shopEmail',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),SizedBox(height: 4),
//                           Text(
//                             'Phone: $shopPhone',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),SizedBox(height: 4),
//                           Text(
//                             'Years in Business: $shopYears',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: const Color.fromARGB(255, 39, 41, 42)),
//                           ),SizedBox(height: 4),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Showcase Images
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: _uploadedImages.isEmpty
//                   ? Center(child: Text('No images uploaded yet.'))
//                   : GridView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                       ),
//                       itemCount: _uploadedImages.length,
//                       itemBuilder: (context, index) {
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(8.0),
//                           child: Image.file(
//                             _uploadedImages[index],
//                             fit: BoxFit.cover,
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       );

//   },),



//       // Floating Action Button to Add Images
//       floatingActionButton: FloatingActionButton(
//         onPressed: _pickImage,
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }
