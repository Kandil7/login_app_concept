import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/auth/domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSource(this._firebaseAuth, this._firestore);

  Future<UserEntity> registerWithEmailAndPassword(
      String email, String password, String username) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;

    if (user != null) {
      await _saveUserData(user, email, username);
    }

    return (UserEntity(
      uid: user?.uid ?? '',
      email: email,
      name: username,
    ));
  }

  Future<UserEntity> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        await _updateUserToken(user);
      } else {
        throw const UserNotFoundFailure(message: 'User not found');
      }

      return (UserEntity(
          uid: user.uid, email: email, name: user.displayName ?? ''));
    } on Exception catch (e) {
      throw (UnknownFailure(message: e.toString()));
    }
  }

  Future<void> _updateUserToken(User user) async {
    try {
      final userToken = await user.getIdToken();
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({'token': userToken});
    } on Exception catch (e) {
      throw (UnknownFailure(message: e.toString()));
    }
  }

  Future<void> _saveUserData(User user, String email, String username) async {
    try {
      final userToken = await user.getIdToken();
      await _firestore.collection('users').doc(user.uid).set(UserModel(
              uid: user.uid,
              email: user.email ?? email,
              name: username,
              token: userToken ?? '')
          .toJson());
    } on Exception catch (e) {
      throw UnknownFailure(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception catch (e) {
      throw UnknownFailure(message: e.toString());
    }
  }

  Future<UserEntity> getUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        final userJson = userDoc.data();

        return UserModel.fromJson(userJson ?? {}).toEntity();
      } else {
        throw const UserNotFoundFailure(message: 'User not found');
      }
    } on Exception catch (e) {
      throw (UnknownFailure(message: e.toString()));
    }
  }
}
