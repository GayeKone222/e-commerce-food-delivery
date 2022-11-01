import 'dart:convert';

import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/features/data/models/popular_product_model.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;

abstract class ApiRemoteDataSource {
  Future<List<ProductEntity>> getPupolarProducts();
}

class ApiRemoteDataSourceImpl implements ApiRemoteDataSource {
  final http.Client httpClient;

  ApiRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<ProductEntity>> getPupolarProducts() async {
    final url = Uri.parse(ApiConstant.getPopularProducsUrl);

    final response = await httpClient.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer token'
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<ProductEntity>.from(
          data['products'].map((e) => ProductModel.fromJson(e)));
    } else {
      throw Failure(message: "message");
    }
  }
}
