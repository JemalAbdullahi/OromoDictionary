import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/datasources/english_word_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/english_word_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'english_word_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late EnglishWordRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  final tEnglishWordModel = EnglishWordModel.fromJson(
    json.decode(
      fixture('english_word_page', 'english_word.json'),
    ),
  );

  setUp(() {
    mockHttpClient = new MockClient();
    dataSource = new EnglishWordRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String folderName, String fileName) {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture(folderName, fileName), 200));
  }

 /*  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  } */
  group("getEnglishDefinitions", () {
    Uri uri = Uri(
        scheme: 'https',
        host: 'api.dictionaryapi.dev',
        path: '/api/v2/entries/en/aback');

    test(
      '''should perform a GET request on a URL with /api/v2/entries/en/ as the end 
      point''',
      () async {
        //arrange
        dataSource.englishWord = tEnglishWordModel;
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(
            fixture('english_word_page', 'english_dictionary_def.json'),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            },
          ),
        );
        //act
        dataSource.getEnglishDefinitions();
        //assert
        verify(mockHttpClient.get(uri,
            headers: {'Content-Type': 'application/json; charset=utf-8'}));
      },
    );
  });

  group("getGrammaticalFormList", () {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/grammaticalform/1');

    test(
      '''should perform a GET request on a URL with /grammaticalform/ as the 
      end point''',
      () async {
        //arrange
        dataSource.englishWord = tEnglishWordModel;
        setUpMockHttpClientSuccess200(
            'english_word_page', 'grammatical_form_list.json');
        //act
        await dataSource.getGrammaticalFormList();
        //assert
        verify(mockHttpClient
            .get(uri, headers: {'Content-Type': 'application/json'}));
      },
    );
  });

  group("getPhraseList", () {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/phrase/1');

    test(
      '''should perform a GET request on a URL with /phrase/ as the 
      end point''',
      () async {
        //arrange
        setUpMockHttpClientSuccess200(
            'english_word_page', 'phrase_list.json');
        //act
        await dataSource.getPhraseList(1);
        //assert
        verify(mockHttpClient
            .get(uri, headers: {'Content-Type': 'application/json'}));
      },
    );
  });

  group("getOromoWordList", () {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/translation/2');

    test(
      '''should perform a GET request on a URL with /translation/ as the 
      end point''',
      () async {
        //arrange
        setUpMockHttpClientSuccess200(
            'english_word_page', 'phrase_list.json');
        //act
        await dataSource.getOromoWordList(2);
        //assert
        verify(mockHttpClient
            .get(uri, headers: {'Content-Type': 'application/json'}));
      },
    );
  });
}
