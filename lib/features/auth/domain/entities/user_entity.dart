import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String token;

  const UserEntity(
      {required this.uid,
      required this.email,
      required this.name,
      required this.token});

  @override
  List<Object?> get props => [uid, email, name, token];
}
