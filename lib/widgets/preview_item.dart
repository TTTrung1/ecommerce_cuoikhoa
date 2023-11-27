import 'package:ecommerce_cuoikhoa/widgets/add_cart_button.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

class PreviewItem extends StatelessWidget {
  const PreviewItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *0.8 ,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(product.image!),
              Text(product.title!,style: Theme.of(context).textTheme.displayMedium,),
              Text(product.description!,style: Theme.of(context).textTheme.headlineMedium),
              AddToCart()
            ],
          ),
        ),
      ),
    );
  }
}
