import 'dart:io';

import 'package:domain/domain.dart';
import 'package:source/source.dart';

class GithubSource extends NetworkSource {
  @override
  final GitService service = GitService.github;

  @override
  final HttpClient client = HttpClient(
    baseUrl: 'https://api.github.com',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
}
