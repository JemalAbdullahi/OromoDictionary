import 'package:flutter/material.dart';
import 'package:oromo_dictionary/core/presentation/util/constants.dart';

class SearchPageAppBar extends StatelessWidget {
  SearchPageAppBar({Key? key}) : super(key: key);

  late TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return AppBar(
      leading: _popupMenuButton(context),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  PopupMenuButton _popupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.sort_by_alpha, color: COLOR_YELLOW),
      color: COLOR_YELLOW,
      offset: Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      onSelected: (value) {
        //Navigator.pushNamed(context, OromoAlphabetScreen.routeName);
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: "Oromo Alphabet",
          child: Row(children: [
            Text(
              "Oromo Alphabet",
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
