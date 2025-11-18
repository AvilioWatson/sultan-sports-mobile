// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String id;
    String name;
    int price;
    int stock;
    String description;
    String category;
    String thumbnail;
    int productViews;
    DateTime createdAt;
    bool isFeatured;
    int userId;

    ProductEntry({
        required this.id,
        required this.name,
        required this.price,
        required this.stock,
        required this.description,
        required this.category,
        required this.thumbnail,
        required this.productViews,
        required this.createdAt,
        required this.isFeatured,
        required this.userId,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        description: json["description"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        productViews: json["product_views"],
        createdAt: DateTime.parse(json["created_at"]),
        isFeatured: json["is_featured"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "stock": stock,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "product_views": productViews,
        "created_at": createdAt.toIso8601String(),
        "is_featured": isFeatured,
        "user_id": userId,
    };
}
