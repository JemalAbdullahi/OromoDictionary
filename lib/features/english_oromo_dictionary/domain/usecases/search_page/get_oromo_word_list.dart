import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/english_oromo_dictionary_repository.dart';

class GetOromoWordList implements UseCase<List<dynamic>, Params> {
  final EnglishOromoDictionaryRepository repository;

  GetOromoWordList(this.repository);

  @override
  Future<Either<Failure, List<dynamic>>> call(Params params) async {
    return await repository.getWordList(desiredList: "OromoWordList", searchTerm: params.oromoTerm);
  }
}

class Params extends Equatable {
  final String oromoTerm;

  Params({required this.oromoTerm});

  @override
  List<Object?> get props => [oromoTerm];
}
