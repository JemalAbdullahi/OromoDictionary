import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/utils/constants.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_list_view_model.dart';

abstract class SearchResultsContainer extends StatelessWidget {
  const SearchResultsContainer({
    Key? key,
    required this.englishVM,
    required this.textTheme,
    required this.constraints,
  }) : super(key: key);

  final SearchListViewModel englishVM;
  final TextTheme textTheme;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _searchResultCardDecoration(),
      height: constraints.maxHeight / 1.8,
      width: constraints.maxWidth,
      child: englishVM.words.length > 0
          ? ListView.separated(
              padding: const EdgeInsets.only(top: 18),
              itemCount: englishVM.words.length,
              itemBuilder: (BuildContext context, int index) {
                return buildListItemGestureDetector(index, context);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: COLOR_RED,
                thickness: 2,
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
