import 'package:flutter/material.dart';
import '../../../domain/entities/phrase.dart';

class PhraseTranslationContainer extends StatelessWidget {
  const PhraseTranslationContainer(
      {Key? key,
      required this.textTheme,
      this.phrase,
      this.englishDef,
      required this.index,
      required this.isPhraseSection})
      : super(key: key);

  final TextTheme textTheme;
  final Phrase? phrase;
  final String? englishDef;
  final int index;
  final bool isPhraseSection;

  @override
  Widget build(BuildContext context) {
    double phraseTranslationContainerWidth =
        MediaQuery.of(context).size.width * 0.8;
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("${index + 1}. ", style: textTheme.bodyText2!),
            Container(
              width: phraseTranslationContainerWidth,
              child: isPhraseSection ? _phraseColumn() : _englishDefText(),
            ),
          ],
        ),
      ),
    );
  }

  Column _phraseColumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (phrase!.phrase != null && phrase!.phrase!.isNotEmpty)
          Text("${phrase!.phrase} ${phrase!.exampleToString()}",
              style: textTheme.bodyText2!.apply(fontStyle: FontStyle.italic)),
        Text(
          "${phrase!.translationToString()}",
          style: textTheme.bodyText2!,
          softWrap: true,
        ),
      ],
    );
  }

  Text _englishDefText() {
    return Text(
      englishDef!,
      style: textTheme.bodyText2!,
      softWrap: true,
    );
  }
}