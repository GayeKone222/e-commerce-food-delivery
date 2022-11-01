import 'package:e_commerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/data/datasources/local/cart_local_data_source_references.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource cartLocalDataSource;

  CartRepositoryImpl({required this.cartLocalDataSource});

  @override
  Either<Failure, List<CartEntity>> getLocalCartItems() {
    try {
      return Right(cartLocalDataSource.getStoredCartData());
    } on Failure {
      return Left(Failure(message: ""));
    }
  }

  @override
  Either<Failure, void> storeLocalCartItems({required List<CartEntity> items}) {
    try {
      return Right(
          cartLocalDataSource.storeCartData(cartItems: items));
    } on Failure {
      return Left(Failure(message: ""));
    }
  }
  
  @override
  Either<Failure, void> clearLocalCartItems() {
   try {
      return Right(
          cartLocalDataSource.clearCartData());
    } on Failure {
      return Left(Failure(message: ""));
    }
  }
}
