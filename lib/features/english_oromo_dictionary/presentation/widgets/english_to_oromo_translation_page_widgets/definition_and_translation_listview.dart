import 'package:flutter/material.dart';

import '../../../domain/entities/english_word.dart';
import '../../../domain/entities/grammatical_form.dart';
import 'phrase_translation_container.dart';

class EnglishDefinitionListView extends StatelessWidget {
  const EnglishDefinitionListView(
      {Key? key,
      required this.textTheme,
      required this.englishWord,
      required this.partOfSpeech})
      : super(key: key);

  final TextTheme textTheme;
  final EnglishWord englishWord;
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
  final GrammaticalForm selectedPartOfSpeech;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: selectedPartOfSpeech.phrases.length,
      itemBuilder: (BuildContext context, int index) {
        return PhraseTranslationContainer(
          textTheme: textTheme,
          phrase: selectedPartOfSpeech.phrases[index],
          index: index,
          isPhraseSection: true,
        );
      },
    );
  }
}