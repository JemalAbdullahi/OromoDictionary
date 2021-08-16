import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/screens/translation_screen.dart';
import 'package:oromo_dictionary/src/utils/constants.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_list_view_model.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_view_model.dart';

class SearchResultsContainer extends StatelessWidget {
  const SearchResultsContainer({
    Key? key,
    required this.englishVM,
    required this.textTheme,
    required this.constraints,
  }) : super(key: key);

  final EnglishWordListViewModel englishVM;
  final TextTheme textTheme;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _searchResultCardDecoration(),
      height: constraints.maxHeight / 1.8,
      width: constraints.maxWidth,
      child: englishVM.englishWords.length > 0
          ? ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: englishVM.englishWords.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildListItemGestureDetector(index, context);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: COLOR_BLACK,
                thickness: 0.2,
              ),
            )
          : Center(
              child: Text("No Words Found! Try searching a different word.")),
    );
  }

  BoxDecoration _searchResultCardDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          offset: const Offset(4, 4),
          blurRadius: 25.0,
        ),
      ],
      color: Colors.grey[200],
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
    );
  }

  GestureDetector _buildListItemGestureDetector(
      int index, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        EnglishWordViewModel word = englishVM.englishWords[index];
        await word.setForms();
        Navigator.pushNamed(
          context,
          TranslationScreen.routeName,
          arguments: TranslationScreenArguments(word),
        );
      },
      child: _buildSearchResultListTile(index),
    );
  }

  ListTile _buildSearchResultListTile(int index) {
    return ListTile(
      title: Text(
        '${englishVM.englishWords[index].word}',
        style: textTheme.subtitle1!,
      ),
      subtitle: Text(
        '/${englishVM.englishWords[index].phonetic}/',
        style: textTheme.subtitle2!.apply(color: Colors.black54),
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
