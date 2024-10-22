import 'package:dartz/dartz.dart';
import 'package:social_app/features/auth/domain/entities/user_entity.dart';

abstract class UserRepo {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password);
  Future<Either<Failure, void>> logout();
}
