class UserModel {
  final String name;
  final int age;
  final String gender;
  final List<String> healthConditions;
  final List<String> dietaryPreferences;
  final List<String> allergies;
  final MealPreferences mealPreferences;

  UserModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.healthConditions,
    required this.dietaryPreferences,
    required this.allergies,
    required this.mealPreferences,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'healthConditions': healthConditions,
      'dietaryPreferences': dietaryPreferences,
      'allergies': allergies,
      'mealPreferences': mealPreferences.toJson(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      healthConditions: List<String>.from(json['healthConditions']),
      dietaryPreferences: List<String>.from(json['dietaryPreferences']),
      allergies: List<String>.from(json['allergies']),
      mealPreferences: MealPreferences.fromJson(json['mealPreferences']),
    );
  }
}

class MealPreferences {
  final int mealsPerDay;
  final String breakfastTime;
  final String lunchTime;
  final String dinnerTime;

  MealPreferences({
    required this.mealsPerDay,
    required this.breakfastTime,
    required this.lunchTime,
    required this.dinnerTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'mealsPerDay': mealsPerDay,
      'breakfastTime': breakfastTime,
      'lunchTime': lunchTime,
      'dinnerTime': dinnerTime,
    };
  }

  factory MealPreferences.fromJson(Map<String, dynamic> json) {
    return MealPreferences(
      mealsPerDay: json['mealsPerDay'],
      breakfastTime: json['breakfastTime'],
      lunchTime: json['lunchTime'],
      dinnerTime: json['dinnerTime'],
    );
  }
} 