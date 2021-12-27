import 'package:equatable/equatable.dart';
import 'package:spacex_api/models/crew.dart';

abstract class CoreState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadingCore extends CoreState {}

class LoadedState extends CoreState {
  final List<Crew> list;

  LoadedState(this.list);

  @override
  List<Object> get props => [];
}

class ErrorCoreState extends CoreState {
  final String errorMessage;

  ErrorCoreState(int version, this.errorMessage);

  @override
  String toString() => 'ErrorCoreState';
}

class NoConnectionDragonState extends CoreState {
  final String errorMessage;

  NoConnectionDragonState(this.errorMessage);

  @override
  String toString() => 'ErrorLaunchState';
}
