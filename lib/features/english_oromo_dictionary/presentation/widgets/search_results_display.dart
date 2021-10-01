import 'package:flutter/material.dart';
import '../../../../core/presentation/util/constants.dart';

abstract class SearchResultsDisplay<T> extends StatelessWidget {
  final BoxConstraints constraints;
  final String message;
  final List<T> wordList;
  final ThemeData? theme;

  ///Generic SearchResults Card
  ///
  ///Takes in
  ///
  ///- constraints: size of the card
  ///- message: possible loading/error message
  /// - wordList: The returned search results to be displayed
  /// - theme: ThemeData for easy access to textTheme in child classes.
  SearchResultsDisplay({
    Key? key,
    required this.constraints,
    required this.message,
    required this.wordList,
    required this.theme,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _searchResultCardDecoration(),
      clipBehavior: Clip.hardEdge,
      height: constraints.maxHeight / 2,
      width: constraints.maxWidth,
      child: wordList.length > 0
          ? ListView.builder(
              padding: const EdgeInsets.only(top: 18, left: 12),
              itemCount: wordList.length,
              itemBuilder: (BuildContext context, int index) {
                return buildListItemGestureDetector(index, context);
              },
              /* separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: COLOR_BLACK,
                thickness: 1,
              ), */
            )
          : Center(
              child: Text(message),
              //Text("No Words Found! Try searching a different word.")
            ),
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
      color: COLOR_YELLOW,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
    );
  }

  GestureDetector buildListItemGestureDetector(int index, BuildContext context);

  ListTile buildSearchResultListTile(int index);
}