import 'package:oromo_dictionary/core/error/exceptions.dart';
import 'package:oromo_dictionary/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:oromo_dictionary/core/network/network_info.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/datasources/english_definition_remote_data_source.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/grammatical_form.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/repositories/english_definition_repository.dart';

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
