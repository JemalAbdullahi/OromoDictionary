import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

class InputValidator {
  Either<Failure, bool> isValid(String input) {
    try {
      emptyStringFormatException(input);
      return Right(input.isNotEmpty);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  void emptyStringFormatException(String str) {
    if (str.isEmpty) throw FormatException();
  }
}

class InvalidInputFailure extends Failure {}
