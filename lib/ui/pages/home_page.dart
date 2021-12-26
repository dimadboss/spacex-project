import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/bloc/navigation/bloc.dart';
import 'package:spacex/ui/pages/crew/crew_page.dart';
import 'package:spacex/ui/pages/dragon/dragon_page.dart';
import 'package:spacex/ui/pages/launch/all_launch.dart';
import 'package:spacex/ui/pages/roadster/roadster_page.dart';
import 'package:spacex/ui/pages/rockets/rocket_page.dart';
import 'package:spacex/ui/widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageindex = 0;
  bool isDarkTheme = true;

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return AllLaunch();
      case 1:
        return RocketPage();
      case 2:
        return DragonPage();
      case 3:
        return CrewPage();
      case 4:
        return RoadsterPage();
      default:
        return Center(child: Text("Page $pageindex"));
    }
  }

  String _getPageName(int index) {
    switch (index) {
      case 0:
        return "Launch";
      case 1:
        return "Rockets";
      case 2:
        return "Dragon";
      case 3:
        return "Crews";
      case 4:
        return "Roadster";

      default:
        return "Empty";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is SelectPageIndex) {
              pageindex = state.index;
            }
            return Title(
              color: Colors.black,
              child: Text(_getPageName(pageindex)),
            );
          },
        ),
      ),
      bottomNavigationBar: SBottomNavigationBar(),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is SelectPageIndex) {
            pageindex = state.index;
          }
          return getPage(pageindex);
        },
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final IconData icon;
  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Share', icon: Icons.directions_car),
  const Choice(title: 'About', icon: Icons.directions_railway),
  const Choice(title: 'License', icon: Icons.directions_railway),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              choice.title,
              style: TextStyle(fontSize: 20, color: theme.colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
