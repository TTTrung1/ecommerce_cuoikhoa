import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_cuoikhoa/widgets/cart_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final guest = FirebaseAuth.instance.currentUser?.isAnonymous;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(CupertinoIcons.back),
        ),
        elevation: 0,
        title: const Text('yourCart').tr(),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (guest == true) {
            return const Center(
              child: Text(
                'Log in first to check out what\'s going on!',
                textAlign: TextAlign.center,
              ),
            );
          }
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return CartItemWidget(item: state.listItem[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Theme.of(context).colorScheme.background,
                      );
                    },
                    itemCount: state.listItem.length,
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text('\$: ${state.totalCost.toStringAsFixed(2)}'))),
                      ],
                    ),
                  )
                ],
              ),
              if (state.loading)
                const Center(child: CircularProgressIndicator())
            ],
          );
        },
      ),
    );
  }
}
