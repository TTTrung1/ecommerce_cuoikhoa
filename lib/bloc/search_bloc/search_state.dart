part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState{}

class SearchSuccess extends SearchState{
  final List<Product> listP;

  SearchSuccess(this.listP);
}

class SearchProductPressState extends SearchState{
  final Product product;
  SearchProductPressState(this.product);
}

class SearchError extends SearchState{}

