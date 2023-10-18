import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/base_bloc/base.dart';

class HomePageBloc extends Bloc<BaseEvent, BaseState> {
  HomePageBloc() : super(const InitialState()) {
    on<InitDataEvent>((event, emit) async {
      emit(LoadingState());
      await getRoom();
      emit(const DataLoadedState());
    });
    add(InitDataEvent());
  }

  getRoom() async {}
}
