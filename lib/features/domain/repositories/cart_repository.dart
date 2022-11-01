import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Either<Failure, List<CartEntity>> getLocalCartItems();
  Either<Failure, void> storeLocalCartItems({required List<CartEntity> items});
   Either<Failure,void> clearLocalCartItems();
}
