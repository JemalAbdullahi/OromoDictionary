import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/phrase.dart';

class PhraseModel extends Phrase {
  PhraseModel({
    required int id,
    required int formID,
    required String phrase,
    required String example,
  }) : super(id: id, formID: formID, phrase: phrase, example: example);
}
