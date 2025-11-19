import 'package:flutter/material.dart';
import 'package:sultan_sports/screens/login.dart';
import 'package:sultan_sports/screens/menu.dart';
import 'package:sultan_sports/screens/product_entry_list.dart';
import 'package:sultan_sports/screens/productlist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // HEADER DENGAN GRADIENT
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8B4513), // coklat amber gelap
                  Color(0xFFC56E1A), // amber-oranye lembut
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Sultan Sports',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Seluruh Produk Olahraga terkini di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // ========================
          // MENU ITEMS
          // ========================
          ListTile(
            leading: const Icon(Icons.home_outlined, color: Colors.black87),
            title: const Text(
              'Halaman Utama',
              style: TextStyle(color: Colors.black87),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.add, color: Colors.black87),
            title: const Text(
              'Tambah Produk',
              style: TextStyle(color: Colors.black87),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductFormPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.sports_volleyball_sharp,
              color: Colors.black87,
            ),
            title: const Text(
              'Lihat Produk',
              style: TextStyle(color: Colors.black87),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductEntryListPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black87),
            title: const Text(
              'Log Out ',
              style: TextStyle(color: Colors.black87),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
