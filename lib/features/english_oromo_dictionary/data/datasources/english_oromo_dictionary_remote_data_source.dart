import '../../domain/entities/english_word.dart';
import '../../domain/entities/oromo_translation.dart';

abstract class EnglishOromoDictionaryRemoteDataSource {
  ///Calls the https://oromo-dictionary-staging.herokuapp.com/search/om/{oromoTerm} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<OromoTranslation>> getOromoWordList(String oromoTerm);

  ///Calls the https://oromo-dictionary-staging.herokuapp.com/search/en/{englishTerm} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<EnglishWord>> getEnglishWordList(String englishTerm);
}
