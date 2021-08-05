class OromoTranslation {
  late final int id;
  late final int phraseID;
  late final String translation;

  OromoTranslation(this.id, this.phraseID, this.translation);

  factory OromoTranslation.fromJson(Map<String, dynamic> parsedJson) {
    return OromoTranslation(
      parsedJson['id'],
      parsedJson['phrase_id'],
      parsedJson['example'],
    );
  }

  @override
  String toString() {
    return this.translation;
  }
}
