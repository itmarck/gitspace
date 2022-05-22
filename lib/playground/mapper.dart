import 'repository.dart';

abstract class Mapper<T> {
  T from(Map<String, dynamic> body);
}

class ListMapper<T> {
  final Mapper<T> mapper;

  ListMapper(this.mapper);

  List<T> from(List<dynamic> body) {
    return [
      for (final item in body) mapper.from(item),
    ];
  }
}

class GitlabProjectMapper implements Mapper<Project> {
  @override
  Project from(Map<String, dynamic> body) {
    return Project(
      id: body['id'] as int,
      name: body['name'],
      description: body['description'],
    );
  }
}

class GithubProjectMapper implements Mapper<Project> {
  @override
  Project from(Map<String, dynamic> body) {
    return Project(
      id: body['id'] as int,
      name: body['name'],
      description: body['description'],
    );
  }
}

class GitlabUserMapper implements Mapper<User> {
  @override
  User from(Map<String, dynamic> body) {
    return User(
      id: body['id'] as int,
      name: body['name'],
      username: body['username'],
    );
  }
}

class GithubUserMapper implements Mapper<User> {
  @override
  User from(Map<String, dynamic> body) {
    return User(
      id: body['id'] as int,
      name: body['name'],
      username: body['login'],
    );
  }
}
