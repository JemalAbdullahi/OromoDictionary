import 'package:flutter/material.dart';

import 'package:oromo_dictionary/core/presentation/util/constants.dart';

class OromoAlphabetScreen extends StatefulWidget {
  static const String routeName = "/alphabet";
  const OromoAlphabetScreen({Key? key}) : super(key: key);

  @override
  _OromoAlphabetScreenState createState() => _OromoAlphabetScreenState();
}

class _OromoAlphabetScreenState extends State<OromoAlphabetScreen> {
  late ThemeData theme;
  String selectedLetters = "";
  Map<String, Map<String, String>> letterSet = {
    "Consonants": consonants,
    "Oromo Specific Consonants": uniqueConsonants,
    "Short Vowels": shortVowels,
    "Long Vowels": longVowels,
  };
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
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
        actions: [
          selectedLetters.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      selectedLetters = "";
                    });
                  },
                  icon: Icon(Icons.clear),
                )
              : SizedBox.shrink()
        ],
      ),
      backgroundColor: theme.primaryColor,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: selectedLetters.isEmpty
                  ? _buildlistViewSelector()
                  : _listViewLetterBuilder(letterSet[selectedLetters]!),
            );
          },
        ),
      ),
    );
  }

  ListView _buildlistViewSelector() {
    return ListView(
      children: [
        _listTileCard(letterSet.keys.elementAt(0)),
        _listTileCard(letterSet.keys.elementAt(1)),
        _listTileCard(letterSet.keys.elementAt(2)),
        _listTileCard(letterSet.keys.elementAt(3)),
      ],
    );
  }

  GestureDetector _listTileCard(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLetters = title;
        });
      },
      child: Card(
        color: theme.accentColor,
        child: ListTile(
          trailing: Icon(Icons.arrow_forward_ios, color: theme.primaryColor),
          title: Text(title,
              style:
                  theme.textTheme.bodyText1!.apply(color: theme.primaryColor)),
        ),
      ),
    );
  }

  ListView _listViewLetterBuilder(Map<String, String> letters) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        color: theme.accentColor,
        child: ListTile(
          leading: Text(
            letters.keys.elementAt(index),
            style: theme.textTheme.headline6!.apply(color: theme.primaryColor),
          ),
          title: Text(
            letters.values.elementAt(index),
            style: theme.textTheme.bodyText1!.apply(color: theme.primaryColor),
            softWrap: true,
          ),
        ),
      ),
      itemCount: letters.length,
    );
  }
}
