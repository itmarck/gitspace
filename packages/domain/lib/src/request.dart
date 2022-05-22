import 'user.dart';

class Request {
  final int id;
  final int iid;
  final String title;
  final String description;
  final MergeRequestState state;
  final MergeStatus mergeStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String sourceBranch;
  final String targetBranch;
  final User author;
  final String sha;
  final bool hasConflicts;
  final int upvotes;
  final int downvotes;

  /// Merge request or pull request constructor
  Request({
    required this.id,
    required this.iid,
    required this.title,
    required this.description,
    required this.state,
    required this.mergeStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.sourceBranch,
    required this.targetBranch,
    required this.author,
    required this.sha,
    this.hasConflicts = false,
    this.upvotes = 0,
    this.downvotes = 0,
  });
}

enum MergeRequestState {
  opened,
  merged,
  closed,
}

enum MergeStatus {
  canBeMerged,
  cannotBeMerged,
  hasConflicts,
}
