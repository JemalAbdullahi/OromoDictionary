import 'package:equatable/equatable.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class Empty extends PageState {
  @override
  List<Object?> get props => [];
}

class Loading extends PageState {
  @override
  List<Object?> get props => [];
}

class Error extends  PageState {
  final String message;

  Error({required this.message});
  @override
  List<Object> get props => [message];
}