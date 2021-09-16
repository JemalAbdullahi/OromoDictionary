import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/english_word_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tEnglishWordModel =
      EnglishWordModel(id: 1, word: "aback", phonetic: "abaak");

  test(
    'should be a subclass of EnglishWord entity',
    () async {
      //assert
      expect(tEnglishWordModel, isA<EnglishWord>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid english word model when the JSON word is a string',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('english_word.json'));
        //act
        final result = EnglishWordModel.fromJson(jsonMap);
        //assert
        expect(result, tEnglishWordModel);
      },
    );
  });
}
