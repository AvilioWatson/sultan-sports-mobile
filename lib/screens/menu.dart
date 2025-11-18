import 'package:flutter/material.dart';
import 'package:sultan_sports/widgets/left_drawer.dart';
import 'package:sultan_sports/screens/product_entry_list.dart';
import 'package:sultan_sports/screens/productlist_form.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Wildan Al Rizka Yusuf";
  final String npm = "2406407083";
  final String kelas = "D";

  final List<ItemHomepage> items = [
    ItemHomepage("Semua Produk", Icons.sports_soccer, [
      Color(0xFFF59E0B), // amber 500 (sedikit gelap)
      Color(0xFFD97706), // amber 600
      Color(0xFFB45309), // amber 700
    ]),
    ItemHomepage("Produk Saya", Icons.sports_basketball, [
      Color(0xFFD97706), // amber 600
      Color(0xFFB45309), // amber 700
      Color(0xFF9A3412), // orange 800
    ]),
    ItemHomepage("Tambah Produk", Icons.create, [
      Color(0xFFEA580C), // orange 600
      Color(0xFF9A3412), // orange 800
      Color(0xFF7C2D12), // orange 900
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sultan Sports',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFB45309), // amber 700
      ),
      drawer: LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di Sultan Sports',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return GestureDetector(
                        onTap: () {
                          if (item.name == "Semua Produk") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductEntryListPage(),
                              ),
                            );
                          } else if (item.name == "Produk Saya") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductEntryListPage(showMyProducts: true),
                              ),
                            );
                          } else if (item.name == "Tambah Produk") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductFormPage(),
                              ),
                            );
                          }
                        },
                        child: ItemCard(item),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shadowColor: Colors.black12,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final List<Color> gradientColors;

  ItemHomepage(this.name, this.icon, this.gradientColors);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: item.gradientColors,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              item.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
