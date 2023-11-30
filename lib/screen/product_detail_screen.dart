import 'package:ecommerce_cuoikhoa/widgets/add_cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc/search_bloc.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => current is SearchProductPressState,
      builder: (context, state) {
        if (state is SearchProductPressState) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 880,
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 500,
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(state.product.image!),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                    Positioned(
                      top: 45,
                      left: 20,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 26,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        top: 500,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                state.product.title!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text('${CupertinoIcons.star_fill} ${state.product.rating!.rate
                                  .toString()} with ${state.product.rating!
                                  .count} votes',
                                  style: const TextStyle(
                                      fontSize: 14)),
                              const SizedBox(
                                width: 280,
                              ),
                              Text(
                                '\$${state.product.price}',
                                style: const TextStyle(
                                    color: Color(0Xffc33a32)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // ExpandableText(text: widget.product.title!),
                              Text(state.product.description!),
                              const SizedBox(
                                height: 20,
                              ),
                              AddToCart(product: state.product)
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
