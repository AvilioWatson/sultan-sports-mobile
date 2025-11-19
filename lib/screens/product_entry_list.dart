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

    final List<ProductEntry> listProduct = [];
    final currentUserId = request.jsonData['user_id'];

    for (var d in response) {
      if (d == null) continue;

      final product = ProductEntry.fromJson(d);

      // Jika showMyProducts = false → tampilkan semua
      if (!widget.showMyProducts) {
        listProduct.add(product);
        continue;
      }

      // Jika showMyProducts = true → hanya produk user
      if (currentUserId != null && product.userId == currentUserId) {
        listProduct.add(product);
      } else {
      }
    }

    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.showMyProducts ? 'Produk Saya' : 'Semua Produk',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF57C00), Color(0xFFFFA726)],
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
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                margin: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            p.thumbnail,
                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.broken_image, size: 50),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "Rp ${p.price}",
                                style: const TextStyle(
                                  color: Color(0xFFEF6C00),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFE0B2),
                                      Color(0xFFFFCC80),
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

                              Text(
                                "Stok: ${p.stock}",
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 4),

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

                              Text(
                                "Featured: ${p.isFeatured ? 'Yes' : 'No'}",
                                style: TextStyle(
                                  color: p.isFeatured
                                      ? const Color(0xFFF57C00)
                                      : Colors.grey,
                                  fontWeight: p.isFeatured
                                      ? FontWeight.bold
                                      : FontWeight.normal,
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
