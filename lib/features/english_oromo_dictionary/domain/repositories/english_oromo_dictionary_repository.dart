import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/english_word.dart';
import '../entities/oromo_translation.dart';

abstract class EnglishOromoDictionaryRepository {
  Future<Either<Failure, List<OromoTranslation>>> getOromoWordList(
      String oromoTerm);
  Future<Either<Failure, List<EnglishWord>>> getEnglishWordList(
      String englishTerm);
}
