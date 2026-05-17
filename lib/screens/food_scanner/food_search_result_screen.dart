import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/animated_button.dart';

class FoodSearchResultScreen extends StatelessWidget {
  final Map<String, dynamic> foodData;
  final List<String> userHealthConditions;

  const FoodSearchResultScreen({
    super.key,
    required this.foodData,
    required this.userHealthConditions,
  });

  @override
  Widget build(BuildContext context) {
    final primaryCondition = userHealthConditions.isNotEmpty 
        ? userHealthConditions.first 
        : 'general';
    final safetyStatus = foodData['safetyStatus'][primaryCondition] ?? 'unknown';
    final portion = foodData['portions'][primaryCondition] ?? foodData['portions']['general'];
    final benefit = foodData['benefits'][primaryCondition] ?? foodData['benefits']['general'];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(foodData['name']),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Share functionality
            },
            icon: const Icon(FontAwesomeIcons.shareNodes),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Food Header
            FadeInDown(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppTheme.spacing24),
                decoration: BoxDecoration(
                  color: _getSafetyColor(safetyStatus).withOpacity(0.1),
                  border: const Border(
                    bottom: BorderSide(color: AppColors.borderLight),
                  ),
                ),
                child: Column(
                  children: [
                    // Food Icon
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                        border: Border.all(
                          color: _getSafetyColor(safetyStatus).withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          foodData['emoji'],
                          style: const TextStyle(fontSize: 60),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: AppTheme.spacing16),
                    
                    Text(
                      foodData['name'],
                      style: AppTextStyles.h2,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: AppTheme.spacing8),
                    
                    Text(
                      foodData['category'],
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    
                    const SizedBox(height: AppTheme.spacing16),
                    
                    // Safety Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing16,
                        vertical: AppTheme.spacing12,
                      ),
                      decoration: BoxDecoration(
                        color: _getSafetyColor(safetyStatus).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                        border: Border.all(
                          color: _getSafetyColor(safetyStatus).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getSafetyIcon(safetyStatus),
                            color: _getSafetyColor(safetyStatus),
                            size: 20,
                          ),
                          const SizedBox(width: AppTheme.spacing8),
                          Text(
                            _getSafetyText(safetyStatus),
                            style: AppTextStyles.cardTitle.copyWith(
                              color: _getSafetyColor(safetyStatus),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Health Information
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Container(
                margin: const EdgeInsets.all(AppTheme.spacing16),
                padding: const EdgeInsets.all(AppTheme.spacing20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'For Your Health Condition',
                      style: AppTextStyles.cardTitle,
                    ),
                    
                    const SizedBox(height: AppTheme.spacing16),
                    
                    // Recommended Portion
                    _buildInfoRow(
                      'Recommended Portion',
                      portion,
                      FontAwesomeIcons.utensils,
                      AppColors.primary,
                    ),
                    
                    const SizedBox(height: AppTheme.spacing12),
                    
                    // Best Timing
                    _buildInfoRow(
                      'Best Time to Eat',
                      foodData['bestTiming'],
                      FontAwesomeIcons.clock,
                      AppColors.secondary,
                    ),
                    
                    const SizedBox(height: AppTheme.spacing12),
                    
                    // Health Benefits
                    _buildInfoRow(
                      'Health Benefits',
                      benefit,
                      FontAwesomeIcons.heart,
                      AppColors.success,
                    ),
                  ],
                ),
              ),
            ),
            
            // Nutritional Information
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
                padding: const EdgeInsets.all(AppTheme.spacing20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nutritional Information',
                      style: AppTextStyles.cardTitle,
                    ),
                    
                    const SizedBox(height: AppTheme.spacing16),
                    
                    // Nutritional Grid
                    Row(
                      children: [
                        Expanded(
                          child: _buildNutritionCard(
                            'Calories',
                            '${foodData['calories']}',
                            'kcal',
                            AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        Expanded(
                          child: _buildNutritionCard(
                            'Carbs',
                            '${foodData['carbs']}',
                            'g',
                            AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppTheme.spacing12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildNutritionCard(
                            'Protein',
                            '${foodData['protein']}',
                            'g',
                            AppColors.success,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        Expanded(
                          child: _buildNutritionCard(
                            'Fat',
                            '${foodData['fat']}',
                            'g',
                            AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppTheme.spacing12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildNutritionCard(
                            'Fiber',
                            '${foodData['fiber']}',
                            'g',
                            AppColors.accent,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        Expanded(
                          child: _buildNutritionCard(
                            'GI Index',
                            '${foodData['glycemicIndex']}',
                            '',
                            _getGIColor(foodData['glycemicIndex']),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Recommendations
            if (foodData['recommendations'] != null)
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Container(
                  margin: const EdgeInsets.all(AppTheme.spacing16),
                  padding: const EdgeInsets.all(AppTheme.spacing20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expert Recommendations',
                        style: AppTextStyles.cardTitle,
                      ),
                      
                      const SizedBox(height: AppTheme.spacing16),
                      
                      ...List.generate(
                        foodData['recommendations'].length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                margin: const EdgeInsets.only(top: 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spacing12),
                              Expanded(
                                child: Text(
                                  foodData['recommendations'][index],
                                  style: AppTextStyles.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            // Action Buttons
            FadeInUp(
              delay: const Duration(milliseconds: 800),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing16),
                child: Column(
                  children: [
                    AnimatedButton(
                      onPressed: () {
                        _showAddToMealPlanDialog(context);
                      },
                      text: 'Add to Meal Plan',
                      icon: FontAwesomeIcons.calendarPlus,
                    ),
                    
                    const SizedBox(height: AppTheme.spacing12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _showSetReminderDialog(context);
                            },
                            icon: const Icon(FontAwesomeIcons.bell, size: 16),
                            label: const Text('Set Reminder'),
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Share results
                            },
                            icon: const Icon(FontAwesomeIcons.shareNodes, size: 16),
                            label: const Text('Share'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 18,
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppTheme.spacing4),
              Text(
                value,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionCard(String label, String value, String unit, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          RichText(
            text: TextSpan(
              text: value,
              style: AppTextStyles.h4.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: unit.isNotEmpty ? ' $unit' : '',
                  style: AppTextStyles.caption.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getSafetyColor(String safetyStatus) {
    switch (safetyStatus) {
      case 'safe':
        return AppColors.success;
      case 'caution':
        return AppColors.warning;
      case 'not_recommended':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _getSafetyIcon(String safetyStatus) {
    switch (safetyStatus) {
      case 'safe':
        return FontAwesomeIcons.circleCheck;
      case 'caution':
        return FontAwesomeIcons.triangleExclamation;
      case 'not_recommended':
        return FontAwesomeIcons.circleXmark;
      default:
        return FontAwesomeIcons.circleQuestion;
    }
  }

  String _getSafetyText(String safetyStatus) {
    switch (safetyStatus) {
      case 'safe':
        return 'SAFE TO EAT';
      case 'caution':
        return 'EAT WITH CAUTION';
      case 'not_recommended':
        return 'NOT RECOMMENDED';
      default:
        return 'UNKNOWN';
    }
  }

  Color _getGIColor(int glycemicIndex) {
    if (glycemicIndex <= 25) {
      return AppColors.success;
    } else if (glycemicIndex <= 55) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }

  void _showAddToMealPlanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add to Meal Plan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add ${foodData['name']} to your meal plan for:'),
            const SizedBox(height: AppTheme.spacing16),
            ...['Today', 'Tomorrow', 'Custom Date'].map((option) =>
              ListTile(
                title: Text(option),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${foodData['name']} added to meal plan for $option'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showSetReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Reminder'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Set a reminder to eat ${foodData['name']}:'),
            const SizedBox(height: AppTheme.spacing16),
            ...['In 1 hour', 'In 3 hours', 'Tomorrow', 'Custom time'].map((option) =>
              ListTile(
                title: Text(option),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Reminder set for ${foodData['name']} - $option'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
} 