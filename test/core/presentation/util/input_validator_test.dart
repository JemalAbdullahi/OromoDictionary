import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/core/presentation/util/input_validator.dart';

void main() {
  late InputValidator inputValidator;
  setUp(() {
    inputValidator = InputValidator();
  });
  group('isValid', () {
    test(
      'should return true when the string is not empty',
      () async {
        //arrange
        final str = "aback";
        //act
        final result = inputValidator.isValid(str);
        //assert
        expect(result, Right(true));
      },
    );
    test(
      'should return a failure when the string is empty',
      () async {
        //arrange
        final str = "";
        //act
        final result = inputValidator.isValid(str);
        //assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
