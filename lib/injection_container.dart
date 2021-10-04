import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/oromo_word_page/get_english_translations.dart';
import 'core/network/network_info.dart';
import 'core/presentation/util/input_validator.dart';
import 'features/english_oromo_dictionary/data/datasources/english_oromo_dictionary_remote_data_source.dart';
import 'features/english_oromo_dictionary/data/repositories/english_oromo_dictionary_repository_impl.dart';
import 'features/english_oromo_dictionary/domain/repositories/english_oromo_dictionary_repository.dart';
import 'features/english_oromo_dictionary/domain/usecases/get_english_word_list.dart';
import 'features/english_oromo_dictionary/domain/usecases/get_oromo_word_list.dart';
import 'features/english_oromo_dictionary/presentation/bloc/english_oromo_dictionary_bloc.dart';
import 'package:http/http.dart' as http;

//Service Locator
final sl = GetIt.instance;

void init() {
  //! Features - EnglishOromoDictionary
  // BLoC
  sl.registerFactory(
    () => EnglishOromoDictionaryBloc(
      getEnglishWordList: sl(),
      getOromoWordList: sl(),
      getEnglishTranslations: sl(),
      inputValidator: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetEnglishWordList(sl()));
  sl.registerLazySingleton(() => GetOromoWordList(sl()));
  sl.registerLazySingleton(() => GetEnglishTranslations(sl()));

  // Repository
  sl.registerLazySingleton<EnglishOromoDictionaryRepository>(
    () => EnglishOromoDictionaryRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<EnglishOromoDictionaryRemoteDataSource>(
      () => EnglishOromoDictionaryRemoteDataSourceImpl(client: sl()));
  //! Core
  sl.registerLazySingleton(() => InputValidator());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
