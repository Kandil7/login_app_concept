import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({String? message})
      : super(message: message ?? 'Server Failure');
}

class CacheFailure extends Failure {
  const CacheFailure({String? message})
      : super(message: message ?? 'Cache Failure');
}

class AuthFailure extends Failure {
  const AuthFailure({String? message})
      : super(message: message ?? 'Authentication Failure');
}

class NetworkFailure extends Failure {
  const NetworkFailure({String? message})
      : super(message: message ?? 'Network Failure');
}

class UnknownFailure extends Failure {
  const UnknownFailure({String? message})
      : super(message: message ?? 'Unknown Failure');
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({String? message})
      : super(message: message ?? 'Invalid Input Failure');
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({String? message})
      : super(message: message ?? 'No Internet Failure');
}

class NoLocalDataFailure extends Failure {
  const NoLocalDataFailure({String? message})
      : super(message: message ?? 'No Local Data Failure');
}

class NoRemoteDataFailure extends Failure {
  const NoRemoteDataFailure({String? message})
      : super(message: message ?? 'No Remote Data Failure');
}

class NoCachedDataFailure extends Failure {
  const NoCachedDataFailure({String? message})
      : super(message: message ?? 'No Cached Data Failure');
}

class NoDataFailure extends Failure {
  const NoDataFailure({String? message})
      : super(message: message ?? 'No Data Failure');
}

class NoDataConnectionFailure extends Failure {
  const NoDataConnectionFailure({String? message})
      : super(message: message ?? 'No Data Connection Failure');
}

class NoDataConnectionAndLocalDataFailure extends Failure {
  const NoDataConnectionAndLocalDataFailure({String? message})
      : super(message: message ?? 'No Data Connection And Local Data Failure');
}

class NoDataConnectionAndRemoteDataFailure extends Failure {
  const NoDataConnectionAndRemoteDataFailure({String? message})
      : super(message: message ?? 'No Data Connection And Remote Data Failure');
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure({String? message})
      : super(message: message ?? "The password provided is too weak.");
}

class EmailAlreadyInUseFailure extends Failure {
  const EmailAlreadyInUseFailure({String? message})
      : super(message: message ?? "The account already exists for that email.");
}

class WrongPasswordFailure extends Failure {
  const WrongPasswordFailure({String? message})
      : super(message: message ?? "Wrong password provided for that user.");
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure({String? message})
      : super(message: message ?? "No user found for that email.");
}
