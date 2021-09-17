import '../../domain/entities/english_word.dart';
import '../../domain/entities/oromo_translation.dart';

abstract class EnglishOromoDictionaryLocalDataSource {
  /// Gets the cached List[OromoTranslationModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<OromoTranslation>> getLastOromoWordList();

  /// Gets the cached List[EnglishWordModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<EnglishWord>> getLastEnglishWordList();

  Future<void> cacheOromoWordList(List<OromoTranslation> oromoWordListToCache);
  Future<void> cacheEnglishWordList(List<EnglishWord> englishWordListToCache);
}
