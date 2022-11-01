import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/entities/cart_history_entity.dart';
import 'package:e_commerce/features/domain/repositories/cart_history_repository.dart';

class CartHistoryUsecases {
  final CartHistoryRepository cartHistoryRepository;

  CartHistoryUsecases({required this.cartHistoryRepository});

 
  Either<Failure, List<CartHistoryEntity>> get() => cartHistoryRepository.getLocalCartHistory();
  Either<Failure, List<CartHistoryEntity>> store({required List<CartHistoryEntity> orders}) =>
      cartHistoryRepository.storeLocalCartHistory(orders: orders);
    Either<Failure, void> clear() => cartHistoryRepository.clearLocalCartHistory();
}
