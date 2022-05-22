import 'package:flutter/material.dart';
import 'package:gitspace/screens/access_screen.dart';

class ManagerPage extends Page {
  const ManagerPage() : super();

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AccessScreen();
      },
    );
  }
}
