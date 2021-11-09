import 'package:dartz/dartz.dart';
import '../entities/english_word.dart';
import '../../../../core/error/failures.dart';

abstract class EnglishDefinitionRepository{
  Future<Either<Failure,EnglishWord>> getEnglishDefinitions({required EnglishWord englishWord});
}