import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/components/translation_screen_comp/english_definition_container.dart';
import 'package:oromo_dictionary/src/components/translation_screen_comp/phrase_translation_container.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_view_model.dart';
import 'package:oromo_dictionary/src/viewmodels/grammatical_form_view_models/grammatical_form_view_model.dart';

class SelectedPartOfSpeech extends StatelessWidget {
  const SelectedPartOfSpeech({
    Key? key,
    required this.englishWord,
    required this.selectedPartOfSpeech,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;
  final EnglishWordViewModel englishWord;
  final GrammaticalFormViewModel selectedPartOfSpeech;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 14),
            child: Text(
              "Definitions",
              style: textTheme.bodyText2!.apply(fontStyle: FontStyle.italic),
            ),
          ),
          englishWord.definitions[selectedPartOfSpeech.partOfSpeech] != null
              ? Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: EnglishDefinitionContainer(
                        englishWord: englishWord,
                        partOfSpeech: selectedPartOfSpeech.partOfSpeech,
                        textTheme: textTheme),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 14, bottom: 20),
                  child: Text(
                    "No Definitions available for this Part of Speech",
                    style:
                        textTheme.subtitle1!.apply(fontStyle: FontStyle.italic),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 14),
            child: Text(
              "Translations",
              style: textTheme.bodyText2!.apply(fontStyle: FontStyle.italic),
            ),
          ),
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListView.builder(
                itemCount: selectedPartOfSpeech.phrases!.length,
                itemBuilder: (BuildContext context, int index) {
                  return PhraseTranslationContainer(
                    textTheme: textTheme,
                    phrase: selectedPartOfSpeech.phrases![index],
                    index: index,
                    isPhraseSection: true,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
