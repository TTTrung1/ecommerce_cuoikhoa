import 'package:dio/dio.dart';
import 'package:ecommerce_cuoikhoa/api_provider/rest_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../../model/product.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStarted>(_onHomeInit);
    on<HomeProductPressed>(_onProductPress);
  }

  Future<void> _onHomeInit(HomeStarted event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final restClient = RestClient(Dio(BaseOptions()));
      final List<Product> products = await restClient.getProducts();
      final List<String> categories = await restClient.getCategories();
      final Map<String, List<Product>> productsByCategory = {};
      for (var element in categories) {
        final List<Product> productsByEachCat =
            await restClient.getProductsByCategory(element);
        productsByCategory.addEntries([MapEntry(element, productsByEachCat)]);
      }
      emit(HomeLoadSuccess(listAllProducts: products, listAllCategories: categories, mapProductByCategory: productsByCategory));
    } catch (e) {
      rethrow;
    }
  }

  void _onProductPress(HomeProductPressed event,Emitter<HomeState> emit){
    emit(HomeProductPressedState(event.product));
  }
}
