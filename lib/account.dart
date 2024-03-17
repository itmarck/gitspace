class Account {
  final String name;
  final String email;
  final String? avatar;

  Account({
    required this.name,
    required this.email,
    this.avatar,
  });
}
