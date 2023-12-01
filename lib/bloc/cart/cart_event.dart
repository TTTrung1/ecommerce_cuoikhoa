part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartStartedEvent extends CartEvent{}

class CartAddedEvent extends CartEvent{
  final CartItem item;
  CartAddedEvent({required this.item});
}

class CartRemovedEvent extends CartEvent{
  final CartItem item;
  CartRemovedEvent({required this.item});
}

class CartDeletedEvent extends CartEvent{
  final CartItem item;
  CartDeletedEvent({required this.item});
}


