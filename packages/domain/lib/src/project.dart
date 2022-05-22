class Project {
  final int id;
  final String name;
  final String path;
  final String pathWithNamespace;
  final String defaultBranch;
  final int forkCount;
  final int starCount;

  Project({
    required this.id,
    required this.name,
    required this.path,
    required this.pathWithNamespace,
    required this.defaultBranch,
    this.forkCount = 0,
    this.starCount = 0,
  });
}
