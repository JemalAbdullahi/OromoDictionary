import 'dart:convert';

import 'package:http/http.dart' as http;
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
  final http.Client client;

  EnglishOromoDictionaryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EnglishWord>> getEnglishWordList(String englishTerm) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/search/en/$englishTerm');
    return await _getWordListFromURI<EnglishWord>(uri, isEnglish: true);
  }

  @override
  Future<List<EnglishWord>> getEnglishTranslations(String oromoWord) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/word/$oromoWord');
    return await _getWordListFromURI<EnglishWord>(uri, isEnglish: true);
  }

  @override
  Future<List<OromoTranslation>> getOromoWordList(String oromoTerm) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/search/om/$oromoTerm');
    return await _getWordListFromURI<OromoTranslation>(uri, isEnglish: false);
  }

  Future<List<T>> _getWordListFromURI<T>(Uri uri,
      {required bool isEnglish}) async {
    final response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final List<T> wordList =
          await _parseSearchResults<T>(result['data'], isEnglish: isEnglish);
      return wordList;
    } else {
      throw ServerException();
    }
  }

  Future<List<T>> _parseSearchResults<T>(List<dynamic> data,
      {required bool isEnglish}) async {
    List<T> words = [];
    for (Map<String, dynamic> json_ in data) {
      try {
        if (isEnglish) {
          // EnglishWord? englishWord =
          //     await getEnglishDefinitions(EnglishWordModel.fromJson(json_));
          words.add(EnglishWordModel.fromJson(json_) as T);
        } else {
          words.add(OromoTranslationModel.fromJson(json_) as T);
        }
      } catch (Exception) {
        print(Exception);
      }
    }
    return words;
  }
}
