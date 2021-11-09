import 'package:flutter/material.dart';

import '../../../domain/entities/oromo_translation.dart';
import '../../pages/oromo_to_english_translation_page.dart';
import 'search_results_display.dart';

class OromoSearchResultsDisplay extends SearchResultsDisplay<OromoTranslation> {
  OromoSearchResultsDisplay({
    required Size constraints,
    required String message,
    required List<OromoTranslation> wordList,
    required ThemeData theme,
  }) : super(
          constraints: constraints,
          message: message,
          wordList: wordList,
          theme: theme,
        );

  @override
  GestureDetector buildListItemGestureDetector(
      int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Done: Implement Navigation to Second Page/Feature
        Navigator.of(context).pushNamed(
          OromoToEnglishTranslationPage.routeName,
          arguments: OromoToEnglishTranslationPageArguments(wordList[index]),
        );
      },
      child: buildSearchResultListTile(index),
    );
  }

  @override
  ListTile buildSearchResultListTile(int index) {
    return ListTile(
      title: Text(
        '${wordList[index].translation}',
        style: theme!.textTheme.bodyText2!,
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
