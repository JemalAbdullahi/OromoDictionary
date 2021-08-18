import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/services/api.dart';
import 'package:oromo_dictionary/src/utils/constants.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_list_view_model.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector(
      {Key? key,
      required this.controller,
      required this.englishVM,
      required this.textTheme})
      : super(key: key);

  final TextEditingController controller;
  final SearchListViewModel englishVM;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return _popupMenuButton();
  }

  PopupMenuButton _popupMenuButton() {
    return PopupMenuButton<String>(
      icon: Text(
        API.language.toUpperCase(),
        style:
            textTheme.bodyText1!.apply(color: COLOR_GREEN, fontWeightDelta: 2),
      ),
      color: COLOR_YELLOW,
      offset: Offset(0, 65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      onSelected: (value) {
        englishVM.words = [];
        controller.clear();
        API.language = value;
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: "en",
          child: Row(children: [
            Text(
              "English",
              style: textTheme.bodyText2!.apply(
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
              style: textTheme.bodyText2!.apply(
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
