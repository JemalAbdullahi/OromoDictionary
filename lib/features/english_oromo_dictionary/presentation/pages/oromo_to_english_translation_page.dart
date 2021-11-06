import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/bloc/oromo_translation_page_bloc/bloc.dart';

import '../../../../core/presentation/util/constants.dart';
import '../../../../core/presentation/util/widget_functions.dart';
import '../../domain/entities/oromo_translation.dart';
import '../../domain/usecases/oromo_word_page/get_oromo_phonetic_breakdown.dart';
import '../widgets/loading_widget.dart';
import '../widgets/search_page_widgets/english_search_results_display.dart';

class OromoToEnglishTranslationPage extends StatefulWidget {
  static const String routeName = "/pages/oromo";
  const OromoToEnglishTranslationPage({Key? key}) : super(key: key);

  @override
  _OromoToEnglishTranslationPageState createState() =>
      _OromoToEnglishTranslationPageState();
}

class _OromoToEnglishTranslationPageState
    extends State<OromoToEnglishTranslationPage> {
  late OromoTranslationPageBloc bloc;
  late final ThemeData _theme;
  late final OromoTranslation _oromoTranslation;
  bool initialized = false;
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

  /// Takes the [context] to be built, and initializes all the late fields
  /// yet to be initialized.
  ///
  /// Also, retrieves the list of English Words corresponding to the oromo word
  /// by adding an [event] to the BlocProvider.
  _initialize(BuildContext context) {
    if (!initialized) {
      bloc =
          BlocProvider.of<OromoTranslationPageBloc>(context);
      _theme = Theme.of(context);
      final args = ModalRoute.of(context)!.settings.arguments
          as OromoToEnglishTranslationPageArguments;
      _oromoTranslation = args.oromoTranslation;
      initialized = true;
      // Get List of English Words corresponding to Oromo Word
      bloc.add(
          GetEnglishTranslationsList(_oromoTranslation.translation));
    }
  }

  Column _buildColumn(Size constraints) {
    return Column(
      children: [
        wordContainer(constraints),
        addVerticalSpace(60),
        Expanded(child: _buildEnglishWordListBlocBuilder(constraints))
      ],
    );
  }

  FittedBox wordContainer(Size constraints) {
    return FittedBox(
        child: Container(
      width: constraints.width,
      child: Column(
        children: [_wordContainer(constraints), partOfSpeechSelector()],
      ),
    ));
  }

  Container _wordContainer(Size constraints) {
    return Container(
      width: constraints.width,
      height: 100,
      padding: const EdgeInsets.only(left: 28, right: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: constraints.width / 1.5,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                _oromoTranslation.translation,
                style: _theme.textTheme.headline4!.apply(color: COLOR_YELLOW),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          oddaaImage()
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
        text: GetOromoPhoneticBreakdown()
            .call(oromoWord: _oromoTranslation.translation),
        style: _theme.textTheme.bodyText1!.apply(color: COLOR_YELLOW),
        startAfter: Duration(seconds: 2),
        velocity: 50,
        pauseAfterRound: Duration(seconds: 2),
        numberOfRounds: 2,
        blankSpace: 300,
      ),
    );
  }

  BlocBuilder<OromoTranslationPageBloc, PageState>
      _buildEnglishWordListBlocBuilder(Size constraints) {
    return BlocBuilder<OromoTranslationPageBloc, PageState>(
        builder: (context, state) {
      if (state is Empty) {
        return SizedBox.shrink();
      } else if (state is Loading) {
        return LoadingWidget();
      } else if (state is Loaded) {
        print(state.wordList.toString());
        return EnglishSearchResultsDisplay(
          constraints: constraints,
          theme: _theme,
          message:
              "No Words Found associated to ${_oromoTranslation.translation}! Return to the Search Page",
          wordList: state.wordList,
        );
      } else if (state is Error) {
        return EnglishSearchResultsDisplay(
          constraints: constraints,
          message: state.message,
          wordList: [],
          theme: _theme,
        );
      }
      return Container();
    });
  }
}

class OromoToEnglishTranslationPageArguments {
  final OromoTranslation oromoTranslation;
  OromoToEnglishTranslationPageArguments(this.oromoTranslation);
}
