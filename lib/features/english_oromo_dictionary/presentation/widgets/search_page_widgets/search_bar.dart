import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/util/constants.dart';
import '../../bloc/search_page_bloc/bloc.dart';
import 'language_selector.dart';

class SearchBar extends StatefulWidget {
  ///Search Bar that is responsible for receiving user input and retrieving
  ///search results.
  SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();
  String inputString = "";
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return searchBar();
  }

  Stack searchBar() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        _searchBar(),
        _selectLanguageIcon(),
      ],
    );
  }

  TextField _searchBar() {
    return TextField(
      //focusNode: _searchBarFocusNode,
      controller: controller,
      style: theme.textTheme.subtitle1!.apply(color: COLOR_WHITE),
      decoration: _searchBarDecoration(),
      onChanged: (value) {
        inputString = value;
      },
      onSubmitted: (_) => _search(),
      autocorrect: false,
    );
  }

  InputDecoration _searchBarDecoration() {
    return InputDecoration(
      hintText: "Search a Word to Translate...",
      hintStyle: theme.textTheme.subtitle1!.apply(color: COLOR_WHITE),
      filled: true,
      fillColor: Colors.white38,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      prefixIcon: Icon(Icons.search, color: COLOR_WHITE),
    );
  }

  Container _selectLanguageIcon() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: COLOR_YELLOW,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: LanguageSelector(),
    );
  }

  void _search() {
    controller.clear();
    BlocProvider.of<SearchPageBloc>(context).isEnglish
        ? BlocProvider.of<SearchPageBloc>(context)
            .add(GetListForEnglishWord(inputString))
        : BlocProvider.of<SearchPageBloc>(context)
            .add(GetListForOromoWord(inputString));
  }
}
