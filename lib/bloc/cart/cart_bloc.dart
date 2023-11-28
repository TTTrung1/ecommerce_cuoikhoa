import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartStartedEvent>(_onStart);
    on<CartAddedEvent>(_onAdded);
    on<CartRemovedEvent>(_onRemoved);
  }

  void _onStart(CartStartedEvent event, Emitter<CartState> emit) {
    emit(CartLoading());
    try {
      print('on start');
      emit(CartLoadSuccessState());

    } catch (e) {
      emit(CartErrorState());
    }
  }

  void _onAdded(CartAddedEvent event, Emitter<CartState> emit) {
    emit(CartLoading());
    try {
      print('on add');
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
