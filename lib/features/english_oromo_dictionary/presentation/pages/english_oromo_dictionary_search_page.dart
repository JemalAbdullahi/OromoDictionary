import 'package:flutter/material.dart';
import 'package:oromo_dictionary/core/presentation/util/constants.dart';
import 'package:oromo_dictionary/src/components/search_screen_comp/app_header.dart';
import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnglishOromoDictionarySearchPage extends StatefulWidget {
  const EnglishOromoDictionarySearchPage({Key? key}) : super(key: key);

  @override
  _EnglishOromoDictionarySearchPageState createState() => _EnglishOromoDictionarySearchPageState();
}

class _EnglishOromoDictionarySearchPageState extends State<EnglishOromoDictionarySearchPage> {
  late final ThemeData theme;

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
                        //AppBar,
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AppHeader(),
                              searchBar(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        }),
      ),
    );
  }

  Stack searchBar() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        _searchBar(),
        _selectLanguageIcon(),
      ],
    );
  }

  TextField _searchBar() {
    return TextField(
      //focusNode: _searchBarFocusNode,
      //controller: _searchBarController,
      style: theme.textTheme.subtitle1!.apply(color: COLOR_WHITE),
      decoration: _searchBarDecoration(),
      //onSubmitted: _search,
      autocorrect: false,
    );
  }

  InputDecoration _searchBarDecoration() {
    return InputDecoration(
      hintText: "Search a Word to Translate...",
      hintStyle: theme.textTheme.subtitle1!.apply(color: COLOR_WHITE),
      filled: true,
      fillColor: Colors.white38,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      prefixIcon: Icon(Icons.search, color: COLOR_WHITE),
      // suffixIcon: _selectLanguageIcon(),
    );
  }

  Container _selectLanguageIcon() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        // color: Colors.white30,
        color: COLOR_YELLOW,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      /* child: LanguageSelector(
          controller: _searchBarController,
          englishVM: englishVM,
          textTheme: textTheme), */
    );
  }
}
