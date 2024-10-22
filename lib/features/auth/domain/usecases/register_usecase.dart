import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/domain/repositories/auth_repostitory.dart';

class RegisterUsecase {
  final AuthRepostitory repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
