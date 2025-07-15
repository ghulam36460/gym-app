class AppUser {

  AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.age,
    required this.height,
    required this.weight,
    required this.fitnessGoal,
    required this.bmi,
    required this.createdAt,
    required this.updatedAt,
    this.profileImagePath = '',
    this.isEmailVerified = false,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      age: json['age'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      fitnessGoal: json['fitnessGoal'],
      profileImagePath: json['profileImagePath'] ?? '',
      bmi: json['bmi']?.toDouble() ?? 0.0,
      isEmailVerified: json['isEmailVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory AppUser.fromFirestore(Map<String, dynamic> data) {
    return AppUser(
      id: data['id'],
      fullName: data['fullName'],
      email: data['email'],
      age: data['age'],
      height: data['height'].toDouble(),
      weight: data['weight'].toDouble(),
      fitnessGoal: data['fitnessGoal'],
      profileImagePath: data['profileImagePath'] ?? '',
      bmi: data['bmi']?.toDouble() ?? 0.0,
      isEmailVerified: data['isEmailVerified'] ?? false,
      createdAt: data['createdAt'] != null 
          ? DateTime.parse(data['createdAt']) 
          : DateTime.now(),
      updatedAt: data['updatedAt'] != null 
          ? DateTime.parse(data['updatedAt']) 
          : DateTime.now(),
    );
  }
  final String id;
  final String fullName;
  final String email;
  final int age;
  final double height; // in cm
  final double weight; // in kg
  final String fitnessGoal;
  final String profileImagePath;
  final double bmi;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get bmiCategory {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'age': age,
      'height': height,
      'weight': weight,
      'fitnessGoal': fitnessGoal,
      'profileImagePath': profileImagePath,
      'bmi': bmi,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toFirestore() {
    return toJson();
  }

  AppUser copyWith({
    String? id,
    String? fullName,
    String? email,
    int? age,
    double? height,
    double? weight,
    String? fitnessGoal,
    String? profileImagePath,
    double? bmi,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      bmi: bmi ?? this.bmi,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
