import 'package:flutter/material.dart';
import 'package:oromo_dictionary/utils/constants.dart';
import 'package:oromo_dictionary/viewmodels/english_view_models/english_word_view_model.dart';
import 'package:oromo_dictionary/viewmodels/grammatical_form_view_models/grammatical_form_view_model.dart';
import 'package:oromo_dictionary/viewmodels/phrase_view_models/phrase_view_model.dart';

class TranslationScreen extends StatefulWidget {
  static const String routeName = "/translation";
  const TranslationScreen({Key? key}) : super(key: key);

  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  late final EnglishWordViewModel englishWord;
  late final TextTheme textTheme;
  bool initialized = false;
  int selectedSubEntryIndex = 0;
  double phraseTranslationContainerWidth = 100;

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      textTheme = Theme.of(context).textTheme;
      final args = ModalRoute.of(context)!.settings.arguments
          as TranslationScreenArguments;
      englishWord = args.englishWord;
      phraseTranslationContainerWidth = MediaQuery.of(context).size.width * 0.8;
      initialized = true;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Column(
            children: [
              FittedBox(
                child: Container(
                  color: COLOR_GREEN,
                  child: Column(
                    children: [
                      Container(
                        width: constraints.maxWidth,
                        height: 100,
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              englishWord.word,
                              style: textTheme.headline4!
                                  .apply(color: COLOR_YELLOW),
                            ),
                            Text(
                              "/ ${englishWord.phonetic} /",
                              style: textTheme.bodyText1!
                                  .apply(color: COLOR_YELLOW),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: COLOR_GREY,
                      width: constraints.maxWidth,
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: englishWord.forms!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            shape: index == selectedSubEntryIndex
                                ? Border(
                                    bottom: BorderSide(
                                        color: COLOR_GREEN, width: 5))
                                : null,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedSubEntryIndex = index;
                                });
                              },
                              child: Text(
                                '${englishWord.forms![index].partOfSpeech.toUpperCase()}',
                                style: textTheme.bodyText2!
                                    .apply(color: COLOR_BLACK),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    selectedEntry(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Expanded selectedEntry() {
    GrammaticalFormViewModel selectedSubEntry =
        englishWord.forms![selectedSubEntryIndex];
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedSubEntry.phrases!.length,
              itemBuilder: (BuildContext context, int index) {
                return phraseTranslationContainer(
                    selectedSubEntry.phrases![index], index);
              },
            ),
          )
        ],
      ),
    );
  }

  Container phraseTranslationContainer(PhraseViewModel phrase, int index) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.only(left: 12, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("${index + 1}. ", style: textTheme.bodyText2!),
          Container(
            width: phraseTranslationContainerWidth,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (phrase.phrase != null && phrase.phrase!.isNotEmpty)
                  Text("${phrase.phrase} ${phrase.exampleToString()}",
                      style: textTheme.bodyText2!
                          .apply(fontStyle: FontStyle.italic)),
                Text(
                  "${phrase.translationToString()}",
                  style: textTheme.bodyText2!,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TranslationScreenArguments {
  final EnglishWordViewModel englishWord;
  TranslationScreenArguments(this.englishWord);
}
