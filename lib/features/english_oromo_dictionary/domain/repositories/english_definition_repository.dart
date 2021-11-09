import 'package:dartz/dartz.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';
import '../../../../core/error/failures.dart';

abstract class EnglishDefinitionRepository{
  Future<Either<Failure,EnglishWord>> getEnglishDefinitions({required EnglishWord englishWord});
}