import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../widgets/animated_button.dart';
import 'scan_results_screen.dart';
import 'food_search_screen.dart';

class FoodScannerScreen extends StatefulWidget {
  const FoodScannerScreen({super.key});

  @override
  State<FoodScannerScreen> createState() => _FoodScannerScreenState();
}

class _FoodScannerScreenState extends State<FoodScannerScreen> {
  bool _isScanning = false;

  void _simulateScan() {
    setState(() {
      _isScanning = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isScanning = false;
      });
      _showScanResults();
    });
  }

  void _showScanResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanResultsScreen(
          scannedFood: {
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
            'recommendations': [
              'Perfect for diabetes management',
              'Rich in lycopene and antioxidants',
              'Low glycemic index',
              'Helps with hydration',
            ],
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Food Scanner'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Show help
            },
            icon: const Icon(FontAwesomeIcons.circleQuestion),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: const BoxDecoration(
              color: AppColors.cardBackground,
              border: Border(
                bottom: BorderSide(color: AppColors.borderLight),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FoodSearchScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing16,
                  vertical: AppTheme.spacing12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppTheme.inputRadius),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 18,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    Text(
                      'Search for any food...',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Camera Preview Area
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                border: Border.all(
                  color: AppColors.borderLight,
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  // Simulated camera view
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppTheme.cardRadius - 2),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.textLight.withOpacity(0.1),
                          AppColors.textLight.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.camera,
                            size: 80,
                            color: AppColors.textLight.withOpacity(0.6),
                          ),
                          const SizedBox(height: AppTheme.spacing16),
                          Text(
                            'Point camera at food',
                            style: AppTextStyles.h4.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Scanning overlay
                  if (_isScanning)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppTheme.cardRadius - 2),
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                      child: const Center(
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
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  // Scan target overlay
                  if (!_isScanning)
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            // Corner indicators
                            ...List.generate(4, (index) {
                              return Positioned(
                                top: index < 2 ? 0 : null,
                                bottom: index >= 2 ? 0 : null,
                                left: index % 2 == 0 ? 0 : null,
                                right: index % 2 == 1 ? 0 : null,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.only(
                                      topLeft: index == 0 ? const Radius.circular(17) : Radius.zero,
                                      topRight: index == 1 ? const Radius.circular(17) : Radius.zero,
                                      bottomLeft: index == 2 ? const Radius.circular(17) : Radius.zero,
                                      bottomRight: index == 3 ? const Radius.circular(17) : Radius.zero,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Action Buttons
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacing24),
              child: Column(
                children: [
                  // Scan Button
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: AnimatedButton(
                      onPressed: _isScanning ? null : _simulateScan,
                      text: _isScanning ? 'Scanning...' : 'Scan Food',
                      isLoading: _isScanning,
                      icon: FontAwesomeIcons.camera,
                    ),
                  ),
                  
                  const SizedBox(height: AppTheme.spacing16),
                  
                  // Alternative actions
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Open gallery
                            },
                            icon: const Icon(FontAwesomeIcons.image, size: 16),
                            label: const Text('Gallery'),
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FoodSearchScreen(),
                                ),
                              );
                            },
                            icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
                            label: const Text('Search Food'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Recent Scans
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 400),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: const BoxDecoration(
                color: AppColors.cardBackground,
                border: Border(
                  top: BorderSide(color: AppColors.borderLight),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Scans:',
                    style: AppTextStyles.cardTitle,
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: DummyData.recentScans.map((scan) {
                        return Container(
                          margin: const EdgeInsets.only(right: AppTheme.spacing12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacing12,
                            vertical: AppTheme.spacing8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppTheme.chipRadius),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                scan['emoji']!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: AppTheme.spacing4),
                              Text(
                                scan['name']!,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodScanResultSheet extends StatelessWidget {
  const FoodScanResultSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppTheme.cardRadius * 2),
          topRight: Radius.circular(AppTheme.cardRadius * 2),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: AppTheme.spacing12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderMedium,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: Row(
              children: [
                const Text(
                  'Scan Results',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(FontAwesomeIcons.xmark),
                ),
              ],
            ),
          ),
          
          // Food Image and Info
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Image
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                      border: Border.all(
                        color: AppColors.success.withOpacity(0.2),
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '🍅',
                            style: TextStyle(fontSize: 80),
                          ),
                          SizedBox(height: AppTheme.spacing8),
                          Text(
                            'TOMATO',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                          Text(
                            'Confidence: 95%',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppTheme.spacing24),
                  
                  // Health Assessment
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                      border: Border.all(
                        color: AppColors.success.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.circleCheck,
                              color: AppColors.success,
                              size: 20,
                            ),
                            const SizedBox(width: AppTheme.spacing8),
                            Text(
                              'SAFE TO EAT',
                              style: AppTextStyles.cardTitle.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        _buildInfoRow('📏 Recommended:', '1 medium tomato'),
                        _buildInfoRow('⏰ Best time:', 'With meals'),
                        _buildInfoRow('💡 Benefits:', 'Low sugar, high fiber'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: AppTheme.spacing24),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Add to Today'),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Learn More'),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.spacing24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
} 