import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

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
  Future<Either<Failure, UserCredential>> login(
      String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');

        return const Left(WeakPasswordFailure());
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        return const Left(EmailAlreadyInUseFailure());
      }
    } catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
    return const Left(UnknownFailure());
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
