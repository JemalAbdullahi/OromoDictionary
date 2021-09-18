import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/core/error/exceptions.dart';
import 'package:oromo_dictionary/core/error/failures.dart';
import 'package:oromo_dictionary/core/network/network_info.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/datasources/english_oromo_dictionary_local_data_source.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/datasources/english_oromo_dictionary_remote_data_source.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/english_word_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/oromo_translation_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/repositories/english_oromo_dictionary_repository_impl.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/oromo_translation.dart';
import 'english_oromo_dictionary_repository_impl_test.mocks.dart';

class MockRemoteDataSource extends Mock
    implements EnglishOromoDictionaryRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements EnglishOromoDictionaryLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

@GenerateMocks([MockRemoteDataSource, MockLocalDataSource, MockNetworkInfo])
void main() {
  late EnglishOromoDictionaryRepositoryImpl repository;
  late MockMockRemoteDataSource mockRemoteDataSource;
  late MockMockLocalDataSource mockLocalDataSource;
  late MockMockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMockRemoteDataSource();
    mockLocalDataSource = MockMockLocalDataSource();
    mockNetworkInfo = MockMockNetworkInfo();
    repository = EnglishOromoDictionaryRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
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
          'should cache data locally when the call to remote data source is successful',
          () async {
            //arrange
            when(mockRemoteDataSource.getEnglishWordList(any))
                .thenAnswer((_) async => tEnglishWordList);
            //act
            await repository.getWordList(isEnglish: true, searchTerm: tWord);
            //assert
            verify(mockRemoteDataSource.getEnglishWordList(tWord));
            verify(mockLocalDataSource.cacheEnglishWordList(tEnglishWordList));
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
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
      runTestsOffline(() {
        test(
          'should return last locally cached data when the cached data is present',
          () async {
            //arrange
            when(mockLocalDataSource.getLastEnglishWordList())
                .thenAnswer((_) async => tEnglishWordList);
            //act
            final result = await repository.getWordList(
                isEnglish: true, searchTerm: tWord);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastEnglishWordList());
            expect(result, Right<Failure, List<EnglishWord>>(tEnglishWordList));
          },
        );
        test(
          'should return CacheFailure when the cached data is not present',
          () async {
            //arrange
            when(mockLocalDataSource.getLastEnglishWordList())
                .thenThrow(CacheException());
            //act
            final result = await repository.getWordList(
                isEnglish: true, searchTerm: tWord);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastEnglishWordList());
            expect(result, Left(CacheFailure()));
          },
        );
      });
    });

    group('isEnglish: false', () {
      final tID = 2;
      final tTranslation = 'rifatu';
      final tPhraseID = 3;
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
            verify(mockLocalDataSource.cacheOromoWordList(tOromoWordList));
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
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
      runTestsOffline(() {
        test(
          'should return last locally cached data when the cached data is present',
          () async {
            //arrange
            when(mockLocalDataSource.getLastOromoWordList())
                .thenAnswer((_) async => tOromoWordList);
            //act
            final result = await repository.getWordList(
                isEnglish: false, searchTerm: tTranslation);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastOromoWordList());
            expect(
                result, Right<Failure, List<OromoTranslation>>(tOromoWordList));
          },
        );
        test(
          'should return CacheFailure when the cached data is not present',
          () async {
            //arrange
            when(mockLocalDataSource.getLastOromoWordList())
                .thenThrow(CacheException());
            //act
            final result = await repository.getWordList(
                isEnglish: false, searchTerm: tTranslation);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastOromoWordList());
            expect(result, Left(CacheFailure()));
          },
        );
      });
    });
  });
}
