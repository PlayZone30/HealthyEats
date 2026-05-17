import '../models/user_model.dart';
import '../models/food_recommendation.dart';

class DummyData {
  // Sample user
  static UserModel get sampleUser => UserModel(
    name: "Sarah Johnson",
    age: 34,
    gender: "Female",
    healthConditions: ["diabetes_type2", "pcos"],
    dietaryPreferences: ["vegetarian"],
    allergies: ["nuts"],
    mealPreferences: MealPreferences(
      mealsPerDay: 3,
      breakfastTime: "08:00",
      lunchTime: "13:00",
      dinnerTime: "19:00",
    ),
  );

  // Health conditions list
  static List<String> get healthConditions => [
    "Diabetes (Type 1/2)",
    "Hypertension",
    "PCOS/Menstrual Issues",
    "Heart Disease",
    "Kidney Disease",
    "Digestive Issues",
    "Weight Management",
    "None of the above",
  ];

  // Dietary preferences
  static List<String> get dietaryPreferences => [
    "Vegetarian",
    "Vegan",
    "Non-Vegetarian",
    "Gluten-Free",
    "Dairy-Free",
  ];

  // Gender options
  static List<String> get genderOptions => [
    "Male",
    "Female",
    "Other",
    "Prefer not to say",
  ];

  // Age groups
  static List<String> get ageGroups => [
    "18-24",
    "25-34",
    "35-50",
    "51-65",
    "65+",
  ];

  // Food recommendations for diabetes
  static List<FoodRecommendation> get diabetesRecommendations => [
    FoodRecommendation(
      name: "Bitter Gourd",
      imageUrl: "assets/images/bitter_gourd.jpg",
      portion: "1/2 cup cooked (85g)",
      bestTiming: "Before meals",
      benefit: "Natural insulin booster",
      condition: "diabetes",
      glycemicIndex: GlycemicIndex.low,
      nutrients: ["Vitamin C", "Fiber", "Potassium"],
    ),
    FoodRecommendation(
      name: "Cucumber",
      imageUrl: "assets/images/cucumber.jpg",
      portion: "1 medium (150g)",
      bestTiming: "Anytime",
      benefit: "Low glycemic index",
      condition: "diabetes",
      glycemicIndex: GlycemicIndex.veryLow,
      nutrients: ["Vitamin K", "Potassium", "Magnesium"],
    ),
    FoodRecommendation(
      name: "Fenugreek Seeds",
      imageUrl: "assets/images/fenugreek.jpg",
      portion: "1 tsp soaked overnight",
      bestTiming: "Morning empty stomach",
      benefit: "Helps regulate blood sugar",
      condition: "diabetes",
      glycemicIndex: GlycemicIndex.low,
      nutrients: ["Fiber", "Protein", "Iron"],
    ),
    FoodRecommendation(
      name: "Cinnamon",
      imageUrl: "assets/images/cinnamon.jpg",
      portion: "1/2 tsp powder",
      bestTiming: "With meals",
      benefit: "Improves insulin sensitivity",
      condition: "diabetes",
      nutrients: ["Antioxidants", "Manganese"],
    ),
  ];

  // Food recommendations for PCOS
  static List<FoodRecommendation> get pcosRecommendations => [
    FoodRecommendation(
      name: "Fennel Seeds",
      imageUrl: "assets/images/fennel_seeds.jpg",
      portion: "1 tsp soaked overnight",
      bestTiming: "Morning empty stomach",
      benefit: "Reduces cramps, regulates hormones",
      condition: "pcos",
      nutrients: ["Fiber", "Calcium", "Iron"],
    ),
    FoodRecommendation(
      name: "Papaya",
      imageUrl: "assets/images/papaya.jpg",
      portion: "1 cup diced (145g)",
      bestTiming: "Morning",
      benefit: "Regulates menstrual cycle",
      condition: "pcos",
      nutrients: ["Vitamin C", "Folate", "Fiber"],
    ),
    FoodRecommendation(
      name: "Turmeric",
      imageUrl: "assets/images/turmeric.jpg",
      portion: "1/2 tsp with warm milk",
      bestTiming: "Before bedtime",
      benefit: "Anti-inflammatory properties",
      condition: "pcos",
      nutrients: ["Curcumin", "Iron", "Manganese"],
    ),
  ];

  // Sample weekly progress data
  static List<bool> get weeklyProgress => [true, true, true, false, false, false, false];

