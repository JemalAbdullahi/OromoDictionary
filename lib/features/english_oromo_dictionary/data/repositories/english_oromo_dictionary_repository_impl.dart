import 'package:dartz/dartz.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/pages/search_page.dart';
import '../../../../core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/english_oromo_dictionary_repository.dart';
import '../datasources/english_oromo_dictionary_remote_data_source.dart';

class EnglishOromoDictionaryRepositoryImpl
    implements EnglishOromoDictionaryRepository {
  final EnglishOromoDictionaryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EnglishOromoDictionaryRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<dynamic>>> getWordList(
      {required String desiredList, required String searchTerm}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWordList;
        switch (desiredList) {
          case "EnglishWordList":
            remoteWordList =
                await remoteDataSource.getEnglishWordList(searchTerm);
            break;
          case "OromoWordList":
            remoteWordList =
                await remoteDataSource.getOromoWordList(searchTerm);
            break;
          case "EnglishTranslations":
            remoteWordList =
                await remoteDataSource.getEnglishTranslations(searchTerm);
            break;
          default:
            remoteWordList = [];
        }

        return Right(remoteWordList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
