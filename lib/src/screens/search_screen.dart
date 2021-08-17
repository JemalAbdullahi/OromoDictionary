import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/components/search_screen_comp/app_header.dart';
import 'package:oromo_dictionary/src/components/search_screen_comp/language_selector.dart';
import 'package:oromo_dictionary/src/components/search_screen_comp/english_search_results_container.dart';
import 'package:oromo_dictionary/src/components/search_screen_comp/oromo_search_result_container.dart';
import 'package:oromo_dictionary/src/services/api.dart';
import 'package:provider/provider.dart';
import 'package:oromo_dictionary/src/utils/constants.dart';
import 'package:oromo_dictionary/src/utils/widget_functions.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_list_view_model.dart';

const DICTIONARY_DATA = [
  {
    "main_entry": "hand",
    "phonetic": "/ haand /",
    "subentries": [
      {
        "partOfSpeech": "noun",
        "phrases": [
          {
            "phrase": "",
            "translations": [
              {"translation": "harka"}
            ]
          },
          {
            "phrase": "at hand",
            "translations": [
              {"translation": "waan harka ifii jiruu"},
              {"translation": "dhihoo"},
              {"translation": "kaluu"}
            ]
          },
          {
            "phrase": "by hand",
            "translations": [
              {"translation": "harkaan"},
              {"translation": "ka makiinaan hin tahin"}
            ]
          },
        ]
      },
      {
        "partOfSpeech": "verb",
        "phrases": [
          {
            "phrase": "",
            "translations": [
              {"translation": "dabarsuu"},
              {"translation": "keennuu"}
            ]
          },
          {
            "phrase": "hand back",
            "translations": [
              {
                "translation": "deebisu",
              },
            ]
          },
          {
            "phrase": "hand down",
            "translations": [
              {"translation": "gad kennuu"},
              {"translation": "buusu"}
            ]
          },
          {
            "phrase": "hand in",
            "example": "~ homework",
            "translations": [
              {"translation": "galchuu"},
              {"translation": "naquu"},
              {"translation": "ol kennuu"},
              {"translation": "fidu"},
              {"translation": "deebisuu"}
            ]
          },
        ]
      }
    ]
  },
];

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool hasSearched = false;
  List<Map<String, Object>> searchedWords = [];
  late final TextTheme textTheme;
  late final SearchListViewModel englishVM;
  final _searchBarFocusNode = FocusNode();
  bool initialized = false;

  /* MainEntry mainEntry = MainEntry("hand", "/ haand /");
  Phrase phrase1 = Phrase("", ["harka"]);
  Phrase phrase2 =
      Phrase("at hand", ["waan harka ifii jiruu", "dhihoo", "kaluu"]);
  Phrase phrase3 = Phrase("by hand", ["harkaan", "ka makiinaan hin tahin"]);
  SubEntry subNoun = SubEntry("noun");
  Phrase phrase4 = Phrase("", ["dabarsuu", "keennuu"]);
  Phrase phrase5 = Phrase("hand back", ["deebisu"]);
  Phrase phrase6 = Phrase("hand down", ["gad kennuu", "buusu"]);
  Phrase phrase7 = Phrase(
      "hand in", ["galchuu", "naquu", "ol kennuu", "fidu", "deebisuu"],
      example: "~ homework");
  SubEntry subVerb = SubEntry("verb"); */

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      englishVM = Provider.of<SearchListViewModel>(context);
      textTheme = Theme.of(context).textTheme;
      initialized = true;
    }
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            color: COLOR_GREEN,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AppHeader(),
                              _searchBar(),
                              hasSearched
                                  ? addVerticalSpace(1)
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

  TextField _searchBar() {
    return TextField(
      focusNode: _searchBarFocusNode,
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
      suffixIcon: _selectLanguageIcon(),
    );
  }

  //Switch Language search between English and Oromo words
  GestureDetector _selectLanguageIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _searchBarFocusNode.canRequestFocus = false;
          _searchBarFocusNode.unfocus();
        });
      },
      child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: LanguageSelector()),
    );
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
