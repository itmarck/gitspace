import 'package:domain/domain.dart';

class Note {
  final int id;
  final String body;
  final User author;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool system;
  final bool confidential;
  final bool resolvable;
  final bool? resolved;
  final User? resolvedBy;
  final String? type;

  Note({
    required this.id,
    required this.body,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
    this.system = false,
    this.confidential = false,
    this.resolvable = false,
    this.resolved,
    this.resolvedBy,
    this.type,
  });
}
