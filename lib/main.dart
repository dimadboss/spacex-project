import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/app.dart';
import 'package:spacex/app_delegate.dart';
import 'package:spacex/locator.dart';
import 'package:spacex/ui/pages/home_page.dart';
import 'package:spacex/ui/theme/custom_theme.dart';
import 'package:spacex/ui/theme/theme.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  setUpDependency();
  final app = SpaceApp(home: HomePage());
  runApp(
    CustomTheme(
      initialThemeKey: ThemeType.LIGHT,
      child: app,
    ),
  );
}
