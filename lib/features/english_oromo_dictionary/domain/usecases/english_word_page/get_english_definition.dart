import '../usecase_imports.dart';
import '../../entities/english_word.dart';
import '../../repositories/english_word_repository.dart';

class GetEnglishWord implements UseCase<EnglishWord, Params> {
  final EnglishWordRepository repository;

  GetEnglishWord(this.repository);

  @override

  ///UseCase to GET the EnglishWord complete with the english dictionary definition,
  ///grammatical forms, phrases, and translations.
  Future<Either<Failure, EnglishWord>> call(Params params) async =>
      await repository.getEnglishWord(englishWord: params.englishWord);
}

class Params extends Equatable {
  final EnglishWord englishWord;

  Params({required this.englishWord});

  @override
  List<Object?> get props => [englishWord];
}
