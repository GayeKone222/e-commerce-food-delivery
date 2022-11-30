import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/auth_token_entity.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/entities/cart_history_entity.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/domain/repositories/auth_repository.dart';

class AuthUsecases {
  final AuthRepository authRepository;

  AuthUsecases({required this.authRepository});

  Future<Either<Failure, void>> signUp({required UserEntity user}) =>
      authRepository.signUp(user: user);
  Future<Either<Failure, AuthTokenEntity>> signIn({required UserEntity user}) =>
      authRepository.signIn(user: user);
  Future<Either<Failure, void>> signOut() => authRepository.signOut();
}
