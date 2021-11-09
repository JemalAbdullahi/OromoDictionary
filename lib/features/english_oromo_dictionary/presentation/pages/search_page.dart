import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src/utils/widget_functions.dart';
import '../../domain/entities/english_word.dart';
import '../../domain/entities/oromo_translation.dart';
import '../bloc/search_page_bloc/bloc.dart';
import '../widgets/search_page_widgets/search_page_widgets.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = "/";
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchPageBloc englishOromoDictionaryBloc;
  late ThemeData theme;
  bool initialized = false;

  _initialize(BuildContext context) {
    if (!initialized) {
      theme = Theme.of(context);
      englishOromoDictionaryBloc =
          BlocProvider.of<SearchPageBloc>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initialize(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: buildBody(context),
      ),
    );
  }

  Center buildBody(BuildContext context) {
    Size constraints = MediaQuery.of(context).size;
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: constraints.width,
        height: constraints.height,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  //Custom AppBar,
                  SearchPageAppBar(
                    textTheme: theme.textTheme,
                  ),
                  //Top Half: Title and Search Bar
                  _buildHeaderLayout(context),
                ],
              ),
            ),
            //Bottom Half: SearchResults
            _buildSearchResultsBlocBuilder(constraints)
          ],
        ),
      ),
    );
  }

  Padding _buildHeaderLayout(BuildContext context) {
    return Padding(
      padding: isEmptyState(context)
          ? const EdgeInsets.all(10)
          : const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppHeader(),
          SearchBar(),
          isEmptyState(context) ? addVerticalSpace(30) : addVerticalSpace(0),
        ],
      ),
    );
  }

  BlocBuilder<SearchPageBloc, PageState>
      _buildSearchResultsBlocBuilder(Size constraints) {
    return BlocBuilder<SearchPageBloc, PageState>(
        builder: (context, state) {
      if (state is Empty) {
        return SizedBox.shrink();
      } else if (state is Loading) {
        return LoadingWidget(heightDenominator: 3,);
      } else if (state is Loaded) {
        return englishOromoDictionaryBloc.isEnglish
            ? EnglishSearchResultsDisplay(
                constraints: constraints,
                message: "No Words Found! Try searching a different word.",
                wordList: state.wordList as List<EnglishWord>,
                theme: theme,
              )
            : OromoSearchResultsDisplay(
                constraints: constraints,
                message: "No Words Found! Try searching a different word.",
                wordList: state.wordList as List<OromoTranslation>,
                theme: theme);
      } else if (state is Error) {
        return EnglishSearchResultsDisplay(
          constraints: constraints,
          message: state.message,
          wordList: [],
          theme: theme,
        );
      }
      return Container();
    });
  }

  /// Provided the context, will return whether the BlocProvider is in an Empty
  /// state.
  bool isEmptyState(BuildContext context) {
    return englishOromoDictionaryBloc.state == Empty();
  }
}
