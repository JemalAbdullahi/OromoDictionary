import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [_headerText(textTheme), _headerImage()],
    );
  }

  Expanded _headerText(TextTheme textTheme) {
    return Expanded(
        child: Text(
      "English-Oromo Dictionary",
      style: textTheme.headline5!.apply(color: COLOR_YELLOW),
    ));
  }

  Container _headerImage() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: COLOR_YELLOW,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/Oddaa.png")),
    );
  }
}
