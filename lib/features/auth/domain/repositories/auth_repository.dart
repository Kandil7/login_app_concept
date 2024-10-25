import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/data/models/login_model.dart';
import 'package:social_app/features/auth/data/models/register_model.dart';
import 'package:social_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, UserEntity>> login(LoginModel loginModel);
  Future<Either<Failure, UserEntity>> register(RegisterModel registerModel);
  Future<Either<Failure, Unit>> logout();
}
