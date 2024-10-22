import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/data/models/login_model.dart';
import 'package:social_app/features/auth/data/models/register_model.dart';
import 'package:social_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepostitory {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, UserCredential>> login(LoginModel loginModel);
  Future<Either<Failure, UserCredential>> register(RegisterModel registerModel);
  Future<Either<Failure, void>> logout();
}
