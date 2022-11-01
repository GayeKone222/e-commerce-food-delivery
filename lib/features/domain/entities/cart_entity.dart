import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;
  final String img;
  final String? time;
  final int? quatity;
  final bool? isExist;
  final ProductEntity productEntity;

  const CartEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.img,
    required this.productEntity,
    this.time,
    this.quatity,
    this.isExist,
  });

  CartEntity copyWith(
      {int? id,
      String? name,
      String? description,
      int? price,
      String? img,
      String? time,
      int? quatity,
      bool? isExist,
      ProductEntity? productEntity}) {
    return CartEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        img: img ?? this.img,
        time: time ?? this.time,
        quatity: quatity ?? this.quatity,
        isExist: isExist ?? this.isExist,
        productEntity: productEntity ?? this.productEntity);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        img,
        time,
        quatity,
        isExist,
        productEntity
      ];
}
