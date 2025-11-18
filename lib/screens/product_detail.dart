import 'package:flutter/material.dart';
import 'package:sultan_sports/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}, '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔥 Gradient AppBar – amber sedikit gelap
      appBar: AppBar(
        title: const Text(
          'Product Detail',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            if (product.thumbnail.isNotEmpty)
              Image.network(
                'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 260,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ⭐ Featured badge (amber theme)
                  if (product.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Text(
                        'FEATURED',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  // Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Price & Stock
                  Row(
                    children: [
                      Text(
                        'Price: \$${product.price}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 18),
                      Text(
                        'Stock: ${product.stock}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Category Chip + Date
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFCC80), Color(0xFFFFB74D)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7A4F00),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        _formatDate(product.createdAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Views + UID
                  Row(
                    children: [
                      Icon(Icons.visibility, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 5),
                      Text(
                        '${product.productViews} views',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 18),
                      Text(
                        'User ID: ${product.userId}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  // Description
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, height: 1.55),
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(height: 18),

                  Text(
                    'Product ID: ${product.id}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Featured: ${product.isFeatured ? "Yes" : "No"}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 32),

                  // ============================
                  // 🔙 TOMBOL KEMBALI
                  // ============================
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xFFF57C00),
                        overlayColor: const Color(0xFFFFB74D),
                      ),
                      child: const Text(
                        "Kembali ke Daftar Produk",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
