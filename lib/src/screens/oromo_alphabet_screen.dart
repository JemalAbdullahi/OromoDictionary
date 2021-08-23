import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/utils/constants.dart';

class OromoAlphabetScreen extends StatefulWidget {
  static const String routeName = "/alphabet";
  const OromoAlphabetScreen({Key? key}) : super(key: key);

  @override
  _OromoAlphabetScreenState createState() => _OromoAlphabetScreenState();
}

class _OromoAlphabetScreenState extends State<OromoAlphabetScreen> {
  // ThemeData? theme;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Text(
          "Qubee Afaan Oromo",
          style: theme.textTheme.headline5!.apply(color: theme.accentColor),
        ),
        centerTitle: true,
        iconTheme: theme.iconTheme,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: theme.primaryColor,
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: ListView.builder(
              itemBuilder: (context, index) => Card(
                color: theme.accentColor,
                child: ListTile(
                  leading: Text(
                    consonants.keys.elementAt(index),
                    style: theme.textTheme.headline6!
                        .apply(color: theme.primaryColor),
                  ),
                  title: Text(
                    consonants.values.elementAt(index),
                    style: theme.textTheme.bodyText1!
                        .apply(color: theme.primaryColor),
                    softWrap: true,
                  ),
                ),
              ),
              itemCount: consonants.length,
            ),
          );
        },
      ),
    );
  }
}
