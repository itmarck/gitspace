import 'package:flutter/material.dart';
import 'package:gitspace/screens/project_screen.dart';

class ProjectPage extends Page {
  const ProjectPage() : super();

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const ProjectScreen();
      },
    );
  }
}
