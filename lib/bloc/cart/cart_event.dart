part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartStartedEvent extends CartEvent{}

class CartAddedEvent extends CartEvent{
  final Product product;
  CartAddedEvent({required this.product});
}

class CartRemovedEvent extends CartEvent{}

