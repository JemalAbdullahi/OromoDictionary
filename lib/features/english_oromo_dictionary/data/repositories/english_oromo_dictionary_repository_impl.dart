import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/english_word.dart';
import '../../domain/entities/oromo_translation.dart';
import '../../domain/repositories/english_oromo_dictionary_repository.dart';
import '../datasources/english_oromo_dictionary_local_data_source.dart';
import '../datasources/english_oromo_dictionary_remote_data_source.dart';

class EnglishOromoDictionaryRepositoryImpl
    implements EnglishOromoDictionaryRepository {
  final EnglishOromoDictionaryRemoteDataSource remoteDataSource;
  final EnglishOromoDictionaryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  EnglishOromoDictionaryRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
      
  @override
  Future<Either<Failure, List<EnglishWord>>> getEnglishWordList(
      String englishTerm) {
    // TODO: implement getEnglishWordList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OromoTranslation>>> getOromoWordList(
      String oromoTerm) {
    // TODO: implement getOromoWordList
    throw UnimplementedError();
  }
}
