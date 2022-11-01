import 'dart:convert';

import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/features/data/models/cart_model.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataSource {
  List<CartEntity> getStoredCartData();

  void storeCartData({required List<CartEntity> cartItems});

  void clearCartData();
}

class CartLocalDataSourceImpl
    implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  List<CartEntity> getStoredCartData() {
    try {
      List<CartEntity> items = [];
      if (sharedPreferences.containsKey(SharedPreferencesKeys.CART_ITEMS)) {
        final data = sharedPreferences.getStringList(SharedPreferencesKeys.CART_ITEMS);

        items = data!.map((e) => CartModel.fromJson(jsonDecode(e))).toList();
      }
      print("Cart-Items (get): $items");
      return items;
    } catch (e) {
      print("getStoredCartData error $e");
      throw Failure(message: "$e");
    }
  }

  @override
  void storeCartData({required List<CartEntity> cartItems}) async {
    try {
      List<String> items = [];

      for (var element in cartItems) {
        items.add(
            jsonEncode(CartModel.fromEntity(cartEntity: element).toJson()));
      }

      sharedPreferences.setStringList(SharedPreferencesKeys.CART_ITEMS, items);
      print("Cart-Items (store): $items");
    } catch (e) {
      print("storeCartData error : $e");
      throw Failure(message: "$e");
    }
  }

  @override
  void clearCartData() {
    try {
     
      if (sharedPreferences.containsKey(SharedPreferencesKeys.CART_ITEMS)) {
        sharedPreferences.remove(SharedPreferencesKeys.CART_ITEMS);
      }
    } catch (e) {
      print("getStoredCartData error $e");
      throw Failure(message: "$e");
    }
  }
}
