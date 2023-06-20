class User {
  late String username;
  late String email;
  late int following;
  late int follower;
  late int public_repo;
  late String joined_date;


  User({
    required this.username,
    required this.email,
    required this.following,
    required this.follower,
    required this.public_repo,
    required this.joined_date

  });

}