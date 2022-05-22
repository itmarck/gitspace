import 'dart:convert';

import 'package:domain/domain.dart';

import '../common/manager.dart';

Future<List<Project>> fetchMyProjects() async {
  final response = await Manager(
    method: Method.get,
    path: '/projects/?owned=true',
  ).execute();

  return json.decode(response.body);
}
