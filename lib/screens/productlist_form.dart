import 'package:flutter/material.dart';
import 'package:sultan_sports/widgets/left_drawer.dart';

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sultan_sports/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
  int _stock = 0;
  String _description = "";
  String _category = "sepatu";
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'sepatu',
    'baju',
    'celana',
    'raket',
    'bola',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      // 🌟 Amber Gradient AppBar
      appBar: AppBar(
        title: const Text(
          'Form Tambah Produk',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF57C00), // orange deep
                Color(0xFFFFA726), // amber medium
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),

      drawer: LeftDrawer(),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ==========================
              // INPUT FIELDS
              // ==========================
              _buildInput(
                label: "Nama Produk",
                hint: "Nama Produk",
                onChanged: (v) => _name = v,
                validator: (v) => v == null || v.isEmpty
                    ? "Nama Produk tidak boleh kosong!"
                    : null,
              ),

              _buildInput(
                label: "Harga Produk",
                hint: "Harga Produk",
                keyboard: TextInputType.number,
                onChanged: (v) => _price = int.tryParse(v) ?? 0,
                validator: (v) =>
                    v == null || v.isEmpty ? "Harga tidak boleh kosong!" : null,
              ),

              _buildInput(
                label: "Stok Produk",
                hint: "Stok Produk",
                keyboard: TextInputType.number,
                onChanged: (v) => _stock = int.tryParse(v) ?? 0,
                validator: (v) =>
                    v == null || v.isEmpty ? "Stok tidak boleh kosong!" : null,
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: _inputDecoration(
                    "Deskripsi Produk",
                    "Deskripsi Produk",
                  ),
                  onChanged: (v) => _description = v,
                  validator: (v) => v == null || v.isEmpty
                      ? "Deskripsi tidak boleh kosong!"
                      : null,
                ),
              ),

              // Category dropdown
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField<String>(
                  decoration: _inputDecoration("Kategori", "Kategori"),
                  value: _category,
                  items: _categories
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _category = v!),
                ),
              ),

              // Thumbnail
              _buildInput(
                label: "URL Thumbnail",
                hint: "URL Thumbnail (opsional)",
                onChanged: (v) => _thumbnail = v,
              ),

              // Featured Switch (amber)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SwitchListTile(
                  title: const Text(
                    "Tandai sebagai Produk Unggulan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  activeColor: const Color(0xFFF57C00),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                ),
              ),


              // ==========================
              // SAVE BUTTON
              // ==========================
              Padding(
                padding: const EdgeInsets.all(14),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 14),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFFF57C00), // amber deep
                      ),
                      overlayColor: MaterialStateProperty.all(
                        const Color(0xFFFFB74D),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "http://localhost:8000/create-flutter/",
                          jsonEncode({
                            "name": _name,
                            "price": _price,
                            "stock": _stock,
                            "description": _description,
                            "thumbnail": _thumbnail,
                            "category": _category,
                            "is_featured": _isFeatured,
                          }),
                        );

                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Product successfully saved!"),
                                backgroundColor: Color(0xFFF57C00),
                              ),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Something went wrong, please try again.",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // REUSABLE INPUT
  Widget _buildInput({
    required String label,
    required String hint,
    TextInputType keyboard = TextInputType.text,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: keyboard,
        decoration: _inputDecoration(label, hint),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  // Amber Input Decoration
  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Color(0xFF6C4300)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFF57C00), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
