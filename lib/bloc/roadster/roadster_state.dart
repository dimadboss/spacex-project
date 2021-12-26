import 'package:equatable/equatable.dart';
import 'package:spacex_api/models/roadster.dart';

abstract class RoadsterState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadingRoadster extends RoadsterState {}

class LoadedState extends RoadsterState {
  final Roadster model;

  LoadedState(this.model);
  @override
  List<Object> get props => [];
}

class ErrorRoadsterState extends RoadsterState {
  final String error;

  ErrorRoadsterState(this.error);
}
class NoConnectionDragonState extends RoadsterState {
  final String errorMessage;

  NoConnectionDragonState(this.errorMessage);

  @override
  String toString() => 'ErrorLaunchState';
}