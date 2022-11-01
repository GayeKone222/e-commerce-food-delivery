import 'package:e_commerce/features/data/models/cart_model.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/entities/cart_history_entity.dart';

class CartHistoryModel extends CartHistoryEntity {
  const CartHistoryModel({required super.time, required super.cartEntities});

  factory CartHistoryModel.fromJson(Map<String, dynamic> map) {
    return CartHistoryModel(
      time: map['time'] as String,
      cartEntities: List<CartEntity>.from(
          map['cartEntities'].map((x) => CartModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "cartEntities": cartEntities
          .map((e) => CartModel.fromEntity(cartEntity: e).toJson())
          .toList()
    };
  }

  factory CartHistoryModel.fromEntity(
      {required CartHistoryEntity cartHistoryEntity}) {
    return CartHistoryModel(
        time: cartHistoryEntity.time,
        cartEntities: cartHistoryEntity.cartEntities);
  }
}
