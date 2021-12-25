import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/bloc/navigation/bloc.dart';
import 'package:spacex/helper/app_font.dart';

class SBottomNavigationBar extends StatelessWidget {
  const SBottomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageindex = 0;
    final NavigationBloc bloc = BlocProvider.of<NavigationBloc>(context);
    final theme = Theme.of(context);
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is SelectPageIndex) {
          pageindex = state.index;
        }
        return BottomNavigationBar(
          elevation: 10,
          unselectedIconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          onTap: (index) {
            bloc.add(IndexSelected(index));
          },
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: pageindex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.assistant_photo_rounded), label: "Launch"),
            BottomNavigationBarItem(icon: Icon(AppFont.rocket), label: "Rocket"),
            BottomNavigationBarItem(icon: Icon(AppFont.rocketdragon), label: "Dragon"),
            BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: "Crew"),
            BottomNavigationBarItem(icon: Icon(Icons.whatshot_sharp), label: "Roadster"),
          ],
        );
      },
    );
  }
}
