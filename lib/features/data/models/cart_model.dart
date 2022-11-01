import 'package:e_commerce/features/data/models/popular_product_model.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.price,
      required super.img,
      required super.productEntity,
      super.time,
      super.isExist,
      super.quatity});

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
        id: map['id'] as int,
        name: map['name'] as String,
        description: map['description'] as String,
        price: map['price'] as int,
        img: map['img'] as String,
        time: map['time'] as String,
        isExist: map['isExist'] as bool,
        quatity: map['quatity'] as int,
        productEntity: ProductModel.fromJson(map['productEntity']));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "img": img,
      "time": time,
      "isExist": isExist,
      "quatity": quatity,
      "productEntity":
          ProductModel.fromEntity(productEntity: productEntity).toJson()
    };
  }

  factory CartModel.fromEntity({CartEntity? cartEntity}) {
    return CartModel(
        id: cartEntity!.id,
        name: cartEntity.name,
        description: cartEntity.description,
        price: cartEntity.price,
        img: cartEntity.img,
        time: cartEntity.time,
        quatity: cartEntity.quatity,
        isExist: cartEntity.isExist,
        productEntity: cartEntity.productEntity);
  }
}
