import 'package:dartz/dartz.dart';
import 'package:oromo_dictionary/core/error/exceptions.dart';

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
  Future<Either<Failure, List<dynamic>>> getWordList({required bool isEnglish, required String searchTerm}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWordList = isEnglish
            ? await remoteDataSource.getEnglishWordList(searchTerm)
            : await remoteDataSource.getOromoWordList(searchTerm);
        isEnglish
            ? localDataSource
                .cacheEnglishWordList(remoteWordList as List<EnglishWord>)
            : localDataSource
                .cacheOromoWordList(remoteWordList as List<OromoTranslation>);
        return Right(remoteWordList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localWordList = isEnglish
            ? await localDataSource.getLastEnglishWordList()
            : await localDataSource.getLastOromoWordList();
        return Right(localWordList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
