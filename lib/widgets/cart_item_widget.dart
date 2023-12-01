import 'package:ecommerce_cuoikhoa/repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../model/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget({super.key, required this.item});
  final CartItem item;
  CartRepository cartRepository = CartRepository();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          ClipRRect(child: Image.network(item.image!,height: 100,width: 100,)),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.title!,overflow: TextOverflow.ellipsis,),
                Text(item.price.toString()),
                Row(
                  children: [
                    IconButton(onPressed: (){
                      context.read<CartBloc>().add(CartRemovedEvent(item: item));
                    }, icon: Icon(Icons.remove)),
                    Text(item.quantity.toString()),
                    IconButton(onPressed: () {
                      context.read<CartBloc>().add(CartAddedEvent(item: item));
                    }, icon: Icon(Icons.add))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
