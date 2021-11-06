import 'package:flutter/material.dart';
import '../../../../core/presentation/util/constants.dart';
import '../../../../core/presentation/util/widget_functions.dart';
import '../../domain/entities/english_word.dart';
import '../widgets/english_to_oromo_translation_page_widgets/selected_part_of_speech.dart';
import '../widgets/english_to_oromo_translation_page_widgets/word_container.dart';

class EnglishToOromoTranslationPage extends StatefulWidget {
  static const String routeName = "/pages/english";
  const EnglishToOromoTranslationPage({Key? key}) : super(key: key);

  @override
  _EnglishToOromoTranslationPageState createState() =>
      _EnglishToOromoTranslationPageState();
}

class _EnglishToOromoTranslationPageState
    extends State<EnglishToOromoTranslationPage> {
  late final ThemeData _theme;
  late final EnglishWord _englishWord;
  late final double phraseTranslationContainerWidth;
  bool initialized = false;
  int selectedSubEntryIndex = 0;

  _initialize(BuildContext context) {
    if (!initialized) {
      _theme = Theme.of(context);
      final args = ModalRoute.of(context)!.settings.arguments
          as EnglishToOromoTranslationPageArguments;
      _englishWord = args.englishWord;
      phraseTranslationContainerWidth = MediaQuery.of(context).size.width * 0.8;
      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _initialize(context);
    Size constraints = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        height: constraints.height,
        width: constraints.width,
        color: Theme.of(context).primaryColor,
        child: _buildColumn(constraints),
      ),
    );
  }

  Column _buildColumn(Size constraints) {
    return Column(
      children: [
        wordContainer(constraints),
        Expanded(
          child: Column(
            children: [
              partOfSpeechSelector(constraints),
              SelectedPartOfSpeech(
                  englishWord: _englishWord,
                  selectedPartOfSpeech:
                      _englishWord.forms![selectedSubEntryIndex],
                  textTheme: _theme.textTheme), 
             
            ],
          ),
        ),
      ],
    );
  }

  FittedBox wordContainer(Size constraints) {
    return FittedBox(
      child: Container(
        color: COLOR_GREEN,
        child: Column(
          children: [
            WordContainer(
                englishWord: _englishWord,
                textTheme: _theme.textTheme,
                constraints: constraints),
           
          ],
        ),
      ),
    );
  }

  Container partOfSpeechSelector(Size constraints) {
    return Container(
      color: COLOR_RED,
      width: constraints.width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,//_englishWord.forms!.length,
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
              child: Text('hello',
                //'${_englishWord.forms![index].partOfSpeech.toUpperCase()}',
                style: _theme.textTheme.headline6!.apply(color: COLOR_YELLOW),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EnglishToOromoTranslationPageArguments {
  final EnglishWord englishWord;
  EnglishToOromoTranslationPageArguments(this.englishWord);
}
