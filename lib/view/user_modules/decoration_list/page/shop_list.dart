import 'package:flutter/material.dart';
import 'package:wed_crew/view/constants/urls.dart';
import 'package:wed_crew/view/user_modules/decoration_list/model/decor_model.dart';
import 'package:wed_crew/view/user_modules/decoration_list/page/decor_shop.dart';
import 'package:wed_crew/view/user_modules/decoration_list/service/decor_service.dart';


class DecorationPage extends StatefulWidget {
  const DecorationPage({super.key});

  @override
  State<DecorationPage> createState() => _DecorationPageState();
}

class _DecorationPageState extends State<DecorationPage> {
  late Future<List<DecorModel>> _photographyFuture;
  List<DecorModel> _allStudios = [];
  List<DecorModel> _filteredStudios = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _photographyFuture = decor();
    _photographyFuture.then((studios) {
      setState(() {
        _allStudios = studios;
        _filteredStudios = studios;
      });
    });
  }

  void _filterStudios(String query) {
    setState(() {
      _filteredStudios = _allStudios
          .where((studio) =>
              studio.name.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Decor service shop"),
        backgroundColor: const Color(0xFFB2C8ED),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterStudios,
              decoration: InputDecoration(
                hintText: "Search shops...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ),

          // ListView of Studios
          Expanded(
            child: FutureBuilder<List<DecorModel>>(
              future: _photographyFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No studios found",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: _filteredStudios.length,
                  itemBuilder: (context, index) {
                    final studio = _filteredStudios[index];
                    final firstImage = studio.workImages.isNotEmpty == true
                        ? studio.workImages[0]
                        : null;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DecorVendorPage(
                                  studio: studio,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              // Background Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  '${UserUrl.baseUrl}/${studio.shopImage}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 180,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/image/homeDecor.jpg', // Path to your default image
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 180,
                                  ),
                                ),
                              ),

                              // Dark overlay
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),

                              // Studio details
                              Positioned(
                                bottom: 15,
                                left: 15,
                                right: 15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      studio.name ?? 'Unknown Studio',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.white, size: 16),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            studio.address ??
                                                'Location not available',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
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
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
