import 'package:flutter/material.dart';
import 'package:oromo_dictionary/models/translation.dart';
import 'package:oromo_dictionary/utils/constants.dart';

class TranslationScreen extends StatefulWidget {
  static const String routeName = "/translation";
  const TranslationScreen({Key? key}) : super(key: key);

  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  late MainEntry mainEntry;
  late TextTheme textTheme;
  int selectedSubEntryIndex = 0;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    final args = ModalRoute.of(context)!.settings.arguments
        as TranslationScreenArguments;
    mainEntry = args.mainEntry;
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
                              mainEntry.mainEntry,
                              style: textTheme.headline4!
                                  .apply(color: COLOR_YELLOW),
                            ),
                            Text(
                              mainEntry.phonetic,
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
                        itemCount: mainEntry.subentries.length,
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
                                '${mainEntry.subentries[index].partOfSpeech.toUpperCase()}',
                                style: textTheme.bodyText1!
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
    SubEntry selectedSubEntry = mainEntry.subentries[selectedSubEntryIndex];
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedSubEntry.phrases.length,
              itemBuilder: (BuildContext context, int index) {
                return phraseTranslationContainer(
                    selectedSubEntry.phrases[index], index);
              },
            ),
          )
        ],
      ),
    );
  }

  Container phraseTranslationContainer(Phrase phrase, int index) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 12, top: 12),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("${index + 1}. ", style: textTheme.bodyText1!),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (phrase.phrase.isNotEmpty)
                Text("${phrase.phrase} ${phrase.exampleToString()}",
                    style: textTheme.bodyText1!
                        .apply(fontStyle: FontStyle.italic)),
              Text("${phrase.translationToString()}",
                  style: textTheme.bodyText1!),
            ],
          ),
        ],
      ),
    );
  }
}

class TranslationScreenArguments {
  final MainEntry mainEntry;
  TranslationScreenArguments(this.mainEntry);
}
