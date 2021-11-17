import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/english_word.dart';
import '../../domain/repositories/english_word_repository.dart';
import '../datasources/english_word_remote_data_source.dart';

class EnglishWordRepositoryImpl implements EnglishWordRepository {
  final EnglishWordRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EnglishWordRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, EnglishWord>> getEnglishWord(
      {required EnglishWord englishWord}) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await _getEnglishWord(englishWord));
      } on ServerException {
        return Left(ServerFailure());
      }
    } 
    
    return Left(ConnectionFailure());
  }

  Future<EnglishWord> _getEnglishWord(EnglishWord englishWord) async {
    final remoteEnglishDefinitions =
        await remoteDataSource.getEnglishWord(englishWord);
    return remoteEnglishDefinitions;
  }
}
