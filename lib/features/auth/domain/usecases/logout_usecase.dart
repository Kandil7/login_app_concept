import 'package:dartz/dartz.dart';

import 'package:social_app/core/errors/failure.dart';

import '../domain_layer.dart';

class LogoutUsecase {
  final AuthRepository _authRepository;

  LogoutUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call() async {
    return await _authRepository.logout();
  }
}
