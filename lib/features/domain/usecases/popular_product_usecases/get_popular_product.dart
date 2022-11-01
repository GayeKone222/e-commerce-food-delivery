import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/domain/repositories/popular_product_repository.dart';

class PupolarProductsUsecases {
  final PopularProductRepository popularProductRepository;

  PupolarProductsUsecases({required this.popularProductRepository});

  Future<Either<Failure,  List<ProductEntity>>> get() async =>
      await popularProductRepository.getPopularProducts();
}
