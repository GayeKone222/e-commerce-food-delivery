import 'package:e_commerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/data/datasources/local/auth/auth_api_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/remote/auth/auth_api_remote_data_source.dart';
import 'package:e_commerce/features/data/models/user_model.dart';
import 'package:e_commerce/features/domain/entities/auth_token_entity.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiAuthRemoteDataSource apiAuthRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.apiAuthRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, void>> signUp({required UserEntity user}) async {
    try {
      await apiAuthRemoteDataSource.signUp(
          user: UserModel.fromEntity(userEntity: user));
      return const Right(null);
    } on Failure {
      rethrow;
    } catch (e) {
       if (kDebugMode) {
        print("signUP error : $e");
      }
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> signIn(
      {required UserEntity user}) async {
    try {
      AuthTokenEntity token = await apiAuthRemoteDataSource.signIn(
          user: UserModel.fromEntity(userEntity: user));
      return Right(token);
    } on Failure {
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print("signIn error : $e");
      }
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      authLocalDataSource.clearTokenData();
      return const Right(null);
    } on Failure {
      rethrow;
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
