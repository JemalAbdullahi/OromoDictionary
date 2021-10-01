import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/util/constants.dart';
import '../bloc/bloc.dart';

class LanguageSelector extends StatefulWidget {
  ///Widget which switches the Language between English and Oromo
  const LanguageSelector({
    Key? key,
  }) : super(key: key);

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return _popupMenuButton(context);
  }

  PopupMenuButton _popupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Text(
        BlocProvider.of<EnglishOromoDictionaryBloc>(context).isEnglish
            ? 'EN'
            : 'OM',
        style: theme.textTheme.bodyText1!
            .apply(color: COLOR_GREEN, fontWeightDelta: 2),
      ),
      color: COLOR_YELLOW,
      offset: Offset(0, 65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      onSelected: (value) {
        BlocProvider.of<EnglishOromoDictionaryBloc>(context)
            .add(ChangeLanguageSelected(isEnglish: value == 'en'));
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: "en",
          child: Row(children: [
            Text(
              "English",
              style: theme.textTheme.bodyText2!.apply(
                color: COLOR_GREEN,
                fontWeightDelta: 2,
              ),
            )
          ]),
        ),
        PopupMenuItem<String>(
          value: "om",
          child: Row(children: [
            Text(
              "Oromo",
              style: theme.textTheme.bodyText2!.apply(
                color: COLOR_GREEN,
                fontWeightDelta: 2,
              ),
            )
          ]),
        ),
      ],
    );
  }
}
