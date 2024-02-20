// user_data.dart

Map<String, User> users = {
  '19991124': User(
    Username: 'Emeli EDE',
    ID: '19991124',
    Level: '0',
    Verify: true,
  ),
};

class User {
  final String Username;
  final String ID;
  final String Level;
  bool Verify;

  User({
    required this.Username,
    required this.ID,
    required this.Level,
    required this.Verify,
  });
}