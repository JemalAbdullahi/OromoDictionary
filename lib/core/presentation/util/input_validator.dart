import 'package:dartz/dartz.dart';
import 'package:oromo_dictionary/core/error/failures.dart';

class InputValidator {
  Either<Failure, bool> isValid(String str) {
    try {
      if (str.isEmpty) throw FormatException();
      return Right(str.isNotEmpty);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
