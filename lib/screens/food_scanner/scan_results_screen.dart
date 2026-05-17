import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';

class ScanResultsScreen extends StatefulWidget {
  final Map<String, dynamic>? scannedFood;

  const ScanResultsScreen({super.key, this.scannedFood});

  @override
  State<ScanResultsScreen> createState() => _ScanResultsScreenState();
}

class _ScanResultsScreenState extends State<ScanResultsScreen> {
  bool _isLoading = true;
  Map<String, dynamic> _foodData = {};

  @override
  void initState() {
    super.initState();
    _simulateAnalysis();
  }

  void _simulateAnalysis() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      _foodData = widget.scannedFood ?? {
        'name': 'TOMATO',
        'emoji': '🍅',
        'confidence': 95,
        'safetyStatus': 'safe',
        'portion': '1 medium',
        'bestTime': 'With meals',
        'benefits': 'Low sugar, high fiber',
        'healthCondition': 'Diabetes',
        'calories': 22,
        'carbs': 4.8,
        'fiber': 1.4,
        'sugar': 3.2,
        'warnings': [],
        'recommendations': [
          'Perfect for diabetes management',
          'Rich in lycopene and antioxidants',
          'Low glycemic index',
          'Helps with hydration',
        ],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Scan Results'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _shareResults,
            icon: const Icon(FontAwesomeIcons.share),
          ),
        ],
      ),
      body: _isLoading ? _buildLoadingScreen() : _buildResultsScreen(),
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          SizedBox(height: AppTheme.spacing16),
          Text(
            'Analyzing food...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppTheme.spacing8),
          Text(
            'Getting personalized recommendations',
            style: TextStyle(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsScreen() {
    final safetyColor = _foodData['safetyStatus'] == 'safe'
        ? AppColors.success
        : _foodData['safetyStatus'] == 'caution'
            ? AppColors.warning
            : AppColors.error;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food image and identification
          FadeInDown(
            child: _buildFoodIdentificationCard(),
          ),
          
          const SizedBox(height: AppTheme.spacing20),
          
          // Safety status
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: _buildSafetyStatusCard(safetyColor),
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          // Nutritional information
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: _buildNutritionalInfoCard(),
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          // Recommendations
          FadeInUp(
            delay: const Duration(milliseconds: 600),
            child: _buildRecommendationsCard(),
          ),
          
          const SizedBox(height: AppTheme.spacing24),
          
          // Action buttons
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            child: _buildActionButtons(),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodIdentificationCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
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
        children: [
          // Simulated food image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _foodData['emoji'] ?? '🍅',
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    'Scanned Food Image',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacing20),
          
          // Food name and confidence
          Text(
            _foodData['name'] ?? 'Unknown Food',
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: AppTheme.spacing8),
          
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing12,
              vertical: AppTheme.spacing8,
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Confidence: ${_foodData['confidence'] ?? 0}%',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyStatusCard(Color safetyColor) {
    final statusText = _foodData['safetyStatus'] == 'safe'
        ? 'SAFE TO EAT'
        : _foodData['safetyStatus'] == 'caution'
            ? 'EAT WITH CAUTION'
            : 'NOT RECOMMENDED';

    final statusIcon = _foodData['safetyStatus'] == 'safe'
        ? FontAwesomeIcons.circleCheck
        : _foodData['safetyStatus'] == 'caution'
            ? FontAwesomeIcons.triangleExclamation
            : FontAwesomeIcons.circleXmark;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: safetyColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: safetyColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'For your ${_foodData['healthCondition'] ?? 'Health Condition'}:',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: AppTheme.spacing12),
          
          Row(
            children: [
              Icon(
                statusIcon,
                color: safetyColor,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spacing12),
              Text(
                statusText,
                style: AppTextStyles.h4.copyWith(
                  color: safetyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          // Portion and timing info
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'Recommended',
                  _foodData['portion'] ?? 'N/A',
                  FontAwesomeIcons.scaleBalanced,
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildInfoItem(
                  'Best time',
                  _foodData['bestTime'] ?? 'N/A',
                  FontAwesomeIcons.clock,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing12),
          
          // Benefits
          if (_foodData['benefits'] != null) ...[
            Text(
              'Benefits:',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              _foodData['benefits'],
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNutritionalInfoCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
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
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.chartPie,
                color: AppColors.accent,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'Nutritional Information',
                style: AppTextStyles.cardTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          // Nutritional values
          Row(
            children: [
              Expanded(
                child: _buildNutritionItem(
                  'Calories',
                  '${_foodData['calories'] ?? 0}',
                  'kcal',
                  AppColors.secondary,
                ),
              ),
              Expanded(
                child: _buildNutritionItem(
                  'Carbs',
                  '${_foodData['carbs'] ?? 0}',
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
                child: _buildNutritionItem(
                  'Fiber',
                  '${_foodData['fiber'] ?? 0}',
                  'g',
                  AppColors.success,
                ),
              ),
              Expanded(
                child: _buildNutritionItem(
                  'Sugar',
                  '${_foodData['sugar'] ?? 0}',
                  'g',
                  AppColors.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsCard() {
    final recommendations = _foodData['recommendations'] as List<String>? ?? [];
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
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
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.lightbulb,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'AI Recommendations',
                style: AppTextStyles.cardTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          ...recommendations.map((recommendation) => Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
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
                        recommendation,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: AppTheme.spacing8),
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
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionItem(String label, String value, String unit, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: AppTextStyles.h4.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: unit,
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

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _addToToday,
                icon: const Icon(FontAwesomeIcons.plus),
                label: const Text('Add to Today'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _learnMore,
                icon: const Icon(FontAwesomeIcons.circleInfo),
                label: const Text('Learn More'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppTheme.spacing12),
        
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _setReminder,
                icon: const Icon(FontAwesomeIcons.bell),
                label: const Text('Set Reminder'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.secondary,
                  side: const BorderSide(color: AppColors.secondary),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _shareResults,
                icon: const Icon(FontAwesomeIcons.share),
                label: const Text('Share'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.accent,
                  side: const BorderSide(color: AppColors.accent),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _addToToday() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_foodData['name']} added to today\'s meal plan'),
        backgroundColor: AppColors.success,
        action: SnackBarAction(
          label: 'VIEW',
          textColor: AppColors.textOnPrimary,
          onPressed: () {
            // Navigate to meal plan
          },
        ),
      ),
    );
  }

  void _learnMore() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailScreen(food: _foodData),
      ),
    );
  }

  void _setReminder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Reminder'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Before next meal'),
              onTap: () {
                Navigator.pop(context);
                _setReminderTime('next_meal');
              },
            ),
            ListTile(
              title: const Text('In 2 hours'),
              onTap: () {
                Navigator.pop(context);
                _setReminderTime('2_hours');
              },
            ),
            ListTile(
              title: const Text('Tomorrow'),
              onTap: () {
                Navigator.pop(context);
                _setReminderTime('tomorrow');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setReminderTime(String option) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reminder set for ${_foodData['name']}'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _shareResults() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Share Results',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppTheme.spacing16),
            ListTile(
              leading: const Icon(FontAwesomeIcons.userDoctor),
              title: const Text('Share with Doctor'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.users),
              title: const Text('Share with Family'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.copy),
              title: const Text('Copy to Clipboard'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodDetailScreen extends StatelessWidget {
  final Map<String, dynamic> food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food['name'] ?? 'Food Details'),
      ),
      body: const Center(
        child: Text('Detailed Food Information Coming Soon'),
      ),
    );
  }
} 