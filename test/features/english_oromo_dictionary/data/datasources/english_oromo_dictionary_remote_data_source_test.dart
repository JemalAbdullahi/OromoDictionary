import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/core/error/exceptions.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/datasources/english_oromo_dictionary_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/english_word_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/oromo_translation_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'english_oromo_dictionary_remote_data_source_test.mocks.dart';

class MockHttpClient extends Mock implements http.Client {}

@GenerateMocks([MockHttpClient])
void main() {
  late EnglishOromoDictionaryRemoteDataSourceImpl dataSource;
  late MockMockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockMockHttpClient();
    dataSource =
        EnglishOromoDictionaryRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String fileName) {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture(fileName), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getEnglishWordList', () {
    final englishTerm = 'aback';
    final tEnglishWordModel =
        EnglishWordModel.fromJson(json.decode(fixture('english_word.json')));
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/search/en/$englishTerm');
    test(
      '''should perform a GET request on a URL with search/en being the endpoint 
      and with application/json header''',
      () async {
        //arrange
        setUpMockHttpClientSuccess200('english_word_list.json');
        //act
        dataSource.getEnglishWordList(englishTerm);
        //assert
        verify(mockHttpClient
            .get(uri, headers: {'Content-Type': 'application/json'}));
      },
    );
    test(
      'should return EnglishWord when the response code is 200',
      () async {
        //arrange
        setUpMockHttpClientSuccess200('english_word_list.json');
        //act
        final result = await dataSource.getEnglishWordList(englishTerm);
        //assert
        expect(result, equals([tEnglishWordModel]));
      },
    );
    test(
      'should throw a ServerException when the response code is not 2xx',
      () async {
        //arrange
        setUpMockHttpClientFailure404();
        //act
        final call = dataSource.getEnglishWordList;
        //assert
        expect(
            () => call(englishTerm), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
  group('getOromoWordList', () {
    final oromoTerm = 'gabab';
    final tOromoTranslationModel = OromoTranslationModel.fromJson(
        json.decode(fixture('oromo_translation.json')));
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/search/om/$oromoTerm');
    test(
      '''should perform a GET request on a URL with search/om being the endpoint 
      and with application/json header''',
      () async {
        //arrange
        setUpMockHttpClientSuccess200('oromo_translation_list.json');
        //act
        dataSource.getOromoWordList(oromoTerm);
        //assert
        verify(mockHttpClient
            .get(uri, headers: {'Content-Type': 'application/json'}));
      },
    );
    test(
      'should return OromoTranslation when the response code is 200',
      () async {
        //arrange
        setUpMockHttpClientSuccess200('oromo_translation_list.json');
        //act
        final result = await dataSource.getOromoWordList(oromoTerm);
        //assert
        expect(result, equals([tOromoTranslationModel]));
      },
    );
    test(
      'should throw a ServerException when the response code is not 2xx',
      () async {
        //arrange
        setUpMockHttpClientFailure404();
        //act
        final call = dataSource.getOromoWordList;
        //assert
        expect(() => call(oromoTerm), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
