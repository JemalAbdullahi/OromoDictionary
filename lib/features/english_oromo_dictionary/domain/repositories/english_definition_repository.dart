import 'package:dartz/dartz.dart';
import 'package:oromo_dictionary/core/error/failures.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/grammatical_form.dart';

abstract class EnglishDefinitionRepository{
  Future<Either<Failure,List<GrammaticalForm>>> getGrammaticalFormList({required int wordID});
}