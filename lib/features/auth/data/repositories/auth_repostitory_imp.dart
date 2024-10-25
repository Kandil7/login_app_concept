import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/domain/domain_layer.dart';
import 'package:social_app/features/auth/data/data_layer.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      final user = await remoteDataSource.getUser();
      return Right(user);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(LoginModel loginModel) async {
    try {
      final user = await remoteDataSource.loginWithEmailAndPassword(
          loginModel.email, loginModel.password);
      return Right(user);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> register(RegisterModel registerModel) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
