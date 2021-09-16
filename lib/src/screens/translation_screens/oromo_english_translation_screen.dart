import 'package:flutter/material.dart';
import '../../components/search_screen_comp/english_search_results_container.dart';
import '../../utils/constants.dart';
import '../../utils/widget_functions.dart';
import '../../viewmodels/english_view_models/english_word_list_view_model.dart';
import '../../viewmodels/oromo_translation_view_models/oromo_translation_view_model.dart';
import 'package:provider/provider.dart';
import 'package:marquee/marquee.dart';

class OromoEnglishTranslationScreen extends StatefulWidget {
  static const String routeName = "/oromotranslation";
  const OromoEnglishTranslationScreen({Key? key}) : super(key: key);

  @override
  _OromoEnglishTranslationScreenState createState() =>
      _OromoEnglishTranslationScreenState();
}

class _OromoEnglishTranslationScreenState
    extends State<OromoEnglishTranslationScreen> {
  late final OromoTranslationViewModel oromoWord;
  late final SearchListViewModel englishVM;
  late final TextTheme textTheme;
  bool initialized = false;
  int selectedSubEntryIndex = 0;
  double phraseTranslationContainerWidth = 100;

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      englishVM = Provider.of<SearchListViewModel>(context);
      textTheme = Theme.of(context).textTheme;
      final args = ModalRoute.of(context)!.settings.arguments
          as OromoEnglishTranslationScreenArguments;
      oromoWord = args.oromoWord;
      setUp();
      phraseTranslationContainerWidth = MediaQuery.of(context).size.width * 0.8;
      initialized = true;
    }
    return Scaffold(
      appBar: customAppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
          color: Theme.of(context).primaryColor,
          child: _buildColumn(constraints),
        );
      }),
    );
  }

  Future<void> setUp() async {
    await englishVM.fetchEnglishWords(oromoWord.translation);
  }

  Column _buildColumn(BoxConstraints constraints) {
    return Column(
      children: [
        wordContainer(constraints),
        addVerticalSpace(60),
        Expanded(
          child: EnglishSearchResultsContainer(
              englishVM: englishVM,
              textTheme: textTheme,
              constraints: constraints),
        ),
      ],
    );
  }

  FittedBox wordContainer(BoxConstraints constraints) {
    return FittedBox(
      child: Container(
        width: constraints.maxWidth,
        child: Column(
          children: [_wordContainer(constraints), partOfSpeechSelector()],
        ),
      ),
    );
  }

  Container _wordContainer(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: 100,
      padding: const EdgeInsets.only(left: 28.0, right: 28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: constraints.maxWidth / 1.5,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                oromoWord.translation,
                style: textTheme.headline4!.apply(color: COLOR_YELLOW),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          oddaaImage(),
        ],
      ),
    );
  }

  Container partOfSpeechSelector() {
    return Container(
      color: COLOR_RED,
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Marquee(
        text: oromoWord.translationBreakdown(),
        style: textTheme.bodyText1!.apply(color: COLOR_YELLOW),
        startAfter: Duration(seconds: 2),
        velocity: 50,
        pauseAfterRound: Duration(seconds: 2),
        numberOfRounds: 2,
        blankSpace: 300,
      ),
    );
  }
}

class OromoEnglishTranslationScreenArguments {
  final OromoTranslationViewModel oromoWord;
  OromoEnglishTranslationScreenArguments(this.oromoWord);
}
