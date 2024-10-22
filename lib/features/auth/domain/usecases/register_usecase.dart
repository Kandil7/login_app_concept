import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/domain/entities/user_entity.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, Unit>> call(UserEntity params) async {
    return await repository.register(params);
  }
}
