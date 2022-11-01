import 'package:e_commerce/features/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.price,
      required super.img,
      super.location,
      super.createdAt,
      super.updatedAt,
      super.typeId,
      super.isRecommended});

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      img: map['img'] as String,
      location: map['location'] != null ? map['location'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      typeId: map['typeId'] != null ? map['typeId'] as String : null,
      isRecommended:
          map['isRecommended'] != null ? map['isRecommended'] as bool : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "img": img,
      "location": location,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "typeId": typeId,
      "isRecommended": isRecommended,
    };
  }

  factory ProductModel.fromEntity({required ProductEntity productEntity}) {
    return ProductModel(
        id: productEntity.id,
        name: productEntity.name,
        description: productEntity.description,
        price: productEntity.price,
        img: productEntity.img,
        location: productEntity.location,
        createdAt: productEntity.createdAt,
        updatedAt: productEntity.updatedAt,
        typeId: productEntity.typeId,
        isRecommended: productEntity.isRecommended);
  }
}
