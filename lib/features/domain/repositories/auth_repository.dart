import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/auth_token_entity.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signUp({required UserEntity user});
  Future<Either<Failure, AuthTokenEntity>> signIn({required UserEntity user});

  Future<Either<Failure, void>> signOut();
}
