import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/bloc/launches/bloc.dart';
import 'package:spacex/bloc/navigation/navigation_bloc.dart';
import 'package:spacex/resources/repository/crew_repository.dart';
import 'package:spacex/resources/repository/launch_repository.dart';
import 'package:spacex/resources/repository/rocket_repository.dart';
import 'package:spacex/resources/service/api_gatway.dart';
import 'package:spacex/ui/theme/custom_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SpaceApp extends StatefulWidget {
  final Widget home;

  const SpaceApp({
    Key key,
    @required this.home,
  }) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _AppState state = context.findAncestorStateOfType<_AppState>();
    state.setLocale(newLocale);
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<SpaceApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  Locale _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      onGenerateTitle: (BuildContext context) => "",
      locale: _locale,
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
      ],
      theme: CustomTheme.of(context).copyWith(textTheme: GoogleFonts.montserratTextTheme()),
      // home: widget.home,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
            create: (BuildContext context) => NavigationBloc(),
          ),
          BlocProvider<LaunchBloc>(
            create: (BuildContext context) => LaunchBloc(GetIt.instance<LaunchRepository>())..add(LaunchInitial()),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<CrewRepository>(
              create: (_) => CrewRepository(apiGateway: GetIt.instance<ApiGateway>()),
            ),
            ChangeNotifierProvider<LaunchRepository>(
              create: (_) => LaunchRepository(apiGateway: GetIt.instance<ApiGateway>()),
            ),
            ChangeNotifierProvider<RocketRepository>(
              create: (_) => RocketRepository(apiGateway: GetIt.instance<ApiGateway>()),
            )
          ],
          child: widget.home,
        ),
      ),
    );
  }
}
