import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  const RegisterEntity({
    this.uid = '',
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  final String uid;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object> get props => [uid, name, email, password, confirmPassword];
}
