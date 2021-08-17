import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/services/api.dart';
import 'package:oromo_dictionary/src/utils/constants.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _popupMenuButton();
  }

  PopupMenuButton _popupMenuButton() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.menu),
      color: COLOR_WHITE,
      offset: Offset(0, 65),
      onSelected: (value) {
        API.language = value;
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: "en",
          child: Row(children: [Text("English")]),
        ),
        PopupMenuItem<String>(
          value: "om",
          child: Row(children: [Text("Oromo")]),
        ),
      ],
    );
  }
}
