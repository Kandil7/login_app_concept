import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/features/auth/data/data_layer.dart';

import '../../domain/domain_layer.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepositoryImp authRepositoryImp;
  AuthCubit(this.authRepositoryImp) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepositoryImp
        .login(LoginModel(email: email, password: password));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> register(String email, String password, String name) async {
    emit(AuthLoading());
    final result = await authRepositoryImp.register(RegisterModel(
        email: email,
        password: password,
        name: name,
        confirmPassword: password));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await authRepositoryImp.logout();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthInitial()),
    );
  }

  Future<void> getUser() async {
    emit(AuthLoading());
    final result = await authRepositoryImp.getUser();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
