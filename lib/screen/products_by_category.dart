import 'package:ecommerce_cuoikhoa/widgets/preview_item.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

class ProductsByCategory extends StatelessWidget {
  const ProductsByCategory({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(5),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 20),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(5),
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                PreviewItem(product: products[index]));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: FadeInImage(
                              placeholder: const AssetImage('assets/Plink.png'),
                              image: NetworkImage(
                                products[index].image!,
                              ),
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 4.0,right: 4,left: 4),
                            child: Text(products[index].title!,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
