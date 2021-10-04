import 'package:flutter/material.dart';
import '../../../domain/entities/oromo_translation.dart';
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
        // TODO: Implement Navigation to Second Page/Feature
        print(wordList[index].translation);
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
