import '../usecase_imports.dart';

class GetOromoWordList implements UseCase<List<dynamic>, Params> {
  final EnglishOromoDictionaryRepository repository;

  GetOromoWordList(this.repository);

  @override

  ///UseCase to GET a list of oromo words that begins with the oromo search
  ///term provided.
  Future<Either<Failure, List<dynamic>>> call(Params params) async {
    return await repository.getWordList(
        desiredList: "OromoWordList", searchTerm: params.oromoTerm);
  }
}

class Params extends Equatable {
  final String oromoTerm;

  Params({required this.oromoTerm});

  @override
  List<Object?> get props => [oromoTerm];
}
