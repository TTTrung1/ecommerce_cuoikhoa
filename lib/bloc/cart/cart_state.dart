part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoadSuccessState extends CartState {}

class CartActionState extends CartState {}

class CartAddFailState extends CartActionState {}

class CartAddSuccessState extends CartActionState {}

class CartRemoveFailState extends CartActionState {}

class CartRemoveSuccessState extends CartActionState {}

class CartErrorState extends CartState {}
