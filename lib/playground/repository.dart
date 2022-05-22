import 'package:domain/domain.dart' as domain;

class Project {
  final int id;
  final String name;
  final String description;

  Project({
    required this.id,
    required this.name,
    required this.description,
  });
}

class User {
  final int id;
  final String name;
  final String username;

  User({
    required this.id,
    required this.name,
    required this.username,
  });
}

abstract class ProjectRepository {
  Future<List<Project>> getMyProjects();
}

abstract class AccountRepository {
  Future<List<domain.Account>> getAccounts();
  Future<domain.Account?> addAccount(String token);
}
