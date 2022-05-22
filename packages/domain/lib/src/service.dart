enum GitService {
  gitlab,
  github,
}

extension GitServiceName on GitService {
  String get name {
    switch (this) {
      case GitService.gitlab:
        return 'GitLab';
      case GitService.github:
        return 'GitHub';
    }
  }
}
