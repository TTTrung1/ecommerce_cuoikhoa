import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/model/product.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/products')
  Future<List<Product>> getProducts();

  @GET('/products/categories')
  Future<List<String>> getCategories();

  @GET('/products/category/{category}')
  Future<List<Product>> getProductsByCategory(@Path() String category);
}