  // Quick action items
  static List<Map<String, dynamic>> get quickActions => [
    {
      "title": "Scan Food",
      "icon": "camera",
      "color": "primary",
    },
    {
      "title": "Meal Plan",
      "icon": "calendar",
      "color": "secondary",
    },
    {
      "title": "Recipes",
      "icon": "book",
      "color": "accent",
    },
    {
      "title": "Progress",
      "icon": "chart",
      "color": "success",
    },
  ];

  // Sample recipes
  static List<Map<String, dynamic>> get sampleRecipes => [
    {
      "name": "Quinoa Vegetable Salad",
      "image": "assets/images/quinoa_salad.jpg",
      "rating": 4.8,
      "reviews": 245,
      "prepTime": "15 min",
      "servings": 2,
      "tags": ["Low-GI", "High fiber"],
      "isHealthy": true,
    },
    {
      "name": "Methi Dal (Fenugreek)",
      "image": "assets/images/methi_dal.jpg",
      "rating": 4.6,
      "reviews": 189,
      "prepTime": "25 min",
      "servings": 4,
      "tags": ["Blood sugar friendly"],
      "isHealthy": true,
    },
    {
      "name": "Cucumber Mint Cooler",
      "image": "assets/images/cucumber_cooler.jpg",
      "rating": 4.5,
      "reviews": 156,
      "prepTime": "5 min",
      "servings": 1,
      "tags": ["Hydrating", "Low-calorie"],
      "isHealthy": true,
    },
  ];

  // Sample meal plan
  static Map<String, List<Map<String, dynamic>>> get sampleMealPlan => {
    "breakfast": [
      {
        "name": "Oats with berries",
        "completed": true,
      },
      {
        "name": "Green tea",
        "completed": true,
      },
    ],
    "lunch": [
      {
        "name": "Quinoa salad",
        "completed": false,
      },
      {
        "name": "Grilled vegetables",
        "completed": false,
      },
    ],
    "dinner": [
      {
        "name": "Lentil soup",
        "completed": false,
      },
      {
        "name": "Whole wheat roti",
        "completed": false,
      },
    ],
  };

  // Educational content
  static List<Map<String, dynamic>> get educationalContent => [
    {
      "title": "Why These Foods Help",
      "subtitle": "Understanding the science behind our recommendations",
      "type": "article",
      "icon": "science",
    },
    {
      "title": "Diabetes Diet Basics",
      "subtitle": "Complete guide to eating right with diabetes",
      "type": "guide",
      "icon": "book",
    },
    {
      "title": "Video Tutorials",
      "subtitle": "Cooking demos and tips",
      "type": "video",
      "icon": "play",
    },
  ];

  // Progress stats
  static Map<String, dynamic> get progressStats => {
    "dietAdherence": 78,
    "targetAdherence": 80,
    "bloodSugarAvg": 125,
    "bloodSugarTrend": "improving",
    "goalsAchieved": [
      {"goal": "5 servings vegetables", "achieved": true},
      {"goal": "No refined sugar", "achieved": true},
      {"goal": "8 glasses water", "achieved": false},
    ],
  };

  // Recent scanned foods
  static List<Map<String, String>> get recentScans => [
    {"name": "Tomato", "emoji": "🍅"},
    {"name": "Cucumber", "emoji": "🥒"},
    {"name": "Orange", "emoji": "🍊"},
    {"name": "Carrot", "emoji": "🥕"},
  ];

