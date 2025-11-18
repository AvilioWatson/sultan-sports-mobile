import 'package:flutter/material.dart';
import 'package:sultan_sports/models/product_entry.dart';
import 'package:sultan_sports/widgets/left_drawer.dart';
import 'package:sultan_sports/screens/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  final bool showMyProducts;

  const ProductEntryListPage({super.key, this.showMyProducts = false});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');

    List<ProductEntry> listProduct = [];
    for (var d in response) {
      if (d != null) {
        final product = ProductEntry.fromJson(d);
        if (!widget.showMyProducts ||
            product.userId == request.jsonData['userId']) {
          listProduct.add(product);
        }
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      // 🔥 Gradient amber appbar
      appBar: AppBar(
        title: Text(
          widget.showMyProducts ? 'Produk Saya' : 'Semua Produk',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF57C00), // amber dark
                Color(0xFFFFA726), // amber medium
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),

      drawer: const LeftDrawer(),

      body: FutureBuilder<List<ProductEntry>>(
        future: fetchProduct(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada produk.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFF57C00),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                shadowColor: Colors.orange.withOpacity(0.25),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: p),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        // Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            p.thumbnail,
                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) =>
                                const Icon(Icons.broken_image, size: 50),
                          ),
                        ),

                        const SizedBox(width: 14),

                        // INFO PRODUK
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name
                              Text(
                                p.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // Price (amber)
                              Text(
                                "Rp ${p.price}",
                                style: const TextStyle(
                                  color: Color(0xFFEF6C00), // orange dark
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(height: 4),

                              // Category
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFE0B2),
                                      Color(0xFFFFCC80)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Kategori: ${p.category}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6C4300),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 4),

                              // Stock
                              Text(
                                "Stok: ${p.stock}",
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 4),

                              // Description
                              Text(
                                p.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 4),

                              // Featured
                              Text(
                                "Featured: ${p.isFeatured ? 'Yes' : 'No'}",
                                style: TextStyle(
                                  color: p.isFeatured
                                      ? const Color(0xFFF57C00)
                                      : Colors.grey,
                                  fontWeight:
                                      p.isFeatured ? FontWeight.bold : FontWeight.normal,
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
            },
          );
        },
      ),
    );
  }
}
