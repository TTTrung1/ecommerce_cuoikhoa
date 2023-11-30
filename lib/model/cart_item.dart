import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  int? id;
  String? title;
  double? price;
  String? category;
  String? image;
  int? quantity;

  CartItem({
    this.id,
    this.title,
    this.price,
    this.category,
    this.image,
    this.quantity = 0,
  });

  factory CartItem.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    return CartItem(
      id: data?['id'],
      title: data?['title'],
      price: data?['price'],
      category: data?['category'],
      image: data?['image'],
      quantity: data?['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price' : price,
      'category' : category,
      'image' : image,
      'quantity': quantity,
    };
  }
  Map<String, dynamic> toMapWithoutNulls() {
    return toMap()..removeWhere((key, value) => value == null);
  }
}
