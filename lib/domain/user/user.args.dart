class UserFindArgs {
  UserFindArgs({
    required this.id,
  });

  final int id;
}

class UserUpdateArgs {
  UserUpdateArgs({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}
