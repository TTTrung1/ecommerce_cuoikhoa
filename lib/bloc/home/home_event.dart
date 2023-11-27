part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeStarted extends HomeEvent {}

class HomeProductPressed extends HomeEvent {
  final Product product;
  HomeProductPressed(this.product);
}

