import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/progress_indicator_widget.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String _selectedPeriod = 'This Month';
  final List<String> _periods = ['This Week', 'This Month', 'Last 3 Months', 'This Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Your Progress'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
            },
            itemBuilder: (context) => _periods.map((period) {
              return PopupMenuItem(
                value: period,
                child: Text(period),
              );
            }).toList(),
            child: const Icon(FontAwesomeIcons.calendar),
          ),
          IconButton(
            onPressed: _shareProgress,
            icon: const Icon(FontAwesomeIcons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period selector
            FadeInDown(
              child: _buildPeriodSelector(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Diet adherence card
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _buildDietAdherenceCard(),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Blood sugar trends
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: _buildBloodSugarTrendsCard(),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Goals achieved
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: _buildGoalsAchievedCard(),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Weekly overview
            FadeInUp(
              delay: const Duration(milliseconds: 800),
              child: _buildWeeklyOverviewCard(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Action buttons
            FadeInUp(
              delay: const Duration(milliseconds: 1000),
              child: _buildActionButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
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
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.chartLine,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                _selectedPeriod,
                style: AppTextStyles.h3,
              ),
            ],
          ),
          Text(
            'Jan 2024',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietAdherenceCard() {
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
                FontAwesomeIcons.appleWhole,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'Diet Adherence',
                style: AppTextStyles.cardTitle,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          
          // Progress bar
          ProgressIndicatorWidget(
            progress: 0.78,
            text: 'Diet Adherence',
            color: AppColors.primary,
            height: 8,
          ),
          
          const SizedBox(height: AppTheme.spacing12),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Target: 80%',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8,
                  vertical: AppTheme.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '2% to target',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBloodSugarTrendsCard() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.chartLine,
                    color: AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Blood Sugar Trends',
                    style: AppTextStyles.cardTitle,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8,
                  vertical: AppTheme.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      FontAwesomeIcons.arrowDown,
                      size: 12,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Improving',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          
          // Mini chart
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 140),
                      const FlSpot(1, 135),
                      const FlSpot(2, 130),
                      const FlSpot(3, 125),
                      const FlSpot(4, 120),
                      const FlSpot(5, 125),
                      const FlSpot(6, 118),
                    ],
                    isCurved: true,
                    color: AppColors.success,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.success.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacing12),
          
          Text(
            'Avg: 125 mg/dL',
            style: AppTextStyles.h4.copyWith(
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsAchievedCard() {
    final goals = [
      {'name': '5 servings vegetables', 'completed': true, 'icon': FontAwesomeIcons.carrot},
      {'name': 'No refined sugar', 'completed': true, 'icon': FontAwesomeIcons.ban},
      {'name': '8 glasses water', 'completed': false, 'icon': FontAwesomeIcons.glassWater, 'progress': '6/8'},
      {'name': '30 min exercise', 'completed': true, 'icon': FontAwesomeIcons.dumbbell},
    ];

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
                FontAwesomeIcons.bullseye,
                color: AppColors.secondary,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'Goals Achieved',
                style: AppTextStyles.cardTitle,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          
          ...goals.map((goal) => _buildGoalItem(goal)),
        ],
      ),
    );
  }

  Widget _buildGoalItem(Map<String, dynamic> goal) {
    final isCompleted = goal['completed'] as bool;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
      child: Row(
        children: [
          Icon(
            isCompleted ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.clock,
            color: isCompleted ? AppColors.success : AppColors.warning,
            size: 16,
          ),
          const SizedBox(width: AppTheme.spacing12),
          Icon(
            goal['icon'],
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              goal['name'],
              style: AppTextStyles.bodyMedium.copyWith(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
              ),
            ),
          ),
          if (goal['progress'] != null)
            Text(
              goal['progress'],
              style: AppTextStyles.caption.copyWith(
                color: AppColors.warning,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWeeklyOverviewCard() {
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
                FontAwesomeIcons.calendarWeek,
                color: AppColors.accent,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'Weekly Overview',
                style: AppTextStyles.cardTitle,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          
          // Weekly stats
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Good Days', '5/7', AppColors.success),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildStatItem('Avg Score', '82%', AppColors.primary),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildStatItem('Streak', '12 days', AppColors.secondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h4.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailedReportScreen(),
                ),
              );
            },
            icon: const Icon(FontAwesomeIcons.fileLines),
            label: const Text('Detailed Report'),
          ),
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _shareProgress,
            icon: const Icon(FontAwesomeIcons.share),
            label: const Text('Share'),
          ),
        ),
      ],
    );
  }

  void _shareProgress() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(FontAwesomeIcons.userDoctor),
              title: const Text('Share with Doctor'),
              onTap: () {
                Navigator.pop(context);
                // Share with doctor logic
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.users),
              title: const Text('Share with Family'),
              onTap: () {
                Navigator.pop(context);
                // Share with family logic
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.download),
              title: const Text('Export as PDF'),
              onTap: () {
                Navigator.pop(context);
                // Export as PDF logic
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailedReportScreen extends StatelessWidget {
  const DetailedReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detailed Report'),
        actions: [
          IconButton(
            onPressed: () {
              // Export report
            },
            icon: const Icon(FontAwesomeIcons.download),
          ),
        ],
      ),
      body: const Center(
        child: Text('Detailed Report Coming Soon'),
      ),
    );
  }
} 