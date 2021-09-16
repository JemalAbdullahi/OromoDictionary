import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/english_dictionary_def_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_dictionary_def.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tEnglishDictionaryDefModel = EnglishDictionaryDefModel(
    word: 'aback',
    phonetics: {
        "text": "əˈbak",
        "audio": "//ssl.gstatic.com/dictionary/static/sounds/20200429/aback--_gb_1.mp3"
      },
    origin: "Old English on bæc  (see a-2, back). The term came to be treated as a single word in nautical use.",
    meanings: [
      {
        "partOfSpeech": "adverb",
        "definitions": [
          {
            "definition": "towards or situated to the rear; back.",
            "example": "the little strip of pasture aback of the house",
            "synonyms": [],
            "antonyms": []
          },
          {
            "definition": "with the sail pressed backwards against the mast by a headwind.",
            "example": "Peter holds the jib aback until our bow swings across the wind",
            "synonyms": [],
            "antonyms": []
          }
        ]
      }
    ],
  );

  test(
    'should be a subclass of EnglishDictionaryDef entity',
    () async {
      //assert
      expect(tEnglishDictionaryDefModel, isA<EnglishDictionaryDef>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid english word model from the JSON',
      () async {
        //arrange
        final List<dynamic> jsonMap =
            json.decode(fixture('english_dictionary_def.json'));
        //act
        final result = EnglishDictionaryDefModel.fromJson(jsonMap[0]);
        //assert
        expect(result, tEnglishDictionaryDefModel);
      },
    );
  });
}
