import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../entities/english_word.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/english_definition_repository.dart';

class GetEnglishDefinition implements UseCase<EnglishWord, Params> {
  final EnglishDefinitionRepository repository;

  GetEnglishDefinition(this.repository);

  @override
  Future<Either<Failure, EnglishWord>> call(Params params) async {
    return await repository.getEnglishDefinitions(englishWord: params.englishWord);
  }
}

class Params extends Equatable {
  final EnglishWord englishWord;

  Params({required this.englishWord});

  @override
  List<Object?> get props => [englishWord];
}
