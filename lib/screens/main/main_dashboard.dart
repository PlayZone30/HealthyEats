import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../widgets/health_recommendation_card.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/progress_indicator_widget.dart';
import '../food_scanner/food_scanner_screen.dart';
import '../meal_planning/meal_planning_screen.dart';
import '../recipes/recipes_screen.dart';
import '../progress/progress_screen.dart';
import '../settings/settings_screen.dart';
import '../recommendations/diabetes_management_screen.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const DashboardHome(),
    const FoodScannerScreen(),
    const RecipesScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.textLight.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.camera),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.utensils),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chartLine),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.gear),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Simulate refresh
            await Future.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: _buildHeader(),
                ),
                
                const SizedBox(height: AppTheme.spacing24),
                
                // Today's Recommendations
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 200),
                  child: _buildTodaysRecommendations(context),
                ),
                
                const SizedBox(height: AppTheme.spacing24),
                
                // Quick Actions
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 400),
                  child: _buildQuickActions(context),
                ),
                
                const SizedBox(height: AppTheme.spacing24),
                
                // This Week's Progress
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 600),
                  child: _buildWeeklyProgress(),
                ),
                
                const SizedBox(height: AppTheme.spacing24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: AppColors.primaryGradient,
            ),
          ),
          child: const Icon(
            FontAwesomeIcons.user,
            color: AppColors.textOnPrimary,
            size: 20,
          ),
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi ${DummyData.sampleUser.name.split(' ').first}',
                style: AppTextStyles.h3,
              ),
              Text(
                'Let\'s stay healthy today!',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            // Show notifications
          },
          icon: Stack(
            children: [
              const Icon(
                FontAwesomeIcons.bell,
                color: AppColors.textSecondary,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.warning,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTodaysRecommendations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Recommendations',
          style: AppTextStyles.h3,
        ),
        const SizedBox(height: AppTheme.spacing16),
        AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                HealthRecommendationCard(
                  title: 'For Diabetes Management',
                  subtitle: 'Eat these by 2 PM today',
                  icon: FontAwesomeIcons.appleWhole,
                  color: AppColors.diabetes,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DiabetesManagementScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppTheme.spacing12),
                HealthRecommendationCard(
                  title: 'For PCOS Support',
                  subtitle: 'Morning routine recommendations',
                  icon: FontAwesomeIcons.seedling,
                  color: AppColors.pcos,
                  onTap: () {
                    // Navigate to PCOS recommendations
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTextStyles.h3,
        ),
        const SizedBox(height: AppTheme.spacing16),
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.textLight.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppTheme.spacing12,
            mainAxisSpacing: AppTheme.spacing12,
            childAspectRatio: 1.5,
            children: [
              QuickActionCard(
                title: 'Scan Food',
                icon: FontAwesomeIcons.camera,
                color: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FoodScannerScreen(),
                    ),
                  );
                },
              ),
              QuickActionCard(
                title: 'Meal Plan',
                icon: FontAwesomeIcons.calendarDays,
                color: AppColors.secondary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MealPlanningScreen(),
                    ),
                  );
                },
              ),
              QuickActionCard(
                title: 'Recipes',
                icon: FontAwesomeIcons.utensils,
                color: AppColors.accent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecipesScreen(),
                    ),
                  );
                },
              ),
              QuickActionCard(
                title: 'Progress',
                icon: FontAwesomeIcons.chartLine,
                color: AppColors.success,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProgressScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This Week\'s Progress',
          style: AppTextStyles.h3,
        ),
        const SizedBox(height: AppTheme.spacing16),
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.textLight.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                  final isCompleted = DummyData.weeklyProgress[index];
                  
                  return Column(
                    children: [
                      Text(
                        days[index],
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isCompleted 
                              ? AppColors.success 
                              : AppColors.borderLight,
                          shape: BoxShape.circle,
                        ),
                        child: isCompleted
                            ? const Icon(
                                FontAwesomeIcons.check,
                                color: AppColors.textOnPrimary,
                                size: 14,
                              )
                            : null,
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: AppTheme.spacing16),
              ProgressIndicatorWidget(
                progress: 4 / 7,
                text: '4/7 days on track',
                color: AppColors.success,
              ),
            ],
          ),
        ),
      ],
    );
  }
} 