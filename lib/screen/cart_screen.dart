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
  final auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        elevation: 0,
        title: const Center(
          child: Text('Your Cart'),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        // buildWhen:  (previous, current) {
        //
        //    return prev  is! CartActionState;
        // },
        listener: (context, state) {},
        builder: (context, state) {
          print('cart screen $state');
          if (auth == null) {
            return const Center(
              child: Text(
                'Log in first to check out what\'s going on!',
                textAlign: TextAlign.center,
              ),
            );
          }
          // if(state.loading == true){
          //   return ;
          // }
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
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background,
                          );
                        },
                        itemCount: state.listItem.length,
                      )),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Total cost: ${state.totalCost}'))),
                      ],
                    ),
                  )
                ],
              ),
              if(state.loading)
              Center(child: CircularProgressIndicator())
            ],
          );
        },
      ),
    );
  }
}
