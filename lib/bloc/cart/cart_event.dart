part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartStartedEvent extends CartEvent{}

class CartAddedEvent extends CartEvent{}

class CartRemovedEvent extends CartEvent{}

