import 'package:flutter/material.dart';
import 'search_result_container.dart';
import '../../screens/translation_screens/oromo_english_translation_screen.dart';
import '../../viewmodels/oromo_translation_view_models/oromo_translation_view_model.dart';

class OromoSearchResultsContainer extends SearchResultsContainer {
  OromoSearchResultsContainer(
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
        OromoTranslationViewModel word = englishVM.words[index];
        Navigator.pushNamed(
          context,
          OromoEnglishTranslationScreen.routeName,
          arguments: OromoEnglishTranslationScreenArguments(word),
        );
      },
      child: buildSearchResultListTile(index),
    );
  }

  @override
  ListTile buildSearchResultListTile(int index) {
    return ListTile(
      title: Text(
        '${englishVM.words[index].translation}',
        style: textTheme.bodyText2,
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
