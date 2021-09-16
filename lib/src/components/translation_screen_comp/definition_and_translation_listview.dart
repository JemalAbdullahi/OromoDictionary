import 'package:flutter/material.dart';
import 'phrase_translation_container.dart';
import '../../viewmodels/english_view_models/english_word_view_model.dart';
import '../../viewmodels/grammatical_form_view_models/grammatical_form_view_model.dart';

class EnglishDefinitionListView extends StatelessWidget {
  const EnglishDefinitionListView(
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

class OromoTranslationListView extends StatelessWidget {
  const OromoTranslationListView(
      {Key? key, required this.textTheme, required this.selectedPartOfSpeech})
      : super(key: key);

  final TextTheme textTheme;
  final GrammaticalFormViewModel selectedPartOfSpeech;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: selectedPartOfSpeech.phrases!.length,
      itemBuilder: (BuildContext context, int index) {
        return PhraseTranslationContainer(
          textTheme: textTheme,
          phrase: selectedPartOfSpeech.phrases![index],
          index: index,
          isPhraseSection: true,
        );
      },
    );
  }
}
