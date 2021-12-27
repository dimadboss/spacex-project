import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:spacex/bloc/crew/index.dart';

class CrewBloc extends Bloc<CoreEvent, CoreState> {
  // todo: check singleton for logic in project
  static final CrewBloc _coreBlocSingleton = CrewBloc._internal();

  factory CrewBloc() {
    return _coreBlocSingleton;
  }

  CrewBloc._internal();

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  CoreState get initialState => LoadingCore();

  @override
  Stream<CoreState> mapEventToState(
    CoreEvent event,
  ) async* {
    try {
      if (event is LaunchInitial) {
        yield* event.loadAsync(currentState: state, bloc: this);
      }
    } on SocketException catch (_, stackTrace) {
      developer.log('$_', name: 'CorehBloc', error: _, stackTrace: stackTrace);
      yield NoConnectionDragonState(_.message);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'CoreBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
