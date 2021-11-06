import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/grammatical_form.dart';

abstract class EnglishDefinitionRepository{
  Future<Either<Failure,List<GrammaticalForm>>> getGrammaticalFormList({required int wordID});
}