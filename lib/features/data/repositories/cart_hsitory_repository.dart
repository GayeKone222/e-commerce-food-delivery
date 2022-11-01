import 'package:e_commerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/data/datasources/local/cart_history_local_data_source_references.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/entities/cart_history_entity.dart';
import 'package:e_commerce/features/domain/repositories/cart_history_repository.dart';

class CartHistoryRepositoryImpl implements CartHistoryRepository {
  final CartHistoryLocalDataSource cartHistoryLocalDataSource;

  CartHistoryRepositoryImpl({required this.cartHistoryLocalDataSource});



  @override
  Either<Failure, List<CartHistoryEntity>> getLocalCartHistory() {
    try {
      return Right(cartHistoryLocalDataSource.getStoredCartHistoryData());
    } on Failure {
      return Left(Failure(message: ""));
    }
  }

  @override
  Either<Failure, List<CartHistoryEntity>> storeLocalCartHistory(
      {required List<CartHistoryEntity> orders}) {
    try {
      return Right(
          cartHistoryLocalDataSource.storeCartHistoryData(orders: orders));
    } on Failure {
      return Left(Failure(message: ""));
    }
  }


    @override
  Either<Failure, void> clearLocalCartHistory() {
   try {
      return Right(
          cartHistoryLocalDataSource.clearCartHistoryData());
    } on Failure {
      return Left(Failure(message: ""));
    }
  }
}
