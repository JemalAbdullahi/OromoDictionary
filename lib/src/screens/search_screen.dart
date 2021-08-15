import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/components/search_screen_comp/app_header.dart';
import 'package:oromo_dictionary/src/components/search_screen_comp/search_results_container.dart';
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
  late final EnglishWordListViewModel englishVM;
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
      englishVM = Provider.of<EnglishWordListViewModel>(context);
      textTheme = Theme.of(context).textTheme;
      initialized = true;
    }
    return Scaffold(
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
                  ? SearchResultsContainer(
                      englishVM: englishVM,
                      textTheme: textTheme,
                      constraints: constraints)
                  : Container(width: constraints.maxWidth),
            ],
          ),
        );
      }),
    );
  }

  TextField _searchBar() {
    return TextField(
      style: textTheme.subtitle1!.apply(color: COLOR_WHITE),
      decoration: _searchBarDecoration(),
      onSubmitted: _search,
    );
  }

  InputDecoration _searchBarDecoration() {
    return InputDecoration(
      hintText: "Search for a Word to Translate...",
      hintStyle: textTheme.subtitle1!.apply(color: COLOR_WHITE),
      filled: true,
      fillColor: Colors.white38,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      prefixIcon: Icon(Icons.search, color: COLOR_WHITE),
      suffixIcon: _selectLanguageIcon(),
    );
  }

  Container _selectLanguageIcon() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Icon(Icons.menu, color: Colors.white),
    );
  }

  void _search(value) {
    value.isNotEmpty ? _fetchEnglishWords(value) : _resetSearch();
  }

  void _fetchEnglishWords(String value) {
    englishVM.fetchEnglishWords(value);
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
