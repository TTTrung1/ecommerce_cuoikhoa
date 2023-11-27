part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchStarted extends SearchEvent{}

class SearchEntered extends SearchEvent{
  final String query;

  SearchEntered(this.query);
}

class SearchCleared extends SearchEvent{

}

class SearchProductPressed extends SearchEvent{
  final Product product;
  SearchProductPressed(this.product);
}

