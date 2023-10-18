import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/base_bloc/base.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  abstract Function(dynamic data) future;

  BaseBloc() : super(const InitialState()) {
    on<InitDataEvent>((event, emit) {
      emit(LoadingState());
      future(event.param);
      emit(const DataLoadedState());
    });
    // on<ErrorEvent>((event, emit) {
    //   emit(ErrorState(message: event.error));
    // });
  }
}

class A extends BaseBloc {
  A() {
    on<LoadMoreEvent>((event, emit) {
      var currentState = state;
      if (!_hasReachedMax(currentState)) {
        emit(LoadMoreSuccessState());
      }
    });
  }

  @override
  Function(dynamic data) future = (data) {};
}

bool _hasReachedMax(BaseState state) => state is LoadMoreSuccessState && state.hasReachedMax!;
