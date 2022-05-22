import 'package:flutter/material.dart';
import 'package:gitspace/screens/request_screen.dart';

class RequestPage extends Page {
  const RequestPage() : super();

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const RequestScreen();
      },
    );
  }
}
