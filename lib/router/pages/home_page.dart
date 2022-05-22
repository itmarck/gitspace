import 'package:flutter/material.dart';
import 'package:gitspace/screens/home_screen.dart';

class HomePage extends Page {
  const HomePage() : super();

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const HomeScreen();
      },
    );
  }
}
