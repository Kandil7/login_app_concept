import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/data/models/login_model.dart';
import 'package:social_app/features/auth/domain/entities/user_entity.dart';
import 'package:social_app/features/auth/domain/repositories/auth_repository.dart';

class LogingUsecase {
  final AuthRepository repository;

  LogingUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call(
      String email, String password) async {
    return await repository.login(LoginModel(email: email, password: password));
  }
}
