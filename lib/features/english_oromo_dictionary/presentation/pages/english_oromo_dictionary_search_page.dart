import 'package:flutter/material.dart';
import '../../domain/entities/english_word.dart';
import '../../domain/entities/oromo_translation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/search_page_widgets/search_page_widgets.dart';
import '../bloc/bloc.dart';
import '../../../../src/utils/widget_functions.dart';
import '../../../../injection_container.dart';

class EnglishOromoDictionarySearchPage extends StatefulWidget {
  static const String routeName = "/pages/search";
  const EnglishOromoDictionarySearchPage({Key? key}) : super(key: key);

  @override
  _EnglishOromoDictionarySearchPageState createState() =>
      _EnglishOromoDictionarySearchPageState();
}

class _EnglishOromoDictionarySearchPageState
    extends State<EnglishOromoDictionarySearchPage> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
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

  BlocProvider<EnglishOromoDictionaryBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EnglishOromoDictionaryBloc>(),
      child: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            alignment: Alignment.center,
            width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
            height: constraints.maxHeight > 1000
                ? constraints.maxHeight * 0.8
                : constraints.maxHeight,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      //Insert Custom AppBar,
                      //Top Half: Title and Search Bar
                      Padding(
                        padding: isEmptyState(context)
                            ? const EdgeInsets.all(10)
                            : const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppHeader(),
                            SearchBar(),
                            isEmptyState(context)
                                ? addVerticalSpace(30)
                                : addVerticalSpace(0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Bottom Half: SearchResults
                BlocBuilder<EnglishOromoDictionaryBloc,
                    EnglishOromoDictionaryState>(builder: (context, state) {
                  if (state is Empty) {
                    return SizedBox.shrink();
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return BlocProvider.of<EnglishOromoDictionaryBloc>(context)
                            .isEnglish
                        ? EnglishSearchResultsDisplay(
                            constraints: constraints,
                            message:
                                "No Words Found! Try searching a different word.",
                            wordList: state.wordList as List<EnglishWord>,
                            theme: theme,
                          )
                        : OromoSearchResultsDisplay(
                            constraints: constraints,
                            message:
                                "No Words Found! Try searching a different word.",
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
                })
              ],
            ),
          );
        }),
      ),
    );
  }

  /// Provided the context, will return whether the BlocProvider is in an Empty
  /// state.
  bool isEmptyState(BuildContext context) {
    return BlocProvider.of<EnglishOromoDictionaryBloc>(context).state ==
        Empty();
  }
}
