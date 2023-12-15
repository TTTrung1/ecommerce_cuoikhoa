import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_cuoikhoa/screen/cart_screen.dart';
import 'package:ecommerce_cuoikhoa/screen/products_by_category.dart';
import 'package:ecommerce_cuoikhoa/widgets/carousel_slider_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../model/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'appTitle',
                style: Theme.of(context).textTheme.displayLarge,
              ).tr(),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  icon: const Icon(CupertinoIcons.cart))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                current is! HomeProductPressedState,
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoadSuccess) {
                final List<Product> listAllProducts = state.listAllProducts;
                return CarouselSliderItem(listProducts: listAllProducts);
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  current is! HomeProductPressedState,
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeLoadSuccess) {
                  final List<String> categories = state.listAllCategories;
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (ctx, index) {
                          final List<Product>? listProductByCat =
                              state.mapProductByCategory[categories[index]];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      categories[index].toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductsByCategory(
                                                        products:
                                                            listProductByCat!,
                                                      )));
                                        },
                                        child: Text(
                                          'showAll',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ).tr())
                                  ],
                                ),
                              ),
                              CarouselSliderItem(
                                  listProducts: listProductByCat!)
                            ],
                          );
                        },
                        separatorBuilder: (ctx, i) => Divider(
                              color: Theme.of(context).colorScheme.background,
                              height: 10,
                            ),
                        itemCount: categories.length),
                  );
                }
                return Container();
              }),
        ],
      ),
    ));
  }
}
