class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? profileImage;
  final String? phone;
  final String role; // 'user' or 'admin'
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.profileImage,
    this.phone,
    required this.role,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'phone': phone,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profileImage'],
      phone: map['phone'],
      role: map['role'] ?? 'user',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }

  UserModel copyWith({
    String? name,
    String? profileImage,
    String? phone,
    String? role,
  }) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      email: email,
      profileImage: profileImage ?? this.profileImage,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      createdAt: createdAt,
    );
  }
}
