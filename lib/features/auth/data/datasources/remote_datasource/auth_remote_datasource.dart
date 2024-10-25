import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSource(this._firebaseAuth, this._firestore);

  Future<User?> registerWithEmailAndPassword(
      String email, String password, String username) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;

    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'username': username,
        'email': user.email,
      });
    }

    return user;
  }
}
