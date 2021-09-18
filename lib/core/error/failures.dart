import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General Failure
class ServerFailure extends Failure {}

class ConnectionFailure extends Failure{}
//Unnecessary Failure
class CacheFailure extends Failure {}

