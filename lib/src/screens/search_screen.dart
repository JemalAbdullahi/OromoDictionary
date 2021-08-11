import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_view_model.dart';
import 'package:provider/provider.dart';
import 'package:oromo_dictionary/src/screens/translation_screen.dart';
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
    final englishVM = Provider.of<EnglishWordListViewModel>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
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
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "English-Oromo Dictionary",
                                  style: textTheme.headline5!
                                      .apply(color: COLOR_YELLOW),
                                )),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: COLOR_YELLOW,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Image.asset(
                                          "assets/images/Oddaa.png")),
                                )
                              ],
                            ),
                            TextField(
                              style: textTheme.subtitle1!
                                  .apply(color: COLOR_WHITE),
                              decoration: InputDecoration(
                                hintText: "Search for a Word to Translate...",
                                hintStyle: textTheme.subtitle1!
                                    .apply(color: COLOR_WHITE),
                                filled: true,
                                fillColor: Colors.white38,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none),
                                prefixIcon:
                                    Icon(Icons.search, color: COLOR_WHITE),
                                suffixIcon: Container(
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
                                ),
                              ),
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  englishVM.fetchEnglishWords(value);
                                  setState(() {
                                    hasSearched = true;
                                  });
                                } else if (value.isEmpty) {
                                  setState(() {
                                    hasSearched = false;
                                  });
                                }
                              },
                            ),
                            hasSearched
                                ? addVerticalSpace(1)
                                : addVerticalSpace(30),
                          ]),
                    )
                  ],
                ),
              ),
              hasSearched
                  ? Container(
                      decoration: BoxDecoration(
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
                      ),
                      height: constraints.maxHeight / 1.8,
                      width: constraints.maxWidth,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: englishVM.englishWords.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              EnglishWordViewModel word =
                                  englishVM.englishWords[index];
                              await word.setForms();
                              Navigator.pushNamed(
                                context,
                                TranslationScreen.routeName,
                                arguments: TranslationScreenArguments(word),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                '${englishVM.englishWords[index].word}',
                                style: textTheme.subtitle1!,
                              ),
                              subtitle: Text(
                                '/${englishVM.englishWords[index].phonetic}/',
                                style: textTheme.subtitle2!
                                    .apply(color: Colors.black54),
                              ),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: COLOR_BLACK,
                          thickness: 0.2,
                        ),
                      ),
                    )
                  : Container(width: constraints.maxWidth),
            ],
          ),
        );
      }),
    );
  }
}
