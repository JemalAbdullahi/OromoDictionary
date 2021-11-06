import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/grammatical_form.dart';
import '../../repositories/english_definition_repository.dart';

class GetGrammaticalFormList implements UseCase<List<dynamic>, Params> {
  final EnglishDefinitionRepository repository;

  GetGrammaticalFormList({required this.repository});

  @override
  Future<Either<Failure, List<GrammaticalForm>>> call(Params params) async {
    return await repository.getGrammaticalFormList(wordID: params.wordID);
  }
}

class Params extends Equatable {
  final int wordID;

  Params({required this.wordID});

  @override
  List<Object?> get props => [wordID];
}
