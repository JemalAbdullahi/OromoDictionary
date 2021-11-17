import '../usecase_imports.dart';

class GetEnglishWordList implements UseCase<List<dynamic>, Params> {
  final EnglishOromoDictionaryRepository repository;

  GetEnglishWordList(this.repository);

  @override
  ///UseCase to GET a list of english words that begins with the english search
  ///term provided.
  Future<Either<Failure, List>> call(Params params) async {
    return await repository.getWordList(
        desiredList: "EnglishWordList",
        searchTerm: params.englishTerm);
  }
}

class Params extends Equatable {
  final String englishTerm;

  Params({required this.englishTerm});

  @override
  List<Object?> get props => [englishTerm];
}
