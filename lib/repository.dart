import 'dart:convert';

import 'package:gitspace/account.dart';
import 'package:http/http.dart';

class Repository {
  final String id;
  final String name;
  final String? description;
  final String owner;
  final bool public;
  final String role;
  final String defaultBranch;
  final int stars;
  final int? openIssues;

  Repository({
    required this.id,
    required this.name,
    required this.description,
    required this.owner,
    required this.public,
    required this.role,
    required this.defaultBranch,
    this.stars = 0,
    this.openIssues,
  });
}

Future<List<Repository>> fetchRepositories(Account account) async {
  final uri = Uri.parse('https://api.github.com/user/repos?per_page=100');
  final token = account.token;
  final response = await get(uri, headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final repos = jsonDecode(response.body) as List;
    return repos.map((repo) {
      return Repository(
        id: repo['id'].toString(),
        name: repo['name'],
        description: repo['description'],
        owner: repo['owner']['login'],
        public: repo['private'] == false,
        role: repo['permissions']['admin'] ? 'Owner' : 'Developer',
        defaultBranch: repo['default_branch'],
        stars: repo['stargazers_count'],
        openIssues: repo['open_issues_count'],
      );
    }).toList();
  } else {
    throw Exception('Failed to fetch repositories');
  }
}
