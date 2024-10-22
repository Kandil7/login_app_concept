import 'package:dartz/dartz.dart';

import 'package:social_app/core/errors/failure.dart';

import 'package:social_app/features/auth/domain/entities/user_entity.dart';

import '../../domain/repositories/auth_repostitory.dart';

class AuthRepostitoryImp extends AuthRepostitory {
  @override
  Future<Either<Failure, UserEntity>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
