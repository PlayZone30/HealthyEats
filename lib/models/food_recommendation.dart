class FoodRecommendation {
  final String name;
  final String imageUrl;
  final String portion;
  final String bestTiming;
  final String benefit;
  final String condition;
  final GlycemicIndex? glycemicIndex;
  final List<String> nutrients;

  FoodRecommendation({
    required this.name,
    required this.imageUrl,
    required this.portion,
    required this.bestTiming,
    required this.benefit,
    required this.condition,
    this.glycemicIndex,
    this.nutrients = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'portion': portion,
      'bestTiming': bestTiming,
      'benefit': benefit,
      'condition': condition,
      'glycemicIndex': glycemicIndex?.name,
      'nutrients': nutrients,
    };
  }

  factory FoodRecommendation.fromJson(Map<String, dynamic> json) {
    return FoodRecommendation(
      name: json['name'],
      imageUrl: json['imageUrl'],
      portion: json['portion'],
      bestTiming: json['bestTiming'],
      benefit: json['benefit'],
      condition: json['condition'],
      glycemicIndex: json['glycemicIndex'] != null
          ? GlycemicIndex.values.firstWhere(
              (e) => e.name == json['glycemicIndex'],
            )
          : null,
      nutrients: List<String>.from(json['nutrients'] ?? []),
    );
  }
}

enum GlycemicIndex {
  veryLow,
  low,
  medium,
  high,
}

extension GlycemicIndexExtension on GlycemicIndex {
  String get displayName {
    switch (this) {
      case GlycemicIndex.veryLow:
        return 'Very Low GI';
      case GlycemicIndex.low:
        return 'Low GI';
      case GlycemicIndex.medium:
        return 'Medium GI';
      case GlycemicIndex.high:
        return 'High GI';
    }
  }

  String get description {
    switch (this) {
      case GlycemicIndex.veryLow:
        return 'Excellent for blood sugar control';
      case GlycemicIndex.low:
        return 'Good for stable energy';
      case GlycemicIndex.medium:
        return 'Moderate impact on blood sugar';
      case GlycemicIndex.high:
        return 'May cause blood sugar spikes';
    }
  }
} 