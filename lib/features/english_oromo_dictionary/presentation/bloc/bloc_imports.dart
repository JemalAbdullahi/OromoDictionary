import '../../../../core/error/failures.dart';

export 'package:bloc/bloc.dart';
export 'package:equatable/equatable.dart';
export 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/bloc/page_states.dart';

export '../../../../../core/presentation/util/input_validator.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid Input - The search term must not be empty.";

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}
