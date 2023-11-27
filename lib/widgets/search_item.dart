import 'package:ecommerce_cuoikhoa/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc/search_bloc.dart';
import '../model/product.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
        return InkWell(
          onTap: () {
            context.read<SearchBloc>().add(SearchProductPressed(product));
          },
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.zero,
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image.network(
                    product.image!,
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          product.title!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(product.category!,
                            style: const TextStyle(fontSize: 12.0,color: Colors.black)),
                      ),
                      const SizedBox(height: 2.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('\$',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                                Text(product.price.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                              ],
                            ),
                            GestureDetector(
                              child: IconButton(
                                splashColor:
                                    Theme.of(context).colorScheme.primary,
                                tooltip: 'Add to cart',
                                onPressed: () {
                                  final ScaffoldMessengerState addToCartMsg =
                                      ScaffoldMessenger.of(context);
                                  addToCartMsg.showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Product added successfully'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                icon:
                                    const Icon(Icons.add_shopping_cart_rounded),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
