import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/grammatical_form_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/grammatical_form.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tGrammaticalFormModel =
      GrammaticalFormModel(id: 1, wordID: 1, partOfSpeech:'adverb');

  test(
    'should be a subclass of GrammaticalForm entity',
    () async {
      //assert
      expect(tGrammaticalFormModel, isA<GrammaticalForm>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid grammatical form model when the JSON part of speech is a string',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('search_page','grammatical_form.json'));
        //act
        final result = GrammaticalFormModel.fromJson(jsonMap);
        //assert
        expect(result, tGrammaticalFormModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //arranged already in tEnglishWordModel
        //act
        final result = tGrammaticalFormModel.toJson();
        //assert
        final expectedMap = {"part_of_speech": "adverb"};
        expect(result, expectedMap);
      },
    );
  });
}
