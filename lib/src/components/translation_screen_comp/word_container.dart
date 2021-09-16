import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../utils/constants.dart';
import '../../utils/widget_functions.dart';
import '../../viewmodels/english_view_models/english_word_view_model.dart';

class WordContainer extends StatelessWidget {
  const WordContainer({
    Key? key,
    required this.englishWord,
    required this.textTheme,
    required this.constraints,
  }) : super(key: key);

  final EnglishWordViewModel englishWord;
  final TextTheme textTheme;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      height: 100,
      padding: const EdgeInsets.only(left: 28.0, right: 28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildColumn(),
          oddaaImage(),
        ],
      ),
    );
  }

  Column _buildColumn() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _wordText(),
      _PhoneticButton(englishWord: englishWord, textTheme: textTheme)
    ]);
  }

  Text _wordText() {
    return Text(
      englishWord.word,
      style: textTheme.headline4!.apply(color: COLOR_YELLOW),
    );
  }
}

class _PhoneticButton extends StatefulWidget {
  const _PhoneticButton({
    Key? key,
    required this.englishWord,
    required this.textTheme,
  }) : super(key: key);

  final EnglishWordViewModel englishWord;
  final TextTheme textTheme;

  @override
  _PhoneticButtonState createState() => _PhoneticButtonState();
}

class _PhoneticButtonState extends State<_PhoneticButton> {
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return phoneticButton();
  }

  ElevatedButton phoneticButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 5.0,
          shadowColor: COLOR_YELLOW,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          primary: COLOR_YELLOW),
      onPressed: phoneticAudio,
      child: _phoneticText(),
    );
  }

  void phoneticAudio() async {
    if (widget.englishWord.audio!.isNotEmpty) {
      await player.setUrl("https://${widget.englishWord.audio!}");
      player.play();
    }
  }

  Text _phoneticText() {
    return Text(
      "/ ${widget.englishWord.phonetic} /",
      style: widget.textTheme.bodyText1!
          .apply(color: COLOR_GREEN, fontWeightDelta: 3),
    );
  }
}
