import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/repositories/cart_repository.dart';

class CartUsecases {
  final CartRepository cartRepository;

  CartUsecases({required this.cartRepository});

  Either<Failure, List<CartEntity>> get() => cartRepository.getLocalCartItems();

  Either<Failure, void> store({required List<CartEntity> items}) =>
      cartRepository.storeLocalCartItems(items: items);

  Either<Failure, void> clear() => cartRepository.clearLocalCartItems();
}
