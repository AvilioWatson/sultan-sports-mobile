import 'package:flutter/material.dart';
import 'package:sultan_sports/screens/menu.dart';

import 'package:sultan_sports/screens/productlist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                Text(
                  'Sultan Sports',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
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

          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Tambah Produk'),
            // Bagian redirection ke NewsFormPage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductFormPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('Lihat Produk'),
            // Bagian redirection ke ProductFormPage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductFormPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
