import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/search_screen_comp/app_header.dart';
import '../components/search_screen_comp/english_search_results_container.dart';
import '../components/search_screen_comp/language_selector.dart';
import '../components/search_screen_comp/oromo_search_result_container.dart';
import '../components/search_screen_comp/search_screen_app_bar.dart';
import '../services/api.dart';
import '../utils/constants.dart';
import '../utils/widget_functions.dart';
import '../viewmodels/english_view_models/english_word_list_view_model.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextTheme textTheme;
  late final SearchListViewModel englishVM;
  final FocusNode _searchBarFocusNode = FocusNode();
  final TextEditingController _searchBarController = TextEditingController();
  bool hasSearched = false;
  List<Map<String, Object>> searchedWords = [];
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      englishVM = Provider.of<SearchListViewModel>(context);
      textTheme = Theme.of(context).textTheme;
      initialized = true;
    }
    if (_searchBarController.text.isEmpty && hasSearched) {
      _resetSearch();
    }
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              alignment: Alignment.center,
              // color: Theme.of(context).primaryColor,
              width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
              height: constraints.maxHeight > 1000
                  ? constraints.maxHeight * 0.8
                  : constraints.maxHeight,
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        SearchScreenAppBar(textTheme: textTheme),
                        Padding(
                          padding: hasSearched
                              ? const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 10)
                              : const EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AppHeader(),
                                searchBar(),
                                hasSearched
                                    ? addVerticalSpace(0)
                                    : addVerticalSpace(30),
                              ]),
                        )
                      ],
                    ),
                  ),
                  hasSearched
                      ? _searchResults(constraints)
                      : Container(width: constraints.maxWidth),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _searchResults(BoxConstraints constraints) {
    return API.isEnglish()
        ? EnglishSearchResultsContainer(
            englishVM: englishVM,
            textTheme: textTheme,
            constraints: constraints)
        : OromoSearchResultsContainer(
            englishVM: englishVM,
            textTheme: textTheme,
            constraints: constraints);
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
      focusNode: _searchBarFocusNode,
      controller: _searchBarController,
      style: textTheme.subtitle1!.apply(color: COLOR_WHITE),
      decoration: _searchBarDecoration(),
      onSubmitted: _search,
      autocorrect: false,
    );
  }

  InputDecoration _searchBarDecoration() {
    return InputDecoration(
      hintText: "Search a Word to Translate...",
      hintStyle: textTheme.subtitle1!.apply(color: COLOR_WHITE),
      filled: true,
      fillColor: Colors.white38,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      prefixIcon: Icon(Icons.search, color: COLOR_WHITE),
      // suffixIcon: _selectLanguageIcon(),
    );
  }

  //Switch Language search between English and Oromo words
  Container _selectLanguageIcon() {
    return Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          // color: Colors.white30,
          color: COLOR_YELLOW,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: LanguageSelector(
          controller: _searchBarController,
          englishVM: englishVM,
          textTheme: textTheme,
        ));
  }

  void _search(value) {
    value.isNotEmpty ? _fetchWords(value) : _resetSearch();
  }

  void _fetchWords(String value) async {
    await englishVM.fetchWords(value);
    setState(() {
      hasSearched = true;
    });
  }

  void _resetSearch() {
    setState(() {
      hasSearched = false;
    });
  }
}
