import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;
  final String img;
  final String? location;
  final String? createdAt;
  final String? updatedAt;
  final String? typeId;
  final bool? isRecommended;

  const ProductEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId,
      this.isRecommended});

  ProductEntity copyWith(
      {int? id,
      String? name,
      String? description,
      int? price,
      String? img,
      String? location,
      String? createdAt,
      String? updatedAt,
      String? typeId,
      bool? isRecommended}) {
    return ProductEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        img: img ?? this.img,
        location: location ?? this.location,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        typeId: typeId ?? this.typeId,
        isRecommended: isRecommended ?? this.isRecommended);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        img,
        location,
        createdAt,
        updatedAt,
        typeId,
        isRecommended
      ];
}
