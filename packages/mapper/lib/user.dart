import 'package:domain/domain.dart';
import 'package:mapper/src/mapper.dart';
import 'package:types/document.dart';

class GitlabUserMapper extends Mapper<User> {
  @override
  User from(Document document) {
    return User(
      id: document['id'] as int,
      name: document['name'],
      username: document['username'],
      avatar: document['avatar_url'],
      state: document['state'],
    );
  }

  @override
  Document to(User object) {
    return {
      'id': object.id,
      'name': object.name,
      'username': object.username,
      'avatar_url': object.avatar,
      'state': object.state,
    };
  }
}

class GithubUserMapper extends Mapper<User> {
  @override
  User from(Document document) {
    return User(
      id: document['id'] as int,
      name: document['name'],
      username: document['login'],
      avatar: document['avatar_url'],
      state: 'active',
    );
  }

  @override
  Document to(User object) {
    return {
      'id': object.id,
      'name': object.name,
      'login': object.username,
      'avatar_url': object.avatar,
      'state': object.state,
    };
  }
}
