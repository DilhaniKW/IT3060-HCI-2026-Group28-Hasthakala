enum UserRole { buyer, artisan, admin }

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? phoneNumber;
  final String? profileImageUrl;
  final UserRole role;
  final String? bio; // For artisans
  final String? district; // Sri Lankan District (e.g. Kandy, Galle)
  final bool isFamilyAssisted; // Support for elder artisans
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.phoneNumber,
    this.profileImageUrl,
    required this.role,
    this.bio,
    this.district,
    this.isFamilyAssisted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'role': role.name,
      'bio': bio,
      'district': district,
      'isFamilyAssisted': isFamilyAssisted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      uid: docId,
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      phoneNumber: map['phoneNumber'],
      profileImageUrl: map['profileImageUrl'],
      role: UserRole.values.firstWhere(
        (r) => r.name == map['role'],
        orElse: () => UserRole.buyer,
      ),
      bio: map['bio'],
      district: map['district'],
      isFamilyAssisted: map['isFamilyAssisted'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
