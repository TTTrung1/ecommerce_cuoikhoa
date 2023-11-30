import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/cart_item.dart';
import '../model/product.dart';

class CartRepository {
  final _cart = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser;

  List<CartItem> _items = [];

  List<CartItem> get listItem {
    return [..._items];
  }

  Future<void> addToListItem(Product product) async {
    int existingIndex =
        _items.indexWhere((element) => element.id == product.id);
    if (existingIndex != -1) {
      _items.elementAt(existingIndex).quantity =
          (_items.elementAt(existingIndex).quantity! + 1);
    } else {
      _items.add(CartItem(
          id: product.id,
          title: product.title,
          price: product.price,
          category: product.category,
          image: product.image,
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

    final DocumentSnapshot snapshot = await userProductCollection.doc('items').get();
    print('snapshot: ${snapshot['products']}');
    if(snapshot.exists){

      final data = snapshot['products'];
      print('${data.runtimeType}');
      data.forEach((element) {
        _items.add(CartItem(
          id: element['id'],
          title: element['title'],
          price: element['price'],
          category: element['category'],
          image: element['image'],
          quantity: element['quantity']
        ));
      });
    }
    print('items count: ${_items.length}');
  }
}
