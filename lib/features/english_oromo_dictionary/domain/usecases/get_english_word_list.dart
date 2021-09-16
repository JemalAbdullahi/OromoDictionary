import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/english_word.dart';
import '../repositories/english_oromo_dictionary_repository.dart';

class GetEnglishWordList implements UseCase<List<EnglishWord>, Params> {
  final EnglishOromoDictionaryRepository repository;

  GetEnglishWordList(this.repository);

  @override
  Future<Either<Failure, List<EnglishWord>>> call(Params params) async {
    return await repository.getEnglishWordList(params.englishTerm);
  }
}

class Params extends Equatable {
  final String englishTerm;

  Params({required this.englishTerm});

  @override
  List<Object?> get props => [englishTerm];
}
