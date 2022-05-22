import 'package:arcane/src/theme/colors.dart';
import 'package:flutter/material.dart';

class Arcane extends StatelessWidget {
  const Arcane({
    Key? key,
    required this.delegate,
  }) : super(key: key);

  final RouterDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: dark3,
        ),
      ),
      home: Scaffold(
        backgroundColor: dark1,
        body: Router(
          routerDelegate: delegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
