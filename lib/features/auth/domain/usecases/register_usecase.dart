import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/data/models/register_model.dart';
import 'package:social_app/features/auth/domain/repositories/auth_repostitory.dart';

class RegisterUsecase {
  final AuthRepostitory repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, UserCredential>> call(RegisterModel user) async {
    return await repository.register(user);
  }
}
