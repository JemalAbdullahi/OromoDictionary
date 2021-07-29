import 'package:flutter/material.dart';
import 'package:oromo_dictionary/models/translation.dart';
import 'package:oromo_dictionary/screens/translation_screen.dart';
import 'package:oromo_dictionary/utils/constants.dart';
import 'package:oromo_dictionary/utils/widget_functions.dart';

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

class LandingScreen extends StatefulWidget {
  static const String routeName = "/";
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool hasSearched = false;
  List<Map<String, Object>> searchedWords = [];

  MainEntry mainEntry = MainEntry("hand", "/ haand /");
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
  SubEntry subVerb = SubEntry("verb");

  _LandingScreenState() {
    subNoun.phrases = [phrase1, phrase2, phrase3];
    subVerb.phrases = [phrase4, phrase5, phrase6, phrase7];
    mainEntry.subentries = [subNoun, subVerb];
  }

  @override
  Widget build(BuildContext context) {
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
                              style: textTheme.bodyText1!
                                  .apply(color: COLOR_WHITE),
                              decoration: InputDecoration(
                                hintText: "Search for a Word to Translate...",
                                hintStyle: textTheme.bodyText1!
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
                                setState(() {
                                  search(value);
                                });
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
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        ),
                      ),
                      height: constraints.maxHeight / 1.8,
                      width: constraints.maxWidth,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: searchedWords.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              TranslationScreen.routeName,
                              arguments: TranslationScreenArguments(
                                  mainEntry),
                            ),
                            child: ListTile(
                              title:
                                  Text('${searchedWords[index]["main_entry"]}'),
                              subtitle:
                                  Text('${searchedWords[index]["phonetic"]}'),
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

  void search(String word) {
    hasSearched = true;
    searchedWords = [];
    for (var w in DICTIONARY_DATA) {
      if (w["main_entry"]! == word) {
        searchedWords.add(w);
      }
    }
  }
}
