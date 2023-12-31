import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_cuoikhoa/model/cart_item.dart';
import 'package:ecommerce_cuoikhoa/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';

class AddToCart extends StatelessWidget {
  AddToCart({super.key, required this.product});
  final Product product;

  final guest = FirebaseAuth.instance.currentUser?.isAnonymous;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if(state.clicked == true){
          ScaffoldMessengerState msg = ScaffoldMessenger.of(context);
          msg.showSnackBar(const SnackBar(
            content: Text('Added to cart'),
            duration: Duration(seconds: 1),
          ));
        }
      },
      listenWhen: (previous, current) => current.clicked == true,
      builder: (context, state) {
        return Center(
          child: Container(
            height: 50,
            width: 400,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(
                vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0Xffc33a32),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextButton(
              onPressed: guest == true ? null : () {
                context.read<CartBloc>().add(CartAddedEvent(
                  item: CartItem(id: product.id,title: product.title,price: product.price,category: product.category,image: product.image,quantity: 1)
                ));
                Navigator.of(context).pop();

              }, child: const Text('addToCart',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )).tr(),
            ),
          ),
        );
      },
    );
  }
}