  // Comprehensive food database for search functionality
  static List<Map<String, dynamic>> get foodDatabase => [
    // Vegetables
    {
      'name': 'Tomato',
      'emoji': '🍅',
      'category': 'Vegetables',
      'calories': 22,
      'carbs': 4.8,
      'fiber': 1.4,
      'sugar': 3.2,
      'protein': 1.1,
      'fat': 0.2,
      'glycemicIndex': 15,
      'portions': {
        'diabetes': '1 medium (150g)',
        'pcos': '1 large (180g)',
        'hypertension': '1 medium (150g)',
        'general': '1 medium (150g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Low glycemic index, rich in lycopene',
        'pcos': 'Anti-inflammatory properties',
        'hypertension': 'Rich in potassium',
        'general': 'High in vitamin C and antioxidants',
      },
      'bestTiming': 'With meals',
      'recommendations': [
        'Perfect for diabetes management',
        'Rich in lycopene and antioxidants',
        'Low glycemic index',
        'Helps with hydration',
      ],
    },
    {
      'name': 'Cucumber',
      'emoji': '🥒',
      'category': 'Vegetables',
      'calories': 16,
      'carbs': 3.6,
      'fiber': 0.5,
      'sugar': 1.7,
      'protein': 0.7,
      'fat': 0.1,
      'glycemicIndex': 15,
      'portions': {
        'diabetes': '1 large (300g)',
        'pcos': '1 large (300g)',
        'hypertension': '1 large (300g)',
        'general': '1 large (300g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Very low glycemic index, hydrating',
        'pcos': 'Low calorie, anti-inflammatory',
        'hypertension': 'Natural diuretic properties',
        'general': 'Hydrating, low calorie',
      },
      'bestTiming': 'Anytime',
      'recommendations': [
        'Excellent for weight management',
        'Very hydrating',
        'Extremely low in calories',
        'Good source of vitamin K',
      ],
    },
    {
      'name': 'Spinach',
      'emoji': '🥬',
      'category': 'Vegetables',
      'calories': 23,
      'carbs': 3.6,
      'fiber': 2.2,
      'sugar': 0.4,
      'protein': 2.9,
      'fat': 0.4,
      'glycemicIndex': 15,
      'portions': {
        'diabetes': '2 cups fresh (60g)',
        'pcos': '2 cups fresh (60g)',
        'hypertension': '2 cups fresh (60g)',
        'general': '2 cups fresh (60g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Very low carb, high iron',
        'pcos': 'Rich in folate for hormone balance',
        'hypertension': 'High potassium, low sodium',
        'general': 'Rich in iron, folate, vitamin K',
      },
      'bestTiming': 'With meals',
      'recommendations': [
        'Powerhouse of nutrients',
        'Excellent source of iron',
        'Rich in folate and vitamin K',
        'Very low in calories',
      ],
    },
    {
      'name': 'Broccoli',
      'emoji': '🥦',
      'category': 'Vegetables',
      'calories': 34,
      'carbs': 6.6,
      'fiber': 2.6,
      'sugar': 1.5,
      'protein': 2.8,
      'fat': 0.4,
      'glycemicIndex': 10,
      'portions': {
        'diabetes': '1 cup chopped (91g)',
        'pcos': '1 cup chopped (91g)',
        'hypertension': '1 cup chopped (91g)',
        'general': '1 cup chopped (91g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Very low glycemic index',
        'pcos': 'Anti-inflammatory, hormone balancing',
        'hypertension': 'Rich in potassium',
        'general': 'High in vitamin C and antioxidants',
      },
      'bestTiming': 'With meals',
      'recommendations': [
        'Excellent source of vitamin C',
        'Rich in antioxidants',
        'Supports immune system',
        'Great for detoxification',
      ],
    },
    // Fruits
    {
      'name': 'Apple',
      'emoji': '🍎',
      'category': 'Fruits',
      'calories': 52,
      'carbs': 13.8,
      'fiber': 2.4,
      'sugar': 10.4,
      'protein': 0.3,
      'fat': 0.2,
      'glycemicIndex': 36,
      'portions': {
        'diabetes': '1 small (150g)',
        'pcos': '1 medium (180g)',
        'hypertension': '1 medium (180g)',
        'general': '1 medium (180g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Moderate glycemic index, high fiber',
        'pcos': 'Rich in antioxidants',
        'hypertension': 'Good source of potassium',
        'general': 'High in fiber and vitamin C',
      },
      'bestTiming': 'Morning or between meals',
      'recommendations': [
        'Eat with skin for maximum fiber',
        'Good source of pectin',
        'Helps regulate blood sugar',
        'Supports digestive health',
      ],
    },
    {
      'name': 'Banana',
      'emoji': '🍌',
      'category': 'Fruits',
      'calories': 89,
      'carbs': 22.8,
      'fiber': 2.6,
      'sugar': 12.2,
      'protein': 1.1,
      'fat': 0.3,
      'glycemicIndex': 51,
      'portions': {
        'diabetes': '1/2 small (60g)',
        'pcos': '1 small (100g)',
        'hypertension': '1 medium (120g)',
        'general': '1 medium (120g)',
      },
      'safetyStatus': {
        'diabetes': 'caution',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Moderate glycemic index - consume in small portions',
        'pcos': 'Rich in vitamin B6',
        'hypertension': 'Excellent source of potassium',
        'general': 'High in potassium and vitamin B6',
      },
      'bestTiming': 'Post-workout or morning',
      'recommendations': [
        'Excellent post-workout snack',
        'Rich in potassium for heart health',
        'Good source of vitamin B6',
        'Choose slightly green bananas for lower GI',
      ],
    },
    {
      'name': 'Orange',
      'emoji': '🍊',
      'category': 'Fruits',
      'calories': 47,
      'carbs': 11.8,
      'fiber': 2.4,
      'sugar': 9.4,
      'protein': 0.9,
      'fat': 0.1,
      'glycemicIndex': 45,
      'portions': {
        'diabetes': '1 small (130g)',
        'pcos': '1 medium (150g)',
        'hypertension': '1 medium (150g)',
        'general': '1 medium (150g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Moderate glycemic index, high fiber',
        'pcos': 'Rich in vitamin C and antioxidants',
        'hypertension': 'Good source of potassium',
        'general': 'Excellent source of vitamin C',
      },
      'bestTiming': 'Morning or between meals',
      'recommendations': [
        'Excellent source of vitamin C',
        'Rich in folate',
        'Good source of fiber',
        'Supports immune system',
      ],
    },
    // Grains
    {
      'name': 'Brown Rice',
      'emoji': '🍚',
      'category': 'Grains',
      'calories': 111,
      'carbs': 23,
      'fiber': 1.8,
      'sugar': 0.4,
      'protein': 2.6,
      'fat': 0.9,
      'glycemicIndex': 68,
      'portions': {
        'diabetes': '1/3 cup cooked (55g)',
        'pcos': '1/2 cup cooked (85g)',
        'hypertension': '1/2 cup cooked (85g)',
        'general': '1/2 cup cooked (85g)',
      },
      'safetyStatus': {
        'diabetes': 'caution',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Better than white rice, but moderate portions',
        'pcos': 'Complex carbohydrates for sustained energy',
        'hypertension': 'Source of magnesium',
        'general': 'Whole grain with B vitamins',
      },
      'bestTiming': 'Lunch time',
      'recommendations': [
        'Choose over white rice',
        'Good source of manganese',
        'Contains antioxidants',
        'Pair with vegetables and protein',
      ],
    },
    {
      'name': 'Quinoa',
      'emoji': '🌾',
      'category': 'Grains',
      'calories': 120,
      'carbs': 22,
      'fiber': 2.8,
      'sugar': 0.9,
      'protein': 4.4,
      'fat': 1.9,
      'glycemicIndex': 53,
      'portions': {
        'diabetes': '1/3 cup cooked (60g)',
        'pcos': '1/2 cup cooked (90g)',
        'hypertension': '1/2 cup cooked (90g)',
        'general': '1/2 cup cooked (90g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Lower glycemic index than most grains',
        'pcos': 'Complete protein, helps with satiety',
        'hypertension': 'Good source of magnesium',
        'general': 'Complete protein, gluten-free',
      },
      'bestTiming': 'Lunch or dinner',
      'recommendations': [
        'Complete protein source',
        'Naturally gluten-free',
        'Rich in minerals',
        'Great rice substitute',
      ],
    },
    // Protein Sources
    {
      'name': 'Chicken Breast',
      'emoji': '🍗',
      'category': 'Protein',
      'calories': 165,
      'carbs': 0,
      'fiber': 0,
      'sugar': 0,
      'protein': 31,
      'fat': 3.6,
      'glycemicIndex': 0,
      'portions': {
        'diabetes': '100g cooked',
        'pcos': '100g cooked',
        'hypertension': '100g cooked',
        'general': '100g cooked',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Zero carbs, high protein',
        'pcos': 'Lean protein supports hormone balance',
        'hypertension': 'Low sodium when prepared without salt',
        'general': 'Excellent lean protein source',
      },
      'bestTiming': 'Any meal',
      'recommendations': [
        'Excellent lean protein',
        'Zero carbohydrates',
        'Rich in B vitamins',
        'Choose grilled or baked preparation',
      ],
    },
    {
      'name': 'Salmon',
      'emoji': '🐟',
      'category': 'Protein',
      'calories': 208,
      'carbs': 0,
      'fiber': 0,
      'sugar': 0,
      'protein': 25.4,
      'fat': 12.4,
      'glycemicIndex': 0,
      'portions': {
        'diabetes': '100g cooked',
        'pcos': '100g cooked',
        'hypertension': '100g cooked',
        'general': '100g cooked',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Zero carbs, omega-3 fatty acids',
        'pcos': 'Omega-3s support hormone balance',
        'hypertension': 'Omega-3s support heart health',
        'general': 'Rich in omega-3 fatty acids',
      },
      'bestTiming': 'Lunch or dinner',
      'recommendations': [
        'Excellent source of omega-3s',
        'High quality protein',
        'Supports heart health',
        'Rich in vitamin D',
      ],
    },
    // Nuts and Seeds
    {
      'name': 'Almonds',
      'emoji': '🌰',
      'category': 'Nuts',
      'calories': 161,
      'carbs': 6.1,
      'fiber': 3.5,
      'sugar': 1.2,
      'protein': 6,
      'fat': 14,
      'glycemicIndex': 0,
      'portions': {
        'diabetes': '10-12 almonds (28g)',
        'pcos': '10-12 almonds (28g)',
        'hypertension': '10-12 almonds (28g)',
        'general': '10-12 almonds (28g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Low carb, healthy fats, protein',
        'pcos': 'Healthy fats support hormone production',
        'hypertension': 'Magnesium supports blood pressure',
        'general': 'Rich in vitamin E and healthy fats',
      },
      'bestTiming': 'Snack time',
      'recommendations': [
        'Rich in vitamin E',
        'Good source of magnesium',
        'Healthy monounsaturated fats',
        'Choose unsalted varieties',
      ],
    },
    {
      'name': 'Walnuts',
      'emoji': '🥜',
      'category': 'Nuts',
      'calories': 185,
      'carbs': 3.9,
      'fiber': 1.9,
      'sugar': 0.7,
      'protein': 4.3,
      'fat': 18.5,
      'glycemicIndex': 0,
      'portions': {
        'diabetes': '7 halves (28g)',
        'pcos': '7 halves (28g)',
        'hypertension': '7 halves (28g)',
        'general': '7 halves (28g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Low carb, omega-3 fatty acids',
        'pcos': 'Omega-3s support hormone balance',
        'hypertension': 'Omega-3s support cardiovascular health',
        'general': 'Rich in omega-3 fatty acids',
      },
      'bestTiming': 'Snack time',
      'recommendations': [
        'Excellent source of plant-based omega-3s',
        'Supports brain health',
        'Rich in antioxidants',
        'Choose unsalted varieties',
      ],
    },
    // Legumes
    {
      'name': 'Lentils',
      'emoji': '🌱',
      'category': 'Legumes',
      'calories': 116,
      'carbs': 20,
      'fiber': 7.9,
      'sugar': 1.8,
      'protein': 9,
      'fat': 0.4,
      'glycemicIndex': 32,
      'portions': {
        'diabetes': '1/2 cup cooked (100g)',
        'pcos': '1/2 cup cooked (100g)',
        'hypertension': '1/2 cup cooked (100g)',
        'general': '1/2 cup cooked (100g)',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Low glycemic index, high fiber',
        'pcos': 'High protein, supports satiety',
        'hypertension': 'Good source of potassium',
        'general': 'Excellent plant-based protein',
      },
      'bestTiming': 'Lunch or dinner',
      'recommendations': [
        'Excellent plant-based protein',
        'Very high in fiber',
        'Rich in folate and iron',
        'Low glycemic index',
      ],
    },
    // Dairy
    {
      'name': 'Greek Yogurt',
      'emoji': '🥛',
      'category': 'Dairy',
      'calories': 100,
      'carbs': 6,
      'fiber': 0,
      'sugar': 6,
      'protein': 17,
      'fat': 0.7,
      'glycemicIndex': 11,
      'portions': {
        'diabetes': '150g plain, unsweetened',
        'pcos': '150g plain, unsweetened',
        'hypertension': '150g plain, unsweetened',
        'general': '150g plain, unsweetened',
      },
      'safetyStatus': {
        'diabetes': 'safe',
        'pcos': 'safe',
        'hypertension': 'safe',
        'heart_disease': 'safe',
      },
      'benefits': {
        'diabetes': 'Low glycemic index, high protein',
        'pcos': 'Probiotics support gut health',
        'hypertension': 'Good source of calcium',
        'general': 'High protein, probiotics',
      },
      'bestTiming': 'Breakfast or snack',
      'recommendations': [
        'Choose plain, unsweetened varieties',
        'Excellent source of probiotics',
        'High in protein',
        'Good source of calcium',
      ],
    },
  ];
} 