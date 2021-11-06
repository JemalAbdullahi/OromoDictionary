import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/english_oromo_dictionary_repository.dart';

class GetEnglishWordList implements UseCase<List<dynamic>, Params> {
  final EnglishOromoDictionaryRepository repository;

  GetEnglishWordList(this.repository);

  @override
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
