import 'dart:async';

import 'package:ecommerce_cuoikhoa/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/cart_item.dart';
import '../../repository/cart_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<CartStartedEvent>(_onStart);
    on<CartAddedEvent>(_onAdded);
    on<CartRemovedEvent>(_onRemoved);
  }

  Future<void> _onStart(CartStartedEvent event, Emitter<CartState> emit) async{
    print('on cart start');
    emit(CartLoading());
    try {

      await cartRepository.fetchFromFirebase();
      final listItem = cartRepository.listItem;
      emit(CartLoadSuccessState(listItem));

    } catch (e) {
      emit(CartErrorState());
    }
  }

  void _onAdded(CartAddedEvent event, Emitter<CartState> emit) {
    emit(CartLoading());
    try {
      print('on add');
      cartRepository.addToListItem(event.product);
      final listCartItem = cartRepository.listItem;
      emit(CartAddSuccessState());
    } catch (e) {
      emit(CartAddFailState());
    }
  }

  void _onRemoved(CartRemovedEvent event, Emitter<CartState> emit) {
    emit(CartLoading());
    try {
      emit(CartRemoveSuccessState());
    } catch (e) {
      emit(CartRemoveFailState());
    }
  }
}
