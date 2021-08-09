import 'package:oromo_dictionary/src/models/oromo_translation.dart';

class OromoTranslationViewModel {
  late final OromoTranslation _oromoTranslation;

  OromoTranslationViewModel(this._oromoTranslation);

  int get id {
    return this._oromoTranslation.id;
  }

  String get translation {
    return this._oromoTranslation.translation;
  }

  int get phraseID {
    return this._oromoTranslation.phraseID;
  }
}
