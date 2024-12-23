class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? image;
  final String lastSean;
  UserEntity({
    required this.id,
    required this.lastSean,
    required this.name,
    required this.email,
    this.image,
  });
}
