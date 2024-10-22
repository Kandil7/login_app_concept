import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepostitory {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, Unit>> login(String email, String password);
  Future<Either<Failure, Unit>> register(String email, String password);
  Future<Either<Failure, void>> logout();
}
