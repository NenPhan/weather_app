import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/base_bloc/base.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  abstract Function(dynamic data) future;

  BaseBloc() : super(const InitialState()) {
    on<InitDataEvent>((event, emit) {
      emit(const LoadingState());
      future(event.param);
      emit(const DataLoadedState());
    });
  }
}
