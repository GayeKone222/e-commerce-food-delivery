import 'package:e_commerce/features/data/datasources/local/api_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/remote/products/api_remote_data_source.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/domain/repositories/popular_product_repository.dart';

class PopularProductRepositoryImpl implements PopularProductRepository {
  final ApiRemoteDataSource apiRemoteDataSource;
  final ApiLocalDataSource apiLocalDataDataSource;

  PopularProductRepositoryImpl(
      {required this.apiRemoteDataSource,
      required this.apiLocalDataDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getPopularProducts() async {
    try {
      // final List<ProductEntity> productEntity =
      //     await apiLocalDataDataSource.getPupolarProducts();
      final List<ProductEntity> productEntity =
          await apiRemoteDataSource.getPupolarProducts();

      return Right(productEntity);
    } on Failure {
      return Left(Failure(message: ""));
    }
  }
}
