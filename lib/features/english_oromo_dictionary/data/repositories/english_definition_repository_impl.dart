import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/grammatical_form.dart';
import '../../domain/repositories/english_definition_repository.dart';
import '../datasources/english_definition_remote_data_source.dart';

class EnglishDefinitionRepositoryImpl implements EnglishDefinitionRepository {
  final EnglishDefinitionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EnglishDefinitionRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<GrammaticalForm>>> getGrammaticalFormList(
      {required int wordID}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGrammaticalFormList =
            await remoteDataSource.getGrammaticalFormList(wordID);
        return Right(remoteGrammaticalFormList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
