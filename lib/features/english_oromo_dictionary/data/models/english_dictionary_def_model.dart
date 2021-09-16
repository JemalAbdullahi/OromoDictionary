import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_dictionary_def.dart';

class EnglishDictionaryDefModel extends EnglishDictionaryDef {
  EnglishDictionaryDefModel({
    required String word,
    required Map? phonetics,
    required String? origin,
    required List<dynamic> meanings,
  }) : super(
            word: word,
            phonetics: phonetics,
            origin: origin,
            meanings: meanings);
}
