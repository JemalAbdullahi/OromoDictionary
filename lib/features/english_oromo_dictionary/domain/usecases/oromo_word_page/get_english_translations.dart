import '../usecase_imports.dart';

class GetEnglishTranslations implements UseCase<List<dynamic>, Params> {
  final EnglishOromoDictionaryRepository repository;

  GetEnglishTranslations(this.repository);

  @override
  ///UseCase to GET the list of english translations from the oromo word
  Future<Either<Failure, List<dynamic>>> call(Params params) async {
    return await repository.getWordList(
        desiredList: "EnglishTranslation",
        searchTerm: params.oromoWord);
  }
}

class Params extends Equatable {
  final String oromoWord;

  Params({required this.oromoWord});

  @override
  List<Object?> get props => [oromoWord];
}
