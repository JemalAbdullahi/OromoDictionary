import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/english_translation_page_bloc/bloc.dart';
import '../widgets/loading_widget.dart';
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
  late final EnglishTranslationPageBloc bloc;
  late final ThemeData _theme;
  late EnglishWord _englishWord;
  late final double phraseTranslationContainerWidth;
  bool initialized = false;
  int selectedSubEntryIndex = 0;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<EnglishTranslationPageBloc>(context);
  }

  _initialize(BuildContext context) {
    if (!initialized) {
      _theme = Theme.of(context);
      final args = ModalRoute.of(context)!.settings.arguments
          as EnglishToOromoTranslationPageArguments;
      _englishWord = args.englishWord;
      phraseTranslationContainerWidth = MediaQuery.of(context).size.width * 0.8;
      initialized = true;
    }
    bloc.add(GetEnglishWordInfo(_englishWord));
  }

  @override
  Widget build(BuildContext context) {
    _initialize(context);
    Size constraints = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _theme.primaryColor,
      appBar: customAppBar(),
      body: _buildBody(constraints),
    );
  }

  BlocBuilder<EnglishTranslationPageBloc, PageState> _buildBody(
      Size constraints) {
    return BlocBuilder<EnglishTranslationPageBloc, PageState>(
      builder: (context, state) {
        if (state is Empty) {
          return SizedBox.shrink();
        } else if (state is Loading) {
          return LoadingWidget(heightDenominator: 1);
        } else if (state is Loaded) {
          _englishWord = state.englishWord;
          return Container(
            height: constraints.height,
            width: constraints.width,
            color: _theme.primaryColor,
            child: _buildColumn(constraints),
          );
        } else if (state is Error) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
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
        itemCount: _englishWord.forms!.length,
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
                '${_englishWord.forms![index].partOfSpeech.toUpperCase()}',
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
