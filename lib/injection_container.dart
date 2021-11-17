import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'core/presentation/util/input_validator.dart';
import 'features/english_oromo_dictionary/data/datasources/english_oromo_dictionary_remote_data_source.dart';
import 'features/english_oromo_dictionary/data/datasources/english_word_remote_data_source.dart';
import 'features/english_oromo_dictionary/data/repositories/english_oromo_dictionary_repository_impl.dart';
import 'features/english_oromo_dictionary/data/repositories/english_word_repository_impl.dart';
import 'features/english_oromo_dictionary/domain/repositories/english_oromo_dictionary_repository.dart';
import 'features/english_oromo_dictionary/domain/repositories/english_word_repository.dart';
import 'features/english_oromo_dictionary/domain/usecases/english_word_page/get_english_definition.dart';
import 'features/english_oromo_dictionary/domain/usecases/oromo_word_page/get_english_translations.dart';
import 'features/english_oromo_dictionary/domain/usecases/search_page/get_english_word_list.dart';
import 'features/english_oromo_dictionary/domain/usecases/search_page/get_oromo_word_list.dart';
import 'features/english_oromo_dictionary/presentation/bloc/english_translation_page_bloc/english_translation_page_bloc.dart';
import 'features/english_oromo_dictionary/presentation/bloc/oromo_translation_page_bloc/bloc.dart';
import 'features/english_oromo_dictionary/presentation/bloc/search_page_bloc/search_page_bloc.dart';

//Service Locator
final sl = GetIt.instance;

void init() {
  //! Features - EnglishOromoDictionary
  // BLoC
  sl.registerFactory(
    () => SearchPageBloc(
      getEnglishWordList: sl(),
      getOromoWordList: sl(),
      inputValidator: sl(),
    ),
  );

  sl.registerFactory(
    () => OromoTranslationPageBloc(
      getEnglishTranslations: sl(),
      inputValidator: sl(),
    ),
  );

  sl.registerFactory(
      () => EnglishTranslationPageBloc(getEnglishDefinition: sl()));

  // Use Cases
  sl.registerLazySingleton(
      () => GetEnglishWordList(sl<EnglishOromoDictionaryRepository>()));
  sl.registerLazySingleton(
      () => GetOromoWordList(sl<EnglishOromoDictionaryRepository>()));
  sl.registerLazySingleton(
      () => GetEnglishTranslations(sl<EnglishOromoDictionaryRepository>()));
  sl.registerLazySingleton(
      () => GetEnglishWord(sl<EnglishWordRepository>()));

  // Repository
  sl.registerLazySingleton<EnglishOromoDictionaryRepository>(
    () => EnglishOromoDictionaryRepositoryImpl(
      remoteDataSource: sl<EnglishOromoDictionaryRemoteDataSource>(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<EnglishWordRepository>(
    () => EnglishWordRepositoryImpl(
      remoteDataSource: sl<EnglishWordRemoteDataSource>(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<EnglishOromoDictionaryRemoteDataSource>(
    () => EnglishOromoDictionaryRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<EnglishWordRemoteDataSource>(
    () => EnglishWordRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  //! Core
  sl.registerLazySingleton(() => InputValidator());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
