import 'package:flutter/material.dart';
import 'package:sultan_sports/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
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

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null && (uri.isAbsolute && (uri.hasScheme && uri.hasAuthority));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Form Tambah Produk')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Nama Produk ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) => setState(() => _name = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama produk tidak boleh kosong!";
                  }
                  if (value.length < 3) {
                    return "Nama minimal 3 karakter!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Harga ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Harga Produk",
                  hintText: "Masukkan harga dalam angka",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _price = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  final price = int.tryParse(value);
                  if (price == null) {
                    return "Harga harus berupa angka!";
                  }
                  if (price <= 0) {
                    return "Harga harus lebih dari 0!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Deskripsi ===
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Deskripsi Produk",
                  hintText: "Tulis deskripsi produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) => setState(() => _description = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  if (value.length < 10) {
                    return "Deskripsi minimal 10 karakter!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Kategori ===
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ))
                    .toList(),
                onChanged: (newValue) => setState(() => _category = newValue!),
              ),
              const SizedBox(height: 12),

              // === URL Thumbnail ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "URL Thumbnail",
                  hintText: "https://contoh.com/gambar.jpg",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) => setState(() => _thumbnail = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "URL Thumbnail tidak boleh kosong!";
                  }
                  if (!_isValidUrl(value)) {
                    return "Masukkan URL yang valid!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Featured ===
              SwitchListTile(
                title: const Text("Tandai sebagai produk unggulan"),
                value: _isFeatured,
                onChanged: (value) => setState(() => _isFeatured = value),
              ),
              const SizedBox(height: 12),

              // === Tombol Save ===
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Produk Berhasil Disimpan'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Nama: $_name"),
                                Text("Harga: $_price"),
                                Text("Deskripsi: $_description"),
                                Text("Kategori: $_category"),
                                Text("Thumbnail: $_thumbnail"),
                                Text("Featured: $_isFeatured"),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                      _formKey.currentState!.reset();
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
