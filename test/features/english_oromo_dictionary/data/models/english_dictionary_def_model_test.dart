import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/english_dictionary_def_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_dictionary_def.dart';

void main() {
  final tEnglishDictionaryDefModel = EnglishDictionaryDefModel(
    word: '',
    phonetics: {},
    origin: '',
    meanings: [],
  );

  test(
    'should be a subclass of EnglishDictionaryDef entity',
    () async {
      //assert
      expect(tEnglishDictionaryDefModel, isA<EnglishDictionaryDef>());
    },
  );
}
