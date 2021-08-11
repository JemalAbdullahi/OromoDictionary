import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/components/translation_screen_comp/phrase_translation_container.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_view_model.dart';

class EnglishDefinitionContainer extends StatelessWidget {
  const EnglishDefinitionContainer(
      {Key? key,
      required this.textTheme,
      required this.englishWord,
      required this.partOfSpeech})
      : super(key: key);

  final TextTheme textTheme;
  final EnglishWordViewModel englishWord;
  final String partOfSpeech;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: englishWord.definitions[partOfSpeech]!.length,
      itemBuilder: (BuildContext context, int index) {
        return PhraseTranslationContainer(
          textTheme: textTheme,
          englishDef: englishWord.definitions[partOfSpeech]![index],
          index: index,
          isPhraseSection: false,
        );
      },
    );
  }
}
