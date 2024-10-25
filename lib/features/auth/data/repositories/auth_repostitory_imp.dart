import 'package:dartz/dartz.dart';
import 'package:social_app/features/auth/data/datasources/remote_datasource/auth_remote_datasource.dart';
import '../../core/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> register(
      String email, String password, String username) async {
    try {
      final user = await remoteDataSource.registerWithEmailAndPassword(
          email, password, username);
      if (user != null) {
        return Right(UserEntity(id: user.uid, email: user.email!));
      } else {
        return Left(AuthFailure("Registration failed"));
      }
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
