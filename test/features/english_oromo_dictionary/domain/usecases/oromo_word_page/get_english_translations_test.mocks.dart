// Mocks generated by Mockito 5.0.15 from annotations
// in oromo_dictionary/test/features/english_oromo_dictionary/domain/usecases/oromo_word_page/get_english_translations_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:oromo_dictionary/core/error/failures.dart' as _i5;
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/repositories/english_oromo_dictionary_repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [EnglishOromoDictionaryRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockEnglishOromoDictionaryRepository extends _i1.Mock
    implements _i3.EnglishOromoDictionaryRepository {
  MockEnglishOromoDictionaryRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<dynamic>>> getWordList(
          {String? desiredList, String? searchTerm}) =>
      (super.noSuchMethod(
              Invocation.method(#getWordList, [],
                  {#desiredList: desiredList, #searchTerm: searchTerm}),
              returnValue: Future<_i2.Either<_i5.Failure, List<dynamic>>>.value(
                  _FakeEither_0<_i5.Failure, List<dynamic>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<dynamic>>>);
  @override
  String toString() => super.toString();
}