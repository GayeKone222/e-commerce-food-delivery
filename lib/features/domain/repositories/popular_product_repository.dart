import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';

abstract class PopularProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getPopularProducts();
}
