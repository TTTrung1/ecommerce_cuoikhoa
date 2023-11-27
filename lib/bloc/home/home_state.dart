part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<Product> listAllProducts;
  final List<String> listAllCategories;
  final Map<String, List<Product>> mapProductByCategory;

  HomeLoadSuccess(
      {required this.listAllProducts,
      required this.listAllCategories,
      required this.mapProductByCategory});
}

class HomeLoadError extends HomeState {}

class HomeProductPressedState extends HomeState {
  final Product product;
  HomeProductPressedState(this.product);
}
