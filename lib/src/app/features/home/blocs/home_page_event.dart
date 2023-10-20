import 'package:weather_app/core/base_bloc/base.dart';

class HomePageEvent extends BaseEvent {}

class ChangeDateEvent extends HomePageEvent {
  final int index;

  ChangeDateEvent(this.index);
}
