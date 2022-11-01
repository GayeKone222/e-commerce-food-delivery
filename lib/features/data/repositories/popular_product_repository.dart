import 'package:e_commerce/features/data/datasources/local/api_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/remote/api_remote_data_source.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/domain/repositories/popular_product_repository.dart';

class PopularProductRepositoryImpl implements PopularProductRepository {
  final ApiRemoteDataSource apiRemoteDataSource;
  final ApiLocalDataSource apiDataDataSource;

  PopularProductRepositoryImpl(
      {required this.apiRemoteDataSource, required this.apiDataDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>>
      getPopularProducts() async {
    try {
      final List<ProductEntity> productEntity =
          await apiDataDataSource.getPupolarProducts();
      // final List<ProductEntity> ProductEntity =
      //     await apiRemoteDataSource.getPupolarProducts();

      return Right(productEntity);
    } on Failure {
      return Left(Failure(message: ""));
    }
  }
}
