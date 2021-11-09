
import 'package:flutter/material.dart';

import '../../../../../core/presentation/util/constants.dart';
import '../../../domain/entities/english_word.dart';
import '../../../domain/entities/grammatical_form.dart';
import 'definition_and_translation_listview.dart';

class SelectedPartOfSpeech extends StatelessWidget {
  const SelectedPartOfSpeech({
    Key? key,
    required this.englishWord,
    required this.selectedPartOfSpeech,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;
  final EnglishWord englishWord;
  final GrammaticalForm selectedPartOfSpeech;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader("Definitions"),
            englishWord.definitions[selectedPartOfSpeech.partOfSpeech] != null
                ? _buildCard("English Definition")
                : _buildCard("No Definition"),
            _buildHeader("Translations"),
            _buildCard("Oromo Translation")
          ],
        ),
      ),
    );
  }

  Padding _buildHeader(String header) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 20),
      child: Text(
        header,
        style: textTheme.bodyText2!
            .apply(color: COLOR_YELLOW, fontStyle: FontStyle.italic),
      ),
    );
  }

  Flexible _buildCard(String type) {
    return Flexible(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: COLOR_YELLOW,
              borderRadius: BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                    color: COLOR_BLACK, blurRadius: 20, offset: Offset(3, 5))
              ],
            ),
            child: _selectCardType(type)),
      ),
    );
  }

  Widget _selectCardType(String type) {
    switch (type) {
      case "No Definition":
        return Center(
          child: Text(
            "No Definitions available for this Part of Speech",
            style: textTheme.subtitle1!.apply(fontStyle: FontStyle.italic),
          ),
        );
      case "English Definition":
        return EnglishDefinitionListView(
            englishWord: englishWord,
            partOfSpeech: selectedPartOfSpeech.partOfSpeech,
            textTheme: textTheme);
      case "Oromo Translation":
        return OromoTranslationListView(
          selectedPartOfSpeech: selectedPartOfSpeech,
          textTheme: textTheme,
        );

      default:
        return Center(
          child: Text(type),
        );
    }
  }
}