import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:oromo_dictionary/core/network/network_info.dart';
import 'network_info_test.mocks.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

@GenerateMocks([MockDataConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockMockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockMockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        //arrange
        final tHasConnectionFuture = await Future.value(true);
        when(mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) async => tHasConnectionFuture);
        //act
        final result = await networkInfo.isConnected;
        //assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
