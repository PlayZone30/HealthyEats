import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';

class DiabetesManagementScreen extends StatefulWidget {
  const DiabetesManagementScreen({super.key});

  @override
  State<DiabetesManagementScreen> createState() => _DiabetesManagementScreenState();
}

class _DiabetesManagementScreenState extends State<DiabetesManagementScreen> {
  final List<Map<String, dynamic>> _recommendedFoods = [
    {
      'name': 'CUCUMBER',
      'emoji': '🥒',
      'description': 'Low glycemic index',
      'portion': '1 medium (150g)',
      'bestTime': 'Anytime',
      'benefits': ['Low carbs', 'High water content', 'Rich in fiber'],
      'safetyLevel': 'high',
    },
    {
      'name': 'BITTER GOURD',
      'emoji': '🥬',
      'description': 'Natural insulin',
      'portion': '1/2 cup cooked (85g)',
      'bestTime': 'Before meals',
      'benefits': ['Reduces blood sugar', 'Natural insulin', 'Low calories'],
      'safetyLevel': 'high',
    },
    {
      'name': 'SPINACH',
      'emoji': '🥬',
      'description': 'Iron & fiber rich',
      'portion': '1 cup raw (30g)',
      'bestTime': 'With meals',
      'benefits': ['High iron', 'Low carbs', 'Rich in vitamins'],
      'safetyLevel': 'high',
    },
    {
      'name': 'ALMONDS',
      'emoji': '🥜',
      'description': 'Healthy fats',
      'portion': '10-15 nuts (20g)',
      'bestTime': 'As snack',
      'benefits': ['Good fats', 'Protein', 'Controls sugar spikes'],
      'safetyLevel': 'medium',
    },
  ];

  final List<String> _mealPlanItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Diabetes Management'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showFilterOptions,
            icon: const Icon(FontAwesomeIcons.filter),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            FadeInDown(
              child: _buildHeaderSection(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Today's picks header
            FadeInLeft(
              delay: const Duration(milliseconds: 200),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.appleWhole,
                    color: AppColors.diabetes,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Today\'s Food Picks',
                    style: AppTextStyles.h3,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Food recommendations
            ...List.generate(_recommendedFoods.length, (index) {
              final food = _recommendedFoods[index];
              return FadeInUp(
                delay: Duration(milliseconds: 300 + (index * 100)),
                child: _buildFoodRecommendationCard(food),
              );
            }),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Action buttons
            FadeInUp(
              delay: const Duration(milliseconds: 800),
              child: _buildActionButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.diabetes.withOpacity(0.1),
            AppColors.diabetes.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: AppColors.diabetes.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.diabetes,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              FontAwesomeIcons.heartPulse,
              color: AppColors.textOnPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Diabetes Management',
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.diabetes,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  'Personalized recommendations for better blood sugar control',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodRecommendationCard(Map<String, dynamic> food) {
    final safetyColor = food['safetyLevel'] == 'high'
        ? AppColors.success
        : food['safetyLevel'] == 'medium'
            ? AppColors.warning
            : AppColors.error;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.textLight.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food header
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: safetyColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    food['emoji'],
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food['name'],
                      style: AppTextStyles.cardTitle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      food['description'],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8,
                  vertical: AppTheme.spacing4,
                ),
                decoration: BoxDecoration(
                  color: safetyColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.circleCheck,
                      size: 12,
                      color: safetyColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'SAFE',
                      style: AppTextStyles.caption.copyWith(
                        color: safetyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          // Food details
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Recommended',
                  food['portion'],
                  FontAwesomeIcons.scaleBalanced,
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildDetailItem(
                  'Best time',
                  food['bestTime'],
                  FontAwesomeIcons.clock,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing12),
          
          // Benefits
          Text(
            'Benefits:',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          Wrap(
            spacing: AppTheme.spacing8,
            runSpacing: AppTheme.spacing4,
            children: food['benefits'].map<Widget>((benefit) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8,
                  vertical: AppTheme.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  benefit,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _addToMealPlan(food['name']),
                  icon: const Icon(FontAwesomeIcons.plus, size: 14),
                  label: const Text('Add to Today'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _learnMore(food),
                  icon: const Icon(FontAwesomeIcons.circleInfo, size: 14),
                  label: const Text('Learn More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: AppTheme.spacing4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _viewAllRecommendations,
            icon: const Icon(FontAwesomeIcons.list),
            label: const Text('View All'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.diabetes,
              foregroundColor: AppColors.textOnPrimary,
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _viewMealPlan,
            icon: const Icon(FontAwesomeIcons.calendarDays),
            label: const Text('Meal Plan'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.diabetes,
              side: const BorderSide(color: AppColors.diabetes),
            ),
          ),
        ),
      ],
    );
  }

  void _addToMealPlan(String foodName) {
    setState(() {
      if (!_mealPlanItems.contains(foodName)) {
        _mealPlanItems.add(foodName);
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$foodName added to today\'s meal plan'),
        backgroundColor: AppColors.success,
        action: SnackBarAction(
          label: 'UNDO',
          textColor: AppColors.textOnPrimary,
          onPressed: () {
            setState(() {
              _mealPlanItems.remove(foodName);
            });
          },
        ),
      ),
    );
  }

  void _learnMore(Map<String, dynamic> food) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFoodDetailModal(food),
    );
  }

  Widget _buildFoodDetailModal(Map<String, dynamic> food) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppTheme.cardRadius),
          topRight: Radius.circular(AppTheme.cardRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacing20),
          
          // Food header
          Row(
            children: [
              Text(
                food['emoji'],
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food['name'],
                      style: AppTextStyles.h2,
                    ),
                    Text(
                      food['description'],
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing24),
          
          // Detailed information
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection('Nutritional Benefits', food['benefits']),
                  const SizedBox(height: AppTheme.spacing16),
                  _buildInfoSection('How it helps with Diabetes', [
                    'Helps regulate blood sugar levels',
                    'Low glycemic index food',
                    'Rich in fiber for better digestion',
                    'Contains antioxidants',
                  ]),
                  const SizedBox(height: AppTheme.spacing16),
                  _buildInfoSection('Best Practices', [
                    'Consume ${food['portion']} daily',
                    'Best time: ${food['bestTime']}',
                    'Can be combined with other diabetes-friendly foods',
                    'Monitor blood sugar after consumption',
                  ]),
                ],
              ),
            ),
          ),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _addToMealPlan(food['name']);
                  },
                  child: const Text('Add to Plan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.cardTitle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    FontAwesomeIcons.circleCheck,
                    size: 12,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filter Options',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppTheme.spacing16),
            ListTile(
              leading: const Icon(FontAwesomeIcons.clock),
              title: const Text('By meal time'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.heart),
              title: const Text('Safety level'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.utensils),
              title: const Text('Food category'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _viewAllRecommendations() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllRecommendationsScreen(),
      ),
    );
  }

  void _viewMealPlan() {
    // Navigate to meal planning screen
    Navigator.of(context).pop();
  }
}

class AllRecommendationsScreen extends StatelessWidget {
  const AllRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Recommendations'),
      ),
      body: const Center(
        child: Text('All Recommendations Screen Coming Soon'),
      ),
    );
  }
} 