import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:ecommerce_cuoikhoa/model/product.dart';

import '../../api_provider/rest_client.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchStarted>(_onStart);
    on<SearchEntered>(_onEntered);
    on<SearchCleared>(_onCleared);
    on<SearchProductPressed>(_onProductPressed);
  }

  void _onStart(SearchEvent event, Emitter<SearchState> emit) {
    print('started');
    emit(SearchInitial());
    emit(SearchSuccess([]));
  }

  Future<void> _onEntered(SearchEntered event, Emitter<SearchState> emit) async{
    print('entered');
    emit(SearchLoading());
    final restClient = RestClient(Dio(BaseOptions()));
    final List<Product> products = await restClient.getProducts();
    try {
      // await Future.delayed(const Duration(seconds: 1));
      emit(SearchSuccess(products
          .where((element) =>
              element.title!.toLowerCase().contains(event.query.toLowerCase()))
          .toList()));
    } catch (e) {
      emit(SearchError());
      rethrow;
    }
  }

  void _onCleared(SearchCleared event, Emitter<SearchState> emit) {
    emit(SearchLoading());
    try {
      emit(SearchSuccess([]));
    } catch (e) {
      rethrow;
    }
  }

  void _onProductPressed(SearchProductPressed event,Emitter<SearchState> emit){
    emit(SearchProductPressState(event.product));
  }
}
