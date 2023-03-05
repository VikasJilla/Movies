import 'package:equatable/equatable.dart';

String get time => DateTime.now().toString();

abstract class CubitState extends Equatable {
  const CubitState();
}

class CubitInitialState extends CubitState {
  const CubitInitialState();

  @override
  List<Object> get props => [];
}

class CubitLoadingState extends CubitState {
  const CubitLoadingState();

  @override
  List<Object> get props => [];
}

class CubitSuccessState extends CubitState {
  final dynamic result;

  const CubitSuccessState(this.result);

  @override
  List<Object> get props => [time];

  CubitSuccessState copyWith({dynamic result}) {
    return CubitSuccessState(result ?? this.result);
  }
}

class CubitSearchSuccessState extends CubitState {
  final dynamic result;

  const CubitSearchSuccessState(this.result);

  @override
  List<Object> get props => [time];

  CubitSearchSuccessState copyWith({dynamic result}) {
    return CubitSearchSuccessState(result ?? this.result);
  }
}

class CubitFailureState extends CubitState {
  final dynamic error;

  const CubitFailureState(this.error);

  @override
  List<Object> get props => [error, time];
}

class CubitSearchFailureState extends CubitState {
  final String error;

  const CubitSearchFailureState(this.error);

  @override
  List<Object> get props => [error, time];
}

class CubitUpdatingState extends CubitState {
  const CubitUpdatingState();

  @override
  List<Object> get props => [];
}

class CubitLoadingMoreState extends CubitState {
  const CubitLoadingMoreState();
  @override
  List<Object> get props => [];
}

class CubitNewUpdateState extends CubitState {
  final DateTime dateTime = DateTime.now();

  CubitNewUpdateState();
  @override
  List<Object?> get props => [dateTime];
}
