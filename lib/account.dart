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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'token': token,
      'avatar': avatar,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      avatar: map['avatar'],
    );
  }
}
