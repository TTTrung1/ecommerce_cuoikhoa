import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/cart_item.dart';

class CartRepository {
  final _cart = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser;

  List<CartItem> _items = [];

  List<CartItem> get listItem {
    return [..._items];
  }

  Future<void> addToCart(CartItem item) async {
    await fetchFromFirebase();
    int existingIndex =
        _items.indexWhere((element) => element.id == item.id);
    if (existingIndex != -1) {
      _items.elementAt(existingIndex).quantity =
          (_items.elementAt(existingIndex).quantity! + 1);
    } else {
      _items.add(CartItem(
          id: item.id,
          title: item.title,
          price: item.price,
          category: item.category,
          image: item.image,
          quantity: 1));
    }
    List<Map<String, dynamic>> cartItemList =
        _items.map((item) => item.toMapWithoutNulls()).toList();
    final uid = _auth?.uid;
    CollectionReference userProductCollection = FirebaseFirestore.instance
        .collection('cart')
        .doc(uid)
        .collection('products');

    await userProductCollection.doc('items').set({'products': cartItemList});
  }

  Future<void> fetchFromFirebase() async {
    final uid = _auth?.uid;

    CollectionReference userProductCollection = FirebaseFirestore.instance
        .collection('cart')
        .doc(uid)
        .collection('products');

    final DocumentSnapshot snapshot =
        await userProductCollection.doc('items').get();
    if (snapshot.exists) {
      final data = snapshot['products'];
      print('${data.runtimeType}');
      _items.clear();
      data.forEach((element) {
        _items.add(CartItem(
            id: element['id'],
            title: element['title'],
            price: element['price'],
            category: element['category'],
            image: element['image'],
            quantity: element['quantity']));
      });
    }
  }

  Future<double> totalCost() async {
    double amount = 0;
    final uid = _auth?.uid;

    CollectionReference userProductCollection = FirebaseFirestore.instance
        .collection('cart')
        .doc(uid)
        .collection('products');

    final DocumentSnapshot snapshot =
        await userProductCollection.doc('items').get();
    if (snapshot.exists) {
      final data = snapshot['products'];
      data.forEach((element) {
        amount += element['price'] * element['quantity'];
      });
    }
    return amount;
  }

  Future<void> removeQuantity(CartItem item) async {
    await fetchFromFirebase();
    try {
      final uid = _auth?.uid;
      assert(item.quantity! > 0, 'Can not be reduced to 0!');
      final int existingIndex =
          _items.indexWhere((element) => element.id == item.id);
      print(existingIndex);
      if (existingIndex != -1) {

        _items[existingIndex].quantity = _items[existingIndex].quantity!-1;
        List<Map<String, dynamic>> cartItemList =
            _items.map((item) => item.toMapWithoutNulls()).toList();
        CollectionReference userProductCollection = FirebaseFirestore.instance
            .collection('cart')
            .doc(uid)
            .collection('products');

        await userProductCollection
            .doc('items')
            .set({'products': cartItemList});
      }
    } catch (e) {
      print('Error updating quantity: $e');
      throw Exception('Failed to update quantity');
    }
  }
}
