import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../model/cart_item.dart';
import '../../repository/cart_repository.dart';

part 'cart_event.dart';

part 'cart_bloc.freezed.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(const CartState()) {
    on<CartStartedEvent>(_onStart);
    on<CartAddedEvent>(_onAdded);
    on<CartRemovedEvent>(_onRemoved);
  }

  Future<void> _onStart(CartStartedEvent event, Emitter<CartState> emit) async {
    print('on cart start');
    emit(state.copyWith(loading: true));
    try {
      await cartRepository.fetchFromFirebase();
      final totalCost = await cartRepository.totalCost();
      final listItem = cartRepository.listItem;
      emit(state.copyWith(
        listItem: listItem,
        totalCost: totalCost,
        loading: false,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  void _onAdded(CartAddedEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      await cartRepository.addToCart(event.item);
      final totalCost = await cartRepository.totalCost();
      final listItem = cartRepository.listItem;
      emit(state.copyWith(
          listItem: listItem, totalCost: totalCost, loading: false,clicked: true));
      print('state in bloc: $state');
      emit(state.copyWith(clicked: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  void _onRemoved(CartRemovedEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      await cartRepository.removeQuantity(event.item);

      final totalCost = await cartRepository.totalCost();
      final listItem = cartRepository.listItem;
      emit(state.copyWith(
          listItem: listItem, totalCost: totalCost, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

}
