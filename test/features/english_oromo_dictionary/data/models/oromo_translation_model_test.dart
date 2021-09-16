import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/oromo_translation_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/oromo_translation.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  final tOromoTranslationModel =
      OromoTranslationModel(id: 3, phraseID: 2, translation: "rifatu");

  test(
    'should be a subclass of OromoTranslation entity',
    () async {
      //assert
      expect(tOromoTranslationModel, isA<OromoTranslation>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid english word model when the JSON translation is a string',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('oromo_translation.json'));
        //act
        final result = OromoTranslationModel.fromJson(jsonMap);
        //assert
        expect(result, tOromoTranslationModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //arranged already in tEnglishWordModel
        //act
        final result = tOromoTranslationModel.toJson();
        //assert
        final expectedMap = {"translation": "rifatu"};
        expect(result, expectedMap);
      },
    );
  });
}
