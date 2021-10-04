import 'package:flutter/material.dart';
import '../../../domain/entities/english_word.dart';
import 'search_results_display.dart';

class EnglishSearchResultsDisplay extends SearchResultsDisplay<EnglishWord> {
  EnglishSearchResultsDisplay({
    required Size constraints,
    required String message,
    required List<EnglishWord> wordList,
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
        print(wordList[index].word);
      },
      child: buildSearchResultListTile(index),
    );
  }

  @override
  ListTile buildSearchResultListTile(int index) {
    return ListTile(
      title: Text(
        '${wordList[index].word}',
        style: theme!.textTheme.bodyText2!,
      ),
      subtitle: Text(
        '/${wordList[index].phonetic}/',
        style: theme!.textTheme.subtitle1!.apply(color: Colors.black54),
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }
}