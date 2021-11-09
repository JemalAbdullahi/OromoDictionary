# Oromo Dictionary
This app was developed to translate English words to its Oromo equivalent and vice versa.

## Features

## Current Plugins

## Project Structure
oromo_dictionary
├─ assets
│  ├─ images
│  │  └─ Oddaa.png
│  └─ Oddaa.svg
├─ lib
│  ├─ app.dart
│  ├─ core
│  │  ├─ error
│  │  │  ├─ exceptions.dart
│  │  │  └─ failures.dart
│  │  ├─ network
│  │  │  └─ network_info.dart
│  │  ├─ presentation
│  │  │  └─ util
│  │  │     ├─ constants.dart
│  │  │     ├─ input_validator.dart
│  │  │     └─ widget_functions.dart
│  │  └─ usecases
│  │     └─ usecase.dart
│  ├─ features
│  │  └─ english_oromo_dictionary
│  │     ├─ data
│  │     │  ├─ datasources
│  │     │  │  ├─ english_definition_remote_data_source.dart
│  │     │  │  └─ english_oromo_dictionary_remote_data_source.dart
│  │     │  ├─ models
│  │     │  │  ├─ english_dictionary_def_model.dart
│  │     │  │  ├─ english_word_model.dart
│  │     │  │  ├─ grammatical_form_model.dart
│  │     │  │  ├─ oromo_translation_model.dart
│  │     │  │  └─ phrase_model.dart
│  │     │  └─ repositories
│  │     │     ├─ english_definition_repository_impl.dart
│  │     │     └─ english_oromo_dictionary_repository_impl.dart
│  │     ├─ domain
│  │     │  ├─ entities
│  │     │  │  ├─ english_dictionary_def.dart
│  │     │  │  ├─ english_word.dart
│  │     │  │  ├─ grammatical_form.dart
│  │     │  │  ├─ oromo_translation.dart
│  │     │  │  └─ phrase.dart
│  │     │  ├─ repositories
│  │     │  │  ├─ english_definition_repository.dart
│  │     │  │  └─ english_oromo_dictionary_repository.dart
│  │     │  └─ usecases
│  │     │     ├─ english_word_page
│  │     │     │  └─ get_english_definition.dart
│  │     │     ├─ oromo_word_page
│  │     │     │  ├─ get_english_translations.dart
│  │     │     │  └─ get_oromo_phonetic_breakdown.dart
│  │     │     └─ search_page
│  │     │        ├─ get_english_word_list.dart
│  │     │        └─ get_oromo_word_list.dart
│  │     └─ presentation
│  │        ├─ bloc
│  │        │  ├─ bloc_imports.dart
│  │        │  ├─ english_translation_page_bloc
│  │        │  │  ├─ bloc.dart
│  │        │  │  ├─ english_translation_page_bloc.dart
│  │        │  │  ├─ english_translation_page_event.dart
│  │        │  │  └─ english_translation_page_state.dart
│  │        │  ├─ oromo_translation_page_bloc
│  │        │  │  ├─ bloc.dart
│  │        │  │  ├─ oromo_translation_page_bloc.dart
│  │        │  │  ├─ oromo_translation_page_event.dart
│  │        │  │  └─ oromo_translation_page_state.dart
│  │        │  ├─ page_states.dart
│  │        │  └─ search_page_bloc
│  │        │     ├─ bloc.dart
│  │        │     ├─ search_page_bloc.dart
│  │        │     ├─ search_page_event.dart
│  │        │     └─ search_page_state.dart
│  │        ├─ pages
│  │        │  ├─ english_to_oromo_translation_page.dart
│  │        │  ├─ oromo_alphabet_page.dart
│  │        │  ├─ oromo_to_english_translation_page.dart
│  │        │  └─ search_page.dart
│  │        └─ widgets
│  │           ├─ english_to_oromo_translation_page_widgets
│  │           │  ├─ definition_and_translation_listview.dart
│  │           │  ├─ phrase_translation_container.dart
│  │           │  ├─ selected_part_of_speech.dart
│  │           │  └─ word_container.dart
│  │           ├─ loading_widget.dart
│  │           ├─ oromo_alphabet_page_widgets
│  │           └─ search_page_widgets
│  │              ├─ app_header.dart
│  │              ├─ english_search_results_display.dart
│  │              ├─ language_selector.dart
│  │              ├─ oromo_search_results_display.dart
│  │              ├─ search_bar.dart
│  │              ├─ search_page_app_bar.dart
│  │              ├─ search_page_widgets.dart
│  │              └─ search_results_display.dart
│  ├─ injection_container.dart
│  ├─ main.dart
├─ pubspec.lock
├─ pubspec.yaml
├─ README.md
├─ test
│  ├─ core
│  │  ├─ network
│  │  │  ├─ network_info_test.dart
│  │  │  └─ network_info_test.mocks.dart
│  │  └─ presentation
│  │     └─ util
│  │        └─ input_validator_test.dart
│  ├─ features
│  │  └─ english_oromo_dictionary
│  │     ├─ data
│  │     │  ├─ datasources
│  │     │  │  ├─ english_oromo_dictionary_remote_data_source_test.dart
│  │     │  │  └─ english_oromo_dictionary_remote_data_source_test.mocks.dart
│  │     │  ├─ models
│  │     │  │  ├─ english_dictionary_def_model_test.dart
│  │     │  │  ├─ english_word_model_test.dart
│  │     │  │  ├─ grammatical_form_model_test.dart
│  │     │  │  ├─ oromo_translation_model_test.dart
│  │     │  │  └─ phrase_model_test.dart
│  │     │  └─ repositories
│  │     │     ├─ english_oromo_dictionary_repository_impl_test.dart
│  │     │     └─ english_oromo_dictionary_repository_impl_test.mocks.dart
│  │     ├─ domain
│  │     │  ├─ entities
│  │     │  ├─ repositories
│  │     │  └─ usecases
│  │     │     ├─ get_english_word_list_test.dart
│  │     │     ├─ get_english_word_list_test.mocks.dart
│  │     │     ├─ get_oromo_word_list_test.dart
│  │     │     ├─ get_oromo_word_list_test.mocks.dart
│  │     │     └─ oromo_word_page
│  │     │        ├─ get_english_translations_test.dart
│  │     │        ├─ get_english_translations_test.mocks.dart
│  │     │        └─ get_oromo_phonetic_breakdown_test.dart
│  │     └─ presentation
│  │        ├─ bloc
│  │        │  ├─ oromo_translation_page_bloc
│  │        │  │  ├─ oromo_translation_page_bloc_test.dart
│  │        │  │  └─ oromo_translation_page_bloc_test.mocks.dart
│  │        │  └─ search_page_bloc
│  │        │     ├─ search_page_bloc_test.dart
│  │        │     └─ search_page_bloc_test.mocks.dart
│  │        ├─ pages
│  │        └─ widgets
│  ├─ fixtures
│  │  ├─ fixture_reader.dart
│  │  ├─ oromo_word_page
│  │  │  ├─ english_translations.json
│  │  │  └─ english_word.json
│  │  └─ search_page
│  │     ├─ english_dictionary_def.json
│  │     ├─ english_word.json
│  │     ├─ english_word_list.json
│  │     ├─ grammatical_form.json
│  │     ├─ oromo_translation.json
│  │     ├─ oromo_translation_list.json
│  │     └─ phrase.json
│  └─ README.md
└─ web
   ├─ favicon.png
   ├─ icons
   │  ├─ Icon-192.png
   │  └─ Icon-512.png
   ├─ index.html
   └─ manifest.json