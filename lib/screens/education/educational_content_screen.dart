import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';

class EducationalContentScreen extends StatefulWidget {
  const EducationalContentScreen({super.key});

  @override
  State<EducationalContentScreen> createState() => _EducationalContentScreenState();
}

class _EducationalContentScreenState extends State<EducationalContentScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ['All', 'Diabetes', 'PCOS', 'Nutrition', 'Exercise'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Learn & Understand'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showSearchDialog,
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category tabs
          FadeInDown(
            child: _buildCategoryTabs(),
          ),
          
          // Content list
          Expanded(
            child: FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _buildContentList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_categories.length, (index) {
            final isSelected = index == _selectedCategory;
            return Padding(
              padding: const EdgeInsets.only(right: AppTheme.spacing8),
              child: FilterChip(
                selected: isSelected,
                label: Text(_categories[index]),
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = index;
                  });
                },
                backgroundColor: AppColors.surfaceColor,
                selectedColor: AppColors.primary.withOpacity(0.1),
                labelStyle: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : AppColors.borderLight,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildContentList() {
    final contentItems = _getFilteredContent();
    
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      itemCount: contentItems.length,
      itemBuilder: (context, index) {
        final item = contentItems[index];
        return FadeInUp(
          delay: Duration(milliseconds: 100 * index),
          child: _buildContentCard(item),
        );
      },
    );
  }

  Widget _buildContentCard(Map<String, dynamic> item) {
    final typeColor = _getTypeColor(item['type']);
    final typeIcon = _getTypeIcon(item['type']);

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
      child: InkWell(
        onTap: () => _openContent(item),
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        child: Container(
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
              // Header with type badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing8,
                      vertical: AppTheme.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          typeIcon,
                          size: 12,
                          color: typeColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item['type'].toUpperCase(),
                          style: AppTextStyles.caption.copyWith(
                            color: typeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${item['duration']} min read',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacing12),
              
              // Title and description
              Text(
                item['title'],
                style: AppTextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: AppTheme.spacing8),
              
              Text(
                item['description'],
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: AppTheme.spacing16),
              
              // Tags and action
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: AppTheme.spacing8,
                      children: item['tags'].map<Widget>((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacing8,
                            vertical: AppTheme.spacing4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tag,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        item['type'] == 'video' ? 'Watch Now' : 'Read More',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing4),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        size: 12,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredContent() {
    final allContent = [
      {
        'type': 'article',
        'title': 'Why These Foods Help',
        'description': 'Understanding the science behind our recommendations',
        'duration': 5,
        'category': 'Nutrition',
        'tags': ['Science', 'Nutrition', 'Research'],
      },
      {
        'type': 'guide',
        'title': 'Diabetes Diet Basics',
        'description': 'Complete guide to eating right with diabetes',
        'duration': 10,
        'category': 'Diabetes',
        'tags': ['Diabetes', 'Diet', 'Beginner'],
      },
      {
        'type': 'video',
        'title': 'Video Tutorials',
        'description': 'Cooking demos and tips',
        'duration': 15,
        'category': 'All',
        'tags': ['Cooking', 'Tips', 'Video'],
      },
      {
        'type': 'article',
        'title': 'PCOS and Nutrition',
        'description': 'How diet affects PCOS symptoms and management',
        'duration': 8,
        'category': 'PCOS',
        'tags': ['PCOS', 'Hormones', 'Diet'],
      },
      {
        'type': 'guide',
        'title': 'Understanding Glycemic Index',
        'description': 'Learn how foods affect your blood sugar levels',
        'duration': 7,
        'category': 'Diabetes',
        'tags': ['Glycemic Index', 'Blood Sugar', 'Education'],
      },
      {
        'type': 'video',
        'title': 'Meal Prep for Health Conditions',
        'description': 'Step-by-step meal preparation videos',
        'duration': 20,
        'category': 'All',
        'tags': ['Meal Prep', 'Cooking', 'Health'],
      },
      {
        'type': 'article',
        'title': 'Exercise and Nutrition',
        'description': 'How to fuel your workouts with the right foods',
        'duration': 6,
        'category': 'Exercise',
        'tags': ['Exercise', 'Pre-workout', 'Post-workout'],
      },
    ];

    if (_selectedCategory == 0) {
      return allContent;
    }

    final selectedCategory = _categories[_selectedCategory];
    return allContent.where((item) => 
      item['category'] == selectedCategory || 
      (item['tags'] != null && item['tags'].contains(selectedCategory))
    ).toList();
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'article':
        return AppColors.primary;
      case 'video':
        return AppColors.error;
      case 'guide':
        return AppColors.success;
      default:
        return AppColors.secondary;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'article':
        return FontAwesomeIcons.fileLines;
      case 'video':
        return FontAwesomeIcons.play;
      case 'guide':
        return FontAwesomeIcons.book;
      default:
        return FontAwesomeIcons.circleInfo;
    }
  }

  void _openContent(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContentDetailScreen(item: item),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Content'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Search articles, videos, guides...',
            prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            // Implement search functionality
          },
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

class ContentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const ContentDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(item['title']),
        actions: [
          IconButton(
            onPressed: () {
              // Share content
            },
            icon: const Icon(FontAwesomeIcons.share),
          ),
          IconButton(
            onPressed: () {
              // Bookmark content
            },
            icon: const Icon(FontAwesomeIcons.bookmark),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content header
            FadeInDown(
              child: _buildContentHeader(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Content body
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _buildContentBody(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Related content
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: _buildRelatedContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentHeader() {
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8,
                  vertical: AppTheme.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item['type'].toUpperCase(),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${item['duration']} min read',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          Text(
            item['title'],
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: AppTheme.spacing8),
          
          Text(
            item['description'],
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          // Tags
          Wrap(
            spacing: AppTheme.spacing8,
            children: item['tags'].map<Widget>((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8,
                  vertical: AppTheme.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContentBody() {
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
          if (item['type'] == 'video') ...[
            // Video placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.play,
                      size: 48,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: AppTheme.spacing8),
                    Text(
                      'Video Content',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
          ],
          
          // Content text
          Text(
            _getContentText(),
            style: AppTextStyles.bodyLarge.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Content',
          style: AppTextStyles.h4.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        
        // Related items
        ...List.generate(3, (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
            padding: const EdgeInsets.all(AppTheme.spacing12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.fileLines,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppTheme.spacing8),
                Expanded(
                  child: Text(
                    'Related Article ${index + 1}',
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
                Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  String _getContentText() {
    switch (item['title']) {
      case 'Why These Foods Help':
        return '''
The foods we recommend are based on scientific research and evidence-based nutritional guidelines. Each recommendation takes into account:

• Glycemic index and load
• Nutrient density
• Anti-inflammatory properties
• Fiber content
• Antioxidant levels

Understanding these factors helps you make informed decisions about your diet and manage your health condition more effectively.
        ''';
      case 'Diabetes Diet Basics':
        return '''
Managing diabetes through diet involves understanding how different foods affect your blood sugar levels. Key principles include:

• Focus on whole, unprocessed foods
• Monitor carbohydrate intake
• Include plenty of fiber
• Choose healthy fats
• Stay hydrated

The goal is to maintain stable blood sugar levels throughout the day while getting all the nutrients your body needs.
        ''';
      default:
        return '''
This is sample content for ${item['title']}. In a real application, this would contain the full article or guide content with detailed information, tips, and actionable advice.

The content would be tailored to the specific topic and provide valuable insights for users managing their health conditions through nutrition.
        ''';
    }
  }
} 