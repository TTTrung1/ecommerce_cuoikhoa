import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key, required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if(state is CartAddSuccessState){
          print('listener: $state');
          ScaffoldMessengerState msg = ScaffoldMessenger.of(context);
          msg.showSnackBar(const SnackBar(
            content: Text('Added to cart'),
            duration: Duration(seconds: 1),
          ));
        }
      },
      listenWhen: (previous, current) => current is CartActionState,
      builder: (context, state) {
        print(state);
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
              onPressed: () {
                context.read<CartBloc>().add(CartAddedEvent());
                Navigator.of(context).pop();

              }, child: const Text('Add to cart',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
            ),
          ),
        );
      },
    );
  }
}
