import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../model/product.dart';

class CarouselSliderItem extends StatelessWidget {
  const CarouselSliderItem({super.key, required this.listProducts});

  final List<Product> listProducts;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: listProducts.map((e) {
          return GestureDetector(
            child: FadeInImage(
                placeholder: const AssetImage('assets/Plink.png'),
                image: NetworkImage(e.image!)),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Image.network(e.image!),
                      ));
            },
          );
        }).toList(),
        options: CarouselOptions(
            height: 200,
            aspectRatio: 0.7,
            autoPlay: true,
            autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
            autoPlayAnimationDuration: const Duration(seconds: 2)));

  }
}
