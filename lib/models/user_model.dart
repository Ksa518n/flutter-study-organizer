class UserModel {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? profileImage;
  final String role; // 'student', 'admin', 'support'
  final String? subscriptionPlan; // 'free', 'pro', 'premium'
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool? isActive;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.profileImage,
    required this.role,
    this.subscriptionPlan = 'free',
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'profileImage': profileImage,
      'role': role,
      'subscriptionPlan': subscriptionPlan,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isActive': isActive,
    };
  }

  // Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      profileImage: json['profileImage'] as String?,
      role: json['role'] as String? ?? 'student',
      subscriptionPlan: json['subscriptionPlan'] as String? ?? 'free',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  // Copy with
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? profileImage,
    String? role,
    String? subscriptionPlan,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
