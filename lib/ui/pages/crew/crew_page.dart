import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/bloc/crew/index.dart';
import 'package:spacex/ui/pages/common/error_page.dart';
import 'package:spacex/ui/pages/common/no_connection.dart';
import 'package:spacex/ui/pages/common/no_content.dart';
import 'package:spacex/ui/pages/crew/crew_screen.dart';

class CrewPage extends StatefulWidget {
  static const String routeName = '/crew';

  @override
  _CrewPageState createState() => _CrewPageState();
}

class _CrewPageState extends State<CrewPage> {
  final _crewBloc = CrewBloc();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrewBloc, CoreState>(
      bloc: _crewBloc,
      builder: (
        BuildContext context,
        CoreState currentState,
      ) {
        if (currentState is LoadingCore) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (currentState is ErrorCoreState) {
          return ErrorPage(
            dsiplayReloadButton: true,
            message: currentState.errorMessage,
            onReload: _load,
          );
        } else if (currentState is LoadedState) {
          if (currentState.list == null) return NoContent();
          return CrewScreen(list: currentState.list);
        } else if (currentState is NoConnectionDragonState) {
          return NoInternetConnection(
            message: currentState.errorMessage,
            onReload: () {
              BlocProvider.of<CrewBloc>(context).add(LaunchInitial());
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _load() {
    _crewBloc.add(LaunchInitial());
  }
}
