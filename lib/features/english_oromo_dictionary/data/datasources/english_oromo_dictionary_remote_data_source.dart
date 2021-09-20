import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/english_word_model.dart';
import '../models/oromo_translation_model.dart';

import '../../domain/entities/english_word.dart';
import '../../domain/entities/oromo_translation.dart';
import 'package:http/http.dart' as http;

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

class EnglishOromoDictionaryRemoteDataSourceImpl
    implements EnglishOromoDictionaryRemoteDataSource {
  final http.Client client;

  EnglishOromoDictionaryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EnglishWord>> getEnglishWordList(String englishTerm) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/search/en/$englishTerm');
    return _getWordListFromURI<EnglishWord>(uri, isEnglish: true);
  }

  @override
  Future<List<OromoTranslation>> getOromoWordList(String oromoTerm) {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/search/om/$oromoTerm');
    return _getWordListFromURI<OromoTranslation>(uri, isEnglish: false);
  }

  Future<List<T>> _getWordListFromURI<T>(Uri uri,
      {required bool isEnglish}) async {
    final response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final List<T> wordList =
          _parseSearchResults(result['data'], isEnglish: isEnglish).cast<T>();
      return wordList;
    } else {
      throw ServerException();
    }
  }

  List<dynamic> _parseSearchResults(List<dynamic> data,
      {required bool isEnglish}) {
    List<dynamic> words = [];
    for (Map<String, dynamic> json_ in data) {
      try {
        isEnglish
            ? words.add(EnglishWordModel.fromJson(json_))
            : words.add(OromoTranslationModel.fromJson(json_));
      } catch (Exception) {
        print(Exception);
      }
    }
    return words;
  }
}
