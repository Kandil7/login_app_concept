import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/data/models/login_model.dart';
import 'package:social_app/features/auth/data/models/register_model.dart';

import 'package:social_app/features/auth/domain/entities/user_entity.dart';

import '../../domain/repositories/auth_repostitory.dart';

class AuthRepostitoryImp extends AuthRepostitory {
  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    final User = FirebaseAuth.instance.currentUser;
    if (User != null) {
      final token = User.getIdToken();
      return Right(UserEntity(
        email: User.email ?? '',
        uid: User.uid,
        name: User.displayName ?? '',
        token: token.toString(),
      ));
    } else {
      return const Left(UserNotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> login(LoginModel loginModel) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: loginModel.email,
        password: loginModel.password,
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
  Future<Either<Failure, Unit>> logout() async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        FirebaseAuth.instance.signOut();
      } else {
        debugPrint('No user found');
        return const Left(UserNotFoundFailure());
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
    return const Left(UnknownFailure());
  }

  @override
  Future<Either<Failure, UserCredential>> register(
      RegisterModel registerModel) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: registerModel.email, password: registerModel.password);
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        return const Left(UserNotFoundFailure());
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return Left(WrongPasswordFailure(message: e.toString()));
      }
    } catch (authException) {
      debugPrint(authException.toString());
      return Left(ServerFailure(message: authException.toString()));
    }
    return const Left(UnknownFailure());
  }
}
