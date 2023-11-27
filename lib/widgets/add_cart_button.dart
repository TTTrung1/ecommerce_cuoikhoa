import 'package:flutter/material.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
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
          onPressed: (){
            ScaffoldMessengerState msg = ScaffoldMessenger.of(context);
            msg.showSnackBar(const SnackBar(content: Text('Added to cart'),duration: Duration(seconds: 1),));
          }, child: const Text('Add to cart',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
        ),
      ),
    );
  }
}
