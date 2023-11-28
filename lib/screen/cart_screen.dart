import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        elevation: 0,
        title: const Center(
          child: Text('Your Cart'),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (auth == null) {
            return const Center(
              child: Text(
                'Log in first to check out what\'s going on!',
                textAlign: TextAlign.center,
              ),
            );
          }
          return Column(
            children: [
              Expanded(child: ListView()),
              ElevatedButton(onPressed: () {}, child: Text('Add order'))
            ],
          );
        },
      ),
    );
  }
}
