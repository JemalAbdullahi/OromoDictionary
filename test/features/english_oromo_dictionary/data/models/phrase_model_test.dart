import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/phrase_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPhraseModel =
      PhraseModel(id: 2, formID: 1, phrase: "to be taken aback", example: "");

  test(
    'should be a subclass of PhraseModel entity',
    () async {
      //assert
      expect(tPhraseModel, isA<PhraseModel>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid phrase model when the JSON phrase is a string',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('phrase.json'));
        //act
        final result = PhraseModel.fromJson(jsonMap);
        //assert
        expect(result, tPhraseModel);
      },
    );
  });
}
