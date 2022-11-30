import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/domain/repositories/user_repository.dart';

class UserUsecases {
  final UserRepository userRepository;

  UserUsecases({required this.userRepository});

  Future<Either<Failure, UserEntity>> getUser() => userRepository.getUser();
}
