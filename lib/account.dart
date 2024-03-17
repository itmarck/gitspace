class Account {
  final String name;
  final String email;
  final String token;
  final String? avatar;

  Account({
    required this.name,
    required this.email,
    required this.token,
    this.avatar,
  });
}
