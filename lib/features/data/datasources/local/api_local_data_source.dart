import 'dart:convert';

import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/data/models/popular_product_model.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:flutter/services.dart' show rootBundle;

//...
Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}

abstract class ApiLocalDataSource {
  Future<List<ProductEntity>> getPupolarProducts();
}

class ApiLocalDataSourceImpl implements ApiLocalDataSource {
  ApiLocalDataSourceImpl();

  @override
  Future<List<ProductEntity>> getPupolarProducts() async {
    Map<String, dynamic> json =
        await parseJsonFromAssets('assets/json/popular_products.json');

    try {
      return List<ProductEntity>.from(json['products']
          .map((e) => ProductModel.fromJson(e).copyWith(isRecommended: false)));
    } catch (e) {
      print("getPupolarProducts error : $e");
      throw Failure(message: "message");
    }
  }

  @override
  Future<List<ProductEntity>> getRecommendedProducts() async {
    Map<String, dynamic> json =
        await parseJsonFromAssets('assets/json/recommended_products.json');

    try {
      return List<ProductEntity>.from(
          json['products'].map((e) => ProductModel.fromJson(e).copyWith(isRecommended: true)));
    } catch (e) {
      print("getRecommendedProducts error : $e");
      throw Failure(message: "message");
    }
  }
}
