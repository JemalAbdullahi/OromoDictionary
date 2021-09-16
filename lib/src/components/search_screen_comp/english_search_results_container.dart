import 'package:flutter/material.dart';
import 'search_result_container.dart';
import '../../screens/translation_screens/english_oromo_translation_screen.dart';
import '../../viewmodels/english_view_models/english_word_view_model.dart';

class EnglishSearchResultsContainer extends SearchResultsContainer {
  EnglishSearchResultsContainer(
      {required englishVM, required textTheme, required constraints})
      : super(
            englishVM: englishVM,
            textTheme: textTheme,
            constraints: constraints);

  @override
  GestureDetector buildListItemGestureDetector(
      int index, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        EnglishWordViewModel word = englishVM.words[index];
        await word.setForms();
        Navigator.pushNamed(
          context,
          EnglishOromoTranslationScreen.routeName,
          arguments: EnglishOromoTranslationScreenArguments(word),
        );
      },
      child: buildSearchResultListTile(index),
    );
  }

  @override
  ListTile buildSearchResultListTile(int index) {
    return ListTile(
      title: Text(
        '${englishVM.words[index].word}',
        style: textTheme.bodyText2!,
      ),
      subtitle: Text(
        '/${englishVM.words[index].phonetic}/',
        style: textTheme.subtitle1!.apply(color: Colors.black54),
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
