import 'dart:io';

import 'package:domain/domain.dart';
import 'package:source/source.dart';

class GitlabSource extends NetworkSource {
  @override
  final GitService service = GitService.gitlab;

  @override
  final HttpClient client = HttpClient(
    baseUrl: 'https://gitlab.com/api/v4',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
}
