import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/bloc/english_oromo_dictionary_bloc.dart';
import 'english_oromo_dictionary_bloc_test.mocks.dart';

@GenerateMocks([GetEnglishWordList, GetOromoWordList])
void main() {
  late EnglishOromoDictionaryBloc bloc;
  late MockGetEnglishWordList mockGetEnglishWordList;
  late MockGetOromoWordList mockGetOromoWordList;

  setUp(() {
    mockGetEnglishWordList = MockGetEnglishWordList();
    mockGetOromoWordList = MockGetOromoWordList();

    bloc = EnglishOromoDictionaryBloc(
        getEnglishWordList: mockGetEnglishWordList,
        getOromoWordList: mockGetOromoWordList);
  });

  test(
    'initialState should be Empty',
    () async {
      //assert
      expect(bloc.state, equals(Empty()));
    },
  );
}
