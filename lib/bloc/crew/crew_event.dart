import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:spacex/bloc/crew/index.dart';
import 'package:spacex/resources/repository/crew_repository.dart';
import 'package:spacex/resources/service/api_gatway.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CoreEvent extends Equatable {
  @override
  List<Object> get props => [];

  Stream<CoreState> loadAsync({CoreState currentState, CrewBloc bloc});

  final CrewRepository _crewRepository = CrewRepository(apiGateway: GetIt.instance<ApiGateway>());
}

class LaunchInitial extends CoreEvent {
  @override
  String toString() => 'LoadCoreEvent';

  LaunchInitial();

  @override
  Stream<CoreState> loadAsync({CoreState currentState, CrewBloc bloc}) async* {
    try {
      if (currentState is LoadedState) {
        return;
      }
      yield LoadingCore();
      await Future.delayed(Duration(seconds: 1));
      final list = await _crewRepository.fetchAllCrews();
      yield LoadedState(list);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadCoreEvent', error: _, stackTrace: stackTrace);
      yield ErrorCoreState(0, _?.toString());
    }
  }
}
