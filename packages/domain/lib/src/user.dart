class User {
  final int id;
  final String name;
  final String username;
  final String avatar;
  final String state;
  final String? email;
  final String? location;
  final int followers;
  final int following;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
    required this.state,
    this.email,
    this.location,
    this.followers = 0,
    this.following = 0,
  });
}
