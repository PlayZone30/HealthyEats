import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import 'food_search_result_screen.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  State<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  List<String> _userHealthConditions = ['diabetes']; // This would come from user profile

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final results = DummyData.foodDatabase
          .where((food) =>
              food['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
              food['category'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search Foods'),
        centerTitle: true,
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for any food...',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 18,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                _performSearch('');
                              },
                              icon: const Icon(FontAwesomeIcons.xmark, size: 16),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.inputRadius),
                        borderSide: const BorderSide(color: AppColors.borderLight),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.inputRadius),
                        borderSide: const BorderSide(color: AppColors.borderLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.inputRadius),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    onChanged: _performSearch,
                  ),
                ),
              ],
            ),
          ),

          // Search Results
          Expanded(
            child: _isSearching
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: AppTheme.spacing16),
                        Text('Searching foods...'),
                      ],
                    ),
                  )
                : _searchResults.isEmpty
                    ? _buildEmptyState()
                    : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    if (_searchController.text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUp(
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 80,
                color: AppColors.textLight.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: AppTheme.spacing20),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'Search for any food',
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Text(
                'Type the name of any food to get\npersonalized recommendations',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing32),
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: _buildQuickSearchSuggestions(),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.circleExclamation,
              size: 60,
              color: AppColors.textLight.withOpacity(0.6),
            ),
            const SizedBox(height: AppTheme.spacing16),
            Text(
              'No foods found',
              style: AppTextStyles.h4.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Try searching for fruits, vegetables,\ngrains, or proteins',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildQuickSearchSuggestions() {
    final suggestions = ['Apple', 'Broccoli', 'Salmon', 'Quinoa', 'Almonds'];
    
    return Column(
      children: [
        Text(
          'Quick suggestions:',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        Wrap(
          spacing: AppTheme.spacing8,
          runSpacing: AppTheme.spacing8,
          children: suggestions.map((suggestion) {
            return GestureDetector(
              onTap: () {
                _searchController.text = suggestion;
                _performSearch(suggestion);
              },
              child: Container(
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
                child: Text(
                  suggestion,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final food = _searchResults[index];
        final primaryCondition = _userHealthConditions.isNotEmpty 
            ? _userHealthConditions.first 
            : 'general';
        final safetyStatus = food['safetyStatus'][primaryCondition] ?? 'unknown';
        final portion = food['portions'][primaryCondition] ?? food['portions']['general'];
        final benefit = food['benefits'][primaryCondition] ?? food['benefits']['general'];

        return SlideInLeft(
          delay: Duration(milliseconds: index * 100),
          child: Container(
            margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodSearchResultScreen(
                        foodData: food,
                        userHealthConditions: _userHealthConditions,
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    children: [
                      // Food Icon
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _getSafetyColor(safetyStatus).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                        ),
                        child: Center(
                          child: Text(
                            food['emoji'],
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: AppTheme.spacing16),
                      
                      // Food Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    food['name'],
                                    style: AppTextStyles.cardTitle,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.spacing8,
                                    vertical: AppTheme.spacing4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getSafetyColor(safetyStatus).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(AppTheme.chipRadius),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        _getSafetyIcon(safetyStatus),
                                        size: 12,
                                        color: _getSafetyColor(safetyStatus),
                                      ),
                                      const SizedBox(width: AppTheme.spacing4),
                                      Text(
                                        _getSafetyText(safetyStatus),
                                        style: AppTextStyles.caption.copyWith(
                                          color: _getSafetyColor(safetyStatus),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: AppTheme.spacing4),
                            
                            Text(
                              food['category'],
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            
                            const SizedBox(height: AppTheme.spacing8),
                            
                            Text(
                              'Portion: $portion',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            const SizedBox(height: AppTheme.spacing4),
                            
                            Text(
                              benefit,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: AppTheme.spacing8),
                      
                      const Icon(
                        FontAwesomeIcons.chevronRight,
                        size: 16,
                        color: AppColors.textLight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} 