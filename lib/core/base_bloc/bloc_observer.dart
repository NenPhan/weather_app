// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver extends BlocObserver {
  var noNeedLogBlocs = [];
  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   print('BLOC onEvent: |${bloc.runtimeType}| - <$event>');
  //   super.onEvent(bloc, event);
  // }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (noNeedLogBlocs.contains(bloc.runtimeType.toString()) == false) {
      print(
          'BLOC onTransition |${bloc.runtimeType}| ${transition.event} [${transition.currentState} => ${transition.nextState}]');
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('BLOC ERROR: ${bloc.runtimeType} - $error');
    super.onError(bloc, error, stackTrace);
  }
}
