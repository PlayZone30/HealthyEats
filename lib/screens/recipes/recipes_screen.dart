import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Healthy Recipes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Show saved recipes
            },
            icon: const Icon(FontAwesomeIcons.bookmark),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
                suffixIcon: IconButton(
                  onPressed: () {
                    // Show filters
                  },
                  icon: const Icon(FontAwesomeIcons.sliders),
                ),
              ),
            ),
          ),
          
          // Recommended Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
            child: Row(
              children: [
                Text(
                  'Recommended for Diabetes:',
                  style: AppTextStyles.h4,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Show all
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
          ),
          
          // Recipes List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
              itemCount: DummyData.sampleRecipes.length,
              itemBuilder: (context, index) {
                final recipe = DummyData.sampleRecipes[index];
                return FadeInUp(
                  duration: Duration(milliseconds: 600 + (index * 100)),
                  child: RecipeCard(recipe: recipe),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.success.withOpacity(0.3),
                  AppColors.success.withOpacity(0.1),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.cardRadius),
                topRight: Radius.circular(AppTheme.cardRadius),
              ),
            ),
            child: const Center(
              child: Icon(
                FontAwesomeIcons.utensils,
                size: 48,
                color: AppColors.success,
              ),
            ),
          ),
          
          // Recipe Details
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['name'],
                  style: AppTextStyles.cardTitle,
                ),
                const SizedBox(height: AppTheme.spacing8),
                
                // Rating and Reviews
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < recipe['rating'].floor()
                              ? FontAwesomeIcons.solidStar
                              : FontAwesomeIcons.star,
                          size: 12,
                          color: AppColors.warning,
                        );
                      }),
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Text(
                      '${recipe['rating']} (${recipe['reviews']} reviews)',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.spacing8),
                
                // Time and Servings
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.clock,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppTheme.spacing4),
                    Text(
                      recipe['prepTime'],
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(width: AppTheme.spacing16),
                    Icon(
                      FontAwesomeIcons.users,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppTheme.spacing4),
                    Text(
                      '${recipe['servings']} servings',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.spacing12),
                
                // Tags
                Wrap(
                  spacing: AppTheme.spacing8,
                  runSpacing: AppTheme.spacing4,
                  children: (recipe['tags'] as List<String>).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing8,
                        vertical: AppTheme.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.chipRadius),
                      ),
                      child: Text(
                        tag,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 