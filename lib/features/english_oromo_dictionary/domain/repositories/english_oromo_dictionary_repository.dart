import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class EnglishOromoDictionaryRepository {
  Future<Either<Failure, List<dynamic>>> getWordList(
      {required String desiredList, required String searchTerm});
}