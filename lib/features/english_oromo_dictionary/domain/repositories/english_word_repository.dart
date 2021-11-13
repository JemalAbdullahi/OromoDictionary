import 'package:dartz/dartz.dart';
import '../entities/english_word.dart';
import '../../../../core/error/failures.dart';

abstract class EnglishWordRepository{
  Future<Either<Failure,EnglishWord>> getEnglishWord({required EnglishWord englishWord});
}