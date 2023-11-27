import 'package:dio/dio.dart';
import 'package:ecommerce_cuoikhoa/api_provider/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/product.dart';

final logger = Logger();
class CallApi with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async{
    final dio = Dio();
    dio.options.baseUrl = 'https://fakestoreapi.com';
    final client = RestClient(dio);
    try{
      _products = await client.getProducts();
      notifyListeners();
    }
    catch(e){
      rethrow;
    }
  }
}
