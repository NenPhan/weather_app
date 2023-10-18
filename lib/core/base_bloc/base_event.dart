import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  @override
  List<dynamic> get props => [];
}

class InitDataEvent extends BaseEvent {
  final dynamic param;

  InitDataEvent({this.param, this.onDone});
  final Function()? onDone;

  @override
  List<dynamic> get props => [param];

  @override
  String toString() => 'InitDataEvent $param';
}

class ErrorEvent extends BaseEvent {
  final dynamic error;

  ErrorEvent({this.error});

  @override
  List<dynamic> get props => [error];

  @override
  String toString() => 'ErrorEvent ${error.toString()}';
}

class RefreshDataEvent extends BaseEvent {
  final dynamic param;

  RefreshDataEvent({this.param});

  @override
  List<dynamic> get props => [param];

  @override
  String toString() => 'FetchDataEvent $param';
}

class LoadMoreEvent extends BaseEvent {
  final dynamic param;
  LoadMoreEvent({this.param});
  @override
  List<dynamic> get props => [param];
  @override
  String toString() => 'LoadMoreEvent';
}

class UpdateDataEvent extends BaseEvent {
  final dynamic param;
  UpdateDataEvent({this.param});
  @override
  List<dynamic> get props => [param];
  @override
  String toString() => 'UpdateDataEvent';
}
