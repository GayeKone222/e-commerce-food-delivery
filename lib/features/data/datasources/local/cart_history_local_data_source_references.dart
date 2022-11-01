import 'dart:convert';

import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/features/data/models/cart_history_model.dart';
import 'package:e_commerce/features/data/models/cart_model.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/entities/cart_history_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartHistoryLocalDataSource {
  List<CartHistoryEntity> getStoredCartHistoryData();

  List<CartHistoryEntity> storeCartHistoryData(
      {required List<CartHistoryEntity> orders});

  void clearCartHistoryData();
}

class CartHistoryLocalDataSourceImpl implements CartHistoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartHistoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  List<CartHistoryEntity> getStoredCartHistoryData() {
    try {
      List<CartHistoryEntity> items = [];
      if (sharedPreferences.containsKey(SharedPreferencesKeys.CART_HISTORY)) {
        final data =
            sharedPreferences.getStringList(SharedPreferencesKeys.CART_HISTORY);

        items =
            data!.map((e) => CartHistoryModel.fromJson(jsonDecode(e))).toList();
      }
      print("Cart-History (get): $items");
      return items;
    } catch (e) {
      print("getStoredCartHistoryData error $e");
      throw Failure(message: "$e");
    }
  }

  @override
  List<CartHistoryEntity> storeCartHistoryData(
      {required List<CartHistoryEntity> orders}) {
    try {
      List<String> items = [];
      List<CartHistoryEntity> allOrders = List<CartHistoryEntity>.from(orders);

      
      for (var element in allOrders) {
        items.add(jsonEncode(
            CartHistoryModel.fromEntity(cartHistoryEntity: element).toJson()));
      }
     
      sharedPreferences.setStringList(
          SharedPreferencesKeys.CART_HISTORY, items);
      
      print("Cart-History (store): ${items.length}");

      return allOrders;
    } catch (e) {
      print("step storeCartHistoryData error : $e");
      throw Failure(message: "$e");
    }
  }

  @override
  void clearCartHistoryData() {
    try {
      if (sharedPreferences.containsKey(SharedPreferencesKeys.CART_HISTORY)) {
        sharedPreferences.remove(SharedPreferencesKeys.CART_HISTORY);
      }
    } catch (e) {
      print("getStoredCartHistoryData error $e");
      throw Failure(message: "$e");
    }
  }
}
