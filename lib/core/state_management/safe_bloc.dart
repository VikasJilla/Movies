import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_event.dart';
import 'cubit_state.dart';

abstract class SafeBloc extends Bloc<BlocEvent, CubitState> {
  SafeBloc(CubitState initialState) : super(initialState);

  @override
  void emit(CubitState state) {
    // ignore: invalid_use_of_visible_for_testing_member
    if (!isClosed) super.emit(state);
  }
}
