import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/english_oromo_dictionary_repository.dart';

class GetEnglishTranslations implements UseCase<List<dynamic>, Params> {
  final EnglishOromoDictionaryRepository repository;

  GetEnglishTranslations(this.repository);

  @override
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
