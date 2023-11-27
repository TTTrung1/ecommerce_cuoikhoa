import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.back),
        elevation: 0,
        title: const Center(child: Text('Cart Screen'),),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
