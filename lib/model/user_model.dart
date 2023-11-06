class TurfUser {
  final String id;
  final String name;
  final String email;

  TurfUser({
    required this.id,
    required this.name,
    required this.email,
  });

  factory TurfUser.fromJson(Map<String, dynamic> json) {
    return TurfUser(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'id': id,
    };
  }
}
