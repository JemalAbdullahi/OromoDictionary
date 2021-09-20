import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/core/error/exceptions.dart';
import 'package:oromo_dictionary/core/error/failures.dart';
import 'package:oromo_dictionary/core/network/network_info.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/datasources/english_oromo_dictionary_remote_data_source.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/english_word_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/oromo_translation_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/repositories/english_oromo_dictionary_repository_impl.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/oromo_translation.dart';
import 'english_oromo_dictionary_repository_impl_test.mocks.dart';


@GenerateMocks([EnglishOromoDictionaryRemoteDataSource, NetworkInfo])
void main() {
  late EnglishOromoDictionaryRepositoryImpl repository;
  late MockEnglishOromoDictionaryRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockEnglishOromoDictionaryRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = EnglishOromoDictionaryRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getWordList', () {
    group('isEnglish: true', () {
      final tID = 1;
      final tWord = 'aback';
      final tPhonetic = 'abaak';
      final tEnglishWordModel =
          EnglishWordModel(id: tID, word: tWord, phonetic: tPhonetic);
      final EnglishWord tEnglishWord = tEnglishWordModel;
      final List<EnglishWord> tEnglishWordList = [tEnglishWord];
      test(
        'should check if the device is online',
        () async {
          //arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockRemoteDataSource.getEnglishWordList(any))
              .thenAnswer((_) async => tEnglishWordList);
          //act
          await repository.getWordList(isEnglish: true, searchTerm: tWord);
          //assert
          verify(mockNetworkInfo.isConnected);
        },
      );
      runTestsOnline(() {
        test(
          'should return remote data when the call to remote data source is successful',
          () async {
            //arrange
            when(mockRemoteDataSource.getEnglishWordList(any))
                .thenAnswer((_) async => tEnglishWordList);
            //act
            final result = await repository.getWordList(
                isEnglish: true, searchTerm: tWord);
            //assert
            verify(mockRemoteDataSource.getEnglishWordList(tWord));
            expect(result,
                equals(Right<Failure, List<EnglishWord>>(tEnglishWordList)));
          },
        );
        test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
            //arrange
            when(mockRemoteDataSource.getEnglishWordList(any))
                .thenThrow(ServerException());
            //act
            final result = await repository.getWordList(
                isEnglish: true, searchTerm: tWord);
            //assert
            verify(mockRemoteDataSource.getEnglishWordList(tWord));
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
      runTestsOffline(() {
        test(
          'should return ConnectionFailure when the device is offline',
          () async {
            //arrange
            //act
            final result = await repository.getWordList(
                isEnglish: true, searchTerm: tWord);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(ConnectionFailure())));
          },
        );
      });
    });

    group('isEnglish: false', () {
      final tID = 62;
      final tTranslation = 'gabaabaa';
      final tPhraseID = 17;
      final tOromoTranslationModel = OromoTranslationModel(
          id: tID, phraseID: tPhraseID, translation: tTranslation);
      final OromoTranslation tOromoTranslation = tOromoTranslationModel;
      final List<OromoTranslation> tOromoWordList = [tOromoTranslation];
      test(
        'should check if the device is online',
        () async {
          //arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockRemoteDataSource.getOromoWordList(any))
              .thenAnswer((_) async => tOromoWordList);
          //act
          repository.getWordList(isEnglish: false, searchTerm: tTranslation);
          //assert
          verify(mockNetworkInfo.isConnected);
        },
      );
      runTestsOnline(() {
        test(
          'should return remote data when the call to remote data source is successful',
          () async {
            //arrange
            when(mockRemoteDataSource.getOromoWordList(any))
                .thenAnswer((_) async => tOromoWordList);
            //act
            final result = await repository.getWordList(
                isEnglish: false, searchTerm: tTranslation);
            //assert
            verify(mockRemoteDataSource.getOromoWordList(tTranslation));
            expect(result,
                equals(Right<Failure, List<OromoTranslation>>(tOromoWordList)));
          },
        );
        test(
          'should cache data locally when the call to remote data source is successful',
          () async {
            //arrange
            when(mockRemoteDataSource.getOromoWordList(any))
                .thenAnswer((_) async => tOromoWordList);
            //act
            await repository.getWordList(
                isEnglish: false, searchTerm: tTranslation);
            //assert
            verify(mockRemoteDataSource.getOromoWordList(tTranslation));
          },
        );
        test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
            //arrange
            when(mockRemoteDataSource.getOromoWordList(any))
                .thenThrow(ServerException());
            //act
            final result = await repository.getWordList(
                isEnglish: false, searchTerm: tTranslation);
            //assert
            verify(mockRemoteDataSource.getOromoWordList(tTranslation));
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
      runTestsOffline(() {
        test(
          'should return ConnectionFailure when the device is offline',
          () async {
            //arrange
            //act
            final result = await repository.getWordList(
                isEnglish: false, searchTerm: tTranslation);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(ConnectionFailure())));
          },
        );
      });
    });
  });
}
