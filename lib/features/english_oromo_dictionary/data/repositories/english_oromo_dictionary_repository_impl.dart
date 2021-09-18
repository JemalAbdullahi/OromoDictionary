import 'package:dartz/dartz.dart';
import 'package:oromo_dictionary/core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/english_oromo_dictionary_repository.dart';
import '../datasources/english_oromo_dictionary_remote_data_source.dart';

class EnglishOromoDictionaryRepositoryImpl
    implements EnglishOromoDictionaryRepository {
  final EnglishOromoDictionaryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EnglishOromoDictionaryRepositoryImpl(
      {required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<dynamic>>> getWordList(
      {required bool isEnglish, required String searchTerm}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWordList = isEnglish
            ? await remoteDataSource.getEnglishWordList(searchTerm)
            : await remoteDataSource.getOromoWordList(searchTerm);
        return Right(remoteWordList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
