import 'package:flutter/material.dart';
import '../../components/translation_screen_comp/selected_part_of_speech.dart';
import '../../components/translation_screen_comp/word_container.dart';
import '../../utils/constants.dart';
import '../../utils/widget_functions.dart';
import '../../viewmodels/english_view_models/english_word_view_model.dart';

class EnglishOromoTranslationScreen extends StatefulWidget {
  static const String routeName = "/englishtranslation";
  const EnglishOromoTranslationScreen({Key? key}) : super(key: key);

  @override
  _EnglishOromoTranslationScreenState createState() => _EnglishOromoTranslationScreenState();
}

class _EnglishOromoTranslationScreenState extends State<EnglishOromoTranslationScreen> {
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
          as EnglishOromoTranslationScreenArguments;
      englishWord = args.englishWord;
      phraseTranslationContainerWidth = MediaQuery.of(context).size.width * 0.8;
      initialized = true;
    }
    return Scaffold(
      appBar: customAppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
          child: _buildColumn(constraints),
        );
      }),
    );
  }

  Column _buildColumn(BoxConstraints constraints) {
    return Column(
      children: [
        wordContainer(constraints),
        Expanded(
          child: Column(
            children: [
              partOfSpeechSelector(constraints),
              SelectedPartOfSpeech(
                  englishWord: englishWord,
                  selectedPartOfSpeech:
                      englishWord.forms![selectedSubEntryIndex],
                  textTheme: textTheme),
            ],
          ),
        ),
      ],
    );
  }

  FittedBox wordContainer(BoxConstraints constraints) {
    return FittedBox(
      child: Container(
        color: COLOR_GREEN,
        child: Column(
          children: [
            WordContainer(
                englishWord: englishWord,
                textTheme: textTheme,
                constraints: constraints),
          ],
        ),
      ),
    );
  }

  Container partOfSpeechSelector(BoxConstraints constraints) {
    return Container(
      color: COLOR_RED,
      width: constraints.maxWidth,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: englishWord.forms!.length,
        itemBuilder: (BuildContext context, int index) {
          return Material(
            color: COLOR_RED,
            shape: index == selectedSubEntryIndex
                ? Border(bottom: BorderSide(color: COLOR_YELLOW, width: 5))
                : null,
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedSubEntryIndex = index;
                });
              },
              child: Text(
                '${englishWord.forms![index].partOfSpeech.toUpperCase()}',
                style: textTheme.headline6!.apply(color: COLOR_YELLOW),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EnglishOromoTranslationScreenArguments {
  final EnglishWordViewModel englishWord;
  EnglishOromoTranslationScreenArguments(this.englishWord);
}
