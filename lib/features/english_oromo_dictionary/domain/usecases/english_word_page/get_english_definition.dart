import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../entities/english_word.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/english_word_repository.dart';

class GetEnglishWord implements UseCase<EnglishWord, Params> {
  final EnglishWordRepository repository;

  GetEnglishWord(this.repository);

  @override
  Future<Either<Failure, EnglishWord>> call(Params params) async {
    return await repository.getEnglishWord(englishWord: params.englishWord);
  }
}

class Params extends Equatable {
  final EnglishWord englishWord;

  Params({required this.englishWord});

  @override
  List<Object?> get props => [englishWord];
}
