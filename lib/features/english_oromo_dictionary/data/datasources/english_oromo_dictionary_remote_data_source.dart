import 'package:http/http.dart' as http;
import 'http_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/english_word.dart';
import '../../domain/entities/oromo_translation.dart';
import '../models/english_word_model.dart';
import '../models/oromo_translation_model.dart';

abstract class EnglishOromoDictionaryRemoteDataSource {
  ///Calls the https://oromo-dictionary-staging.herokuapp.com/search/om/{oromoTerm} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<OromoTranslation>> getOromoWordList(String oromoTerm);

  ///Calls the https://oromo-dictionary-staging.herokuapp.com/search/en/{englishTerm} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<EnglishWord>> getEnglishWordList(String englishTerm);

  ///Calls the https://oromo-dictionary-staging.herokuapp.com/search/en/{englishTerm} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<EnglishWord>> getEnglishTranslations(String oromoWord);
}

class EnglishOromoDictionaryRemoteDataSourceImpl
    implements EnglishOromoDictionaryRemoteDataSource {
  final String scheme = 'https';
  final String host = 'oromo-dictionary-staging.herokuapp.com';

  final http.Client client;
  late final HTTPResponse response;
  EnglishOromoDictionaryRemoteDataSourceImpl({required this.client}) {
    response = new HTTPResponse(client);
  }

  @override
  Future<List<EnglishWord>> getEnglishWordList(String englishTerm) async {
    Uri uri = Uri(scheme: scheme, host: host, path: '/search/en/$englishTerm');
    return await _getEnglishWordListFrom(uri);
  }

  @override
  Future<List<EnglishWord>> getEnglishTranslations(String oromoWord) async {
    Uri uri = Uri(scheme: scheme, host: host, path: '/word/$oromoWord');
    return await _getEnglishWordListFrom(uri);
  }

  @override
  Future<List<OromoTranslation>> getOromoWordList(String oromoTerm) async {
    Uri uri = Uri(scheme: scheme, host: host, path: '/search/om/$oromoTerm');
    return await _getOromoTranslationListFrom(uri);
  }

  Future<List<EnglishWord>> _getEnglishWordListFrom(Uri uri) async {
    await response.setResponseFrom(uri);
    return response.isSuccessful()
        ? _getEnglishWordListResults()
        : throw ServerException();
  }

  Future<List<OromoTranslation>> _getOromoTranslationListFrom(Uri uri) async {
    await response.setResponseFrom(uri);
    return response.isSuccessful()
        ? _getOromoTranslationListResults()
        : throw ServerException();
  }

  List<EnglishWord> _getEnglishWordListResults() {
    final result = response.getResult();
    return _parseEnglishSearchResults(result['data']);
  }

  List<OromoTranslation> _getOromoTranslationListResults() {
    final result = response.getResult();
    return _parseOromoSearchResults(result['data']);
  }

  List<EnglishWord> _parseEnglishSearchResults(List<dynamic> data) {
    List<EnglishWord> words = [];
    for (Map<String, dynamic> json_ in data) {
      try {
        words.add(EnglishWordModel.fromJson(json_));
      } catch (Exception) {
        // Parse Exception
        throw ServerException();
      }
    }
    return words;
  }

  List<OromoTranslation> _parseOromoSearchResults(List<dynamic> data) {
    List<OromoTranslation> words = [];
    for (Map<String, dynamic> json_ in data) {
      try {
        words.add(OromoTranslationModel.fromJson(json_));
      } catch (Exception) {
        // Parse Exception
        throw ServerException();
      }
    }
    return words;
  }
}
