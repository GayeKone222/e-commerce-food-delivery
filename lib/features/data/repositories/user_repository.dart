import 'package:e_commerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/data/datasources/local/auth/auth_api_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/remote/user/user_api_remote_data_source.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiUserRemoteDataSource apiUserRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  UserRepositoryImpl({
    required this.apiUserRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      //get token
      String? token = authLocalDataSource.getToken();
      if (token != null) {
        UserEntity userEntity =
            await apiUserRemoteDataSource.getUser(token: token);
        return Right(userEntity);
      } else {
        return Left(Failure(message: "You should log in"));
      }
    }

    //  on Failure {
    //   rethrow;
    // }
    catch (e) {
      if (kDebugMode) {
        print("getUser error : $e");
      }
      return Left(Failure(message: e.toString()));
    }
  }
}
