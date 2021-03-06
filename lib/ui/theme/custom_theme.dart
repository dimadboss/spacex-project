import 'package:flutter/material.dart';
import 'package:spacex/ui/theme/app_theme_provider.dart';
import 'package:spacex/ui/theme/theme.dart';

class CustomTheme extends StatefulWidget {
  final Widget child;
  final ThemeType initialThemeKey;

  const CustomTheme({
    Key key,
    this.initialThemeKey,
    @required this.child,
  }) : super(key: key);

  @override
  CustomThemeState createState() => new CustomThemeState();

  static ThemeData of(BuildContext context) {
    ThemeProvider inherited = (context.dependOnInheritedWidgetOfExactType<ThemeProvider>());
    return inherited.data.theme;
  }

  static CustomThemeState instanceOf(BuildContext context) {
    ThemeProvider inherited = (context.dependOnInheritedWidgetOfExactType<ThemeProvider>());
    return inherited.data;
  }
}

class CustomThemeState extends State<CustomTheme> {
  ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  void initState() {
    _theme = AppTheme.getThemeFromKey(widget.initialThemeKey);
    super.initState();
  }

  void changeTheme(ThemeType themeKey) {
    setState(() {
      _theme = AppTheme.getThemeFromKey(themeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      data: this,
      child: widget.child,
    );
  }
}
