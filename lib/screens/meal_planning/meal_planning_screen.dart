import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';

class MealPlanningScreen extends StatefulWidget {
  const MealPlanningScreen({super.key});

  @override
  State<MealPlanningScreen> createState() => _MealPlanningScreenState();
}

class _MealPlanningScreenState extends State<MealPlanningScreen> {
  DateTime _selectedWeek = DateTime.now();
  int _selectedDay = DateTime.now().weekday - 1; // Monday = 0

  final List<String> _weekDays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  final List<Color> _dayColors = [
    AppColors.success, // Completed
    AppColors.warning, // Partial
    AppColors.success, // Completed
    AppColors.borderLight, // Not started
    AppColors.borderLight, // Not started
    AppColors.borderLight, // Not started
    AppColors.borderLight, // Not started
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Weekly Meal Plan'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showMealPlanOptions,
            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Week selector
            FadeInDown(
              child: _buildWeekSelector(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Day progress indicators
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _buildDayProgressIndicators(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Today's meal plan
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: _buildTodayMealPlan(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Action buttons
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: _buildActionButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekSelector() {
    final startOfWeek = _selectedWeek.subtract(Duration(days: _selectedWeek.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _selectedWeek = _selectedWeek.subtract(const Duration(days: 7));
              });
            },
            icon: const Icon(FontAwesomeIcons.chevronLeft),
          ),
          Column(
            children: [
              const Icon(
                FontAwesomeIcons.calendar,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                '${_formatDate(startOfWeek)} - ${_formatDate(endOfWeek)}',
                style: AppTextStyles.cardTitle,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedWeek = _selectedWeek.add(const Duration(days: 7));
              });
            },
            icon: const Icon(FontAwesomeIcons.chevronRight),
          ),
        ],
      ),
    );
  }

  Widget _buildDayProgressIndicators() {
    return Container(
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _weekDays.asMap().entries.map((entry) {
              final index = entry.key;
              final day = entry.value;
              final isSelected = index == _selectedDay;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDay = index;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      day,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _dayColors[index],
                        shape: BoxShape.circle,
                        border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
                      ),
                      child: _dayColors[index] == AppColors.success
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                          : _dayColors[index] == AppColors.warning
                              ? const Icon(Icons.access_time, size: 12, color: Colors.white)
                              : null,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayMealPlan() {
    final dayName = _weekDays[_selectedDay];
    final todayMeals = _getTodayMeals();
    
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
          Text(
            'Today - ${_getDayName(_selectedDay)}',
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: AppTheme.spacing20),
          
          ...todayMeals.map((meal) => _buildMealCard(meal)).toList(),
        ],
      ),
    );
  }

  Widget _buildMealCard(Map<String, dynamic> meal) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                meal['icon'],
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                '${meal['name']} (${meal['time']})',
                style: AppTextStyles.cardTitle.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          ...meal['items'].map<Widget>((item) {
            return Padding(
              padding: const EdgeInsets.only(left: 28, bottom: 4),
              child: Row(
                children: [
                  Text('• ${item['name']}', style: AppTextStyles.bodyMedium),
                  const Spacer(),
                  if (item['completed'])
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 16,
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _generateNewPlan,
            icon: const Icon(FontAwesomeIcons.wandMagicSparkles),
            label: const Text('Generate Plan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _viewGroceryList,
            icon: const Icon(FontAwesomeIcons.listCheck),
            label: const Text('Grocery List'),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }

  String _getDayName(int dayIndex) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[dayIndex];
  }

  List<Map<String, dynamic>> _getTodayMeals() {
    return [
      {
        'name': 'Breakfast',
        'time': '8:00 AM',
        'icon': FontAwesomeIcons.sun,
        'items': [
          {'name': 'Oats with berries', 'completed': true},
          {'name': 'Green tea', 'completed': true},
        ],
      },
      {
        'name': 'Lunch',
        'time': '1:00 PM',
        'icon': FontAwesomeIcons.sun,
        'items': [
          {'name': 'Quinoa salad', 'completed': false},
          {'name': 'Grilled vegetables', 'completed': false},
        ],
      },
      {
        'name': 'Dinner',
        'time': '7:00 PM',
        'icon': FontAwesomeIcons.moon,
        'items': [
          {'name': 'Lentil soup', 'completed': false},
          {'name': 'Whole wheat roti', 'completed': false},
        ],
      },
    ];
  }

  void _showMealPlanOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(FontAwesomeIcons.plus),
              title: const Text('Add Custom Meal'),
              onTap: () {
                Navigator.pop(context);
                // Add custom meal logic
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.copy),
              title: const Text('Copy Previous Week'),
              onTap: () {
                Navigator.pop(context);
                // Copy previous week logic
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.share),
              title: const Text('Share Meal Plan'),
              onTap: () {
                Navigator.pop(context);
                // Share meal plan logic
              },
            ),
          ],
        ),
      ),
    );
  }

  void _generateNewPlan() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generate New Plan'),
        content: const Text('This will replace your current meal plan. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Generate new plan logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New meal plan generated!')),
              );
            },
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }

  void _viewGroceryList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GroceryListScreen(),
      ),
    );
  }
}

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groceryItems = [
      {'name': 'Oats', 'category': 'Grains', 'checked': true},
      {'name': 'Mixed berries', 'category': 'Fruits', 'checked': true},
      {'name': 'Quinoa', 'category': 'Grains', 'checked': false},
      {'name': 'Bell peppers', 'category': 'Vegetables', 'checked': false},
      {'name': 'Lentils', 'category': 'Legumes', 'checked': false},
      {'name': 'Whole wheat flour', 'category': 'Grains', 'checked': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [
          IconButton(
            onPressed: () {
              // Share grocery list
            },
            icon: const Icon(FontAwesomeIcons.share),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          return Card(
            child: CheckboxListTile(
              title: Text(item['name'] as String),
              subtitle: Text(item['category'] as String),
              value: item['checked'] as bool,
              onChanged: (value) {
                // Handle checkbox change
              },
            ),
          );
        },
      ),
    );
  }
} 