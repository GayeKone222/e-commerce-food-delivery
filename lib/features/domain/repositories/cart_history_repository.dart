import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/cart_history_entity.dart';

abstract class CartHistoryRepository {
  Either<Failure, List<CartHistoryEntity>> getLocalCartHistory();
  Either<Failure, List<CartHistoryEntity>> storeLocalCartHistory({required List<CartHistoryEntity> orders});
     Either<Failure,void> clearLocalCartHistory();
}
