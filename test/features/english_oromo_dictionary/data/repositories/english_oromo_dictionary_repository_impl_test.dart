import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/core/platform/network_info.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/datasources/english_oromo_dictionary_local_data_source.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/datasources/english_oromo_dictionary_remote_data_source.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/repositories/english_oromo_dictionary_repository_impl.dart';
import 'english_oromo_dictionary_repository_impl_test.mocks.dart';

class MockRemoteDataSource extends Mock
    implements EnglishOromoDictionaryRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements EnglishOromoDictionaryLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

@GenerateMocks([MockRemoteDataSource, MockLocalDataSource, MockNetworkInfo])
void main() {
  EnglishOromoDictionaryRepositoryImpl repository;
  MockMockRemoteDataSource mockRemoteDataSource;
  MockMockLocalDataSource mockLocalDataSource;
  MockMockNetworkInfo mockNetworkInfo;

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
}
