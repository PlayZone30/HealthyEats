import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../models/user_model.dart';
import '../main/main_dashboard.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/selection_chip.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  
  // User data
  final TextEditingController _nameController = TextEditingController();
  String _selectedAge = '';
  String _selectedGender = '';
  List<String> _selectedConditions = [];
  List<String> _selectedDietaryPreferences = [];
  List<String> _allergies = [];
  int _mealsPerDay = 3;
  String _breakfastTime = '08:00';
  String _lunchTime = '13:00';
  String _dinnerTime = '19:00';

  @override
  void dispose() {
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: AppTheme.standardAnimation,
        curve: Curves.easeInOut,
      );
    } else {
      _completeSetup();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: AppTheme.standardAnimation,
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _completeSetup() {
    final user = UserModel(
      name: _nameController.text,
      age: _getAgeFromRange(_selectedAge),
      gender: _selectedGender,
      healthConditions: _selectedConditions,
      dietaryPreferences: _selectedDietaryPreferences,
      allergies: _allergies,
      mealPreferences: MealPreferences(
        mealsPerDay: _mealsPerDay,
        breakfastTime: _breakfastTime,
        lunchTime: _lunchTime,
        dinnerTime: _dinnerTime,
      ),
    );

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainDashboard(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          
          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: AppTheme.standardAnimation,
      ),
    );
  }

  int _getAgeFromRange(String ageRange) {
    switch (ageRange) {
      case '18-24':
        return 21;
      case '25-34':
        return 29;
      case '35-50':
        return 42;
      case '51-65':
        return 58;
      case '65+':
        return 70;
      default:
        return 30;
    }
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _nameController.text.isNotEmpty &&
               _selectedAge.isNotEmpty &&
               _selectedGender.isNotEmpty;
      case 1:
        return _selectedConditions.isNotEmpty;
      case 2:
        return _selectedDietaryPreferences.isNotEmpty;
      case 3:
        return true;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: _previousStep,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('Profile Setup (${_currentStep + 1}/4)'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppTheme.spacing16),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 4,
              effect: const WormEffect(
                dotWidth: 8,
                dotHeight: 8,
                activeDotColor: AppColors.primary,
                dotColor: AppColors.borderLight,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
                _buildStep4(),
              ],
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return FadeInUp(
      duration: AppTheme.standardAnimation,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tell us about you',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppTheme.spacing32),
            
            // Name field
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(FontAwesomeIcons.user),
              ),
              onChanged: (value) => setState(() {}),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Age selection
            Text(
              'Age',
              style: AppTextStyles.cardTitle,
            ),
            const SizedBox(height: AppTheme.spacing12),
            Wrap(
              spacing: AppTheme.spacing8,
              runSpacing: AppTheme.spacing8,
              children: DummyData.ageGroups.map((age) {
                return SelectionChip(
                  label: age,
                  isSelected: _selectedAge == age,
                  onTap: () {
                    setState(() {
                      _selectedAge = age;
                    });
                  },
                );
              }).toList(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Gender selection
            Text(
              'Gender',
              style: AppTextStyles.cardTitle,
            ),
            const SizedBox(height: AppTheme.spacing12),
            Wrap(
              spacing: AppTheme.spacing8,
              runSpacing: AppTheme.spacing8,
              children: DummyData.genderOptions.map((gender) {
                return SelectionChip(
                  label: gender,
                  isSelected: _selectedGender == gender,
                  onTap: () {
                    setState(() {
                      _selectedGender = gender;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return FadeInUp(
      duration: AppTheme.standardAnimation,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Health Conditions',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppTheme.spacing16),
            Text(
              'Choose all that apply to you',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            Expanded(
              child: ListView.builder(
                itemCount: DummyData.healthConditions.length,
                itemBuilder: (context, index) {
                  final condition = DummyData.healthConditions[index];
                  final isSelected = _selectedConditions.contains(condition);
                  
                  return SlideInLeft(
                    delay: Duration(milliseconds: index * 100),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedConditions.remove(condition);
                              } else {
                                _selectedConditions.add(condition);
                              }
                            });
                          },
                          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                          child: Container(
                            padding: const EdgeInsets.all(AppTheme.spacing16),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? AppColors.primary.withOpacity(0.1)
                                  : AppColors.cardBackground,
                              border: Border.all(
                                color: isSelected 
                                    ? AppColors.primary
                                    : AppColors.borderLight,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected 
                                      ? FontAwesomeIcons.squareCheck
                                      : FontAwesomeIcons.square,
                                  color: isSelected 
                                      ? AppColors.primary
                                      : AppColors.textLight,
                                  size: 20,
                                ),
                                const SizedBox(width: AppTheme.spacing12),
                                Expanded(
                                  child: Text(
                                    condition,
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      color: isSelected 
                                          ? AppColors.primary
                                          : AppColors.textPrimary,
                                      fontWeight: isSelected 
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3() {
    return FadeInUp(
      duration: AppTheme.standardAnimation,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dietary Preferences',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            Text(
              'Dietary Type',
              style: AppTextStyles.cardTitle,
            ),
            const SizedBox(height: AppTheme.spacing12),
            Wrap(
              spacing: AppTheme.spacing8,
              runSpacing: AppTheme.spacing8,
              children: DummyData.dietaryPreferences.map((preference) {
                return SelectionChip(
                  label: preference,
                  isSelected: _selectedDietaryPreferences.contains(preference),
                  onTap: () {
                    setState(() {
                      if (_selectedDietaryPreferences.contains(preference)) {
                        _selectedDietaryPreferences.remove(preference);
                      } else {
                        _selectedDietaryPreferences.add(preference);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            
            const SizedBox(height: AppTheme.spacing32),
            
            Text(
              'Known Allergies',
              style: AppTextStyles.cardTitle,
            ),
            const SizedBox(height: AppTheme.spacing12),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Add allergies (e.g., nuts, dairy, gluten)',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty && !_allergies.contains(value)) {
                        setState(() {
                          _allergies.add(value);
                        });
                      }
                    },
                  ),
                  if (_allergies.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.spacing12),
                    Wrap(
                      spacing: AppTheme.spacing8,
                      runSpacing: AppTheme.spacing8,
                      children: _allergies.map((allergy) {
                        return Chip(
                          label: Text(allergy),
                          deleteIcon: const Icon(Icons.close, size: 16),
                          onDeleted: () {
                            setState(() {
                              _allergies.remove(allergy);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep4() {
    return FadeInUp(
      duration: AppTheme.standardAnimation,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meal Preferences',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            Text(
              'How many meals per day?',
              style: AppTextStyles.cardTitle,
            ),
            const SizedBox(height: AppTheme.spacing12),
            Row(
              children: [
                Expanded(
                  child: SelectionChip(
                    label: '3 meals',
                    isSelected: _mealsPerDay == 3,
                    onTap: () => setState(() => _mealsPerDay = 3),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing8),
                Expanded(
                  child: SelectionChip(
                    label: '4-5 meals',
                    isSelected: _mealsPerDay == 4,
                    onTap: () => setState(() => _mealsPerDay = 4),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing8),
                Expanded(
                  child: SelectionChip(
                    label: '6+ meals',
                    isSelected: _mealsPerDay == 6,
                    onTap: () => setState(() => _mealsPerDay = 6),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacing32),
            
            Text(
              'Preferred meal times:',
              style: AppTextStyles.cardTitle,
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            _buildTimeSelector('Breakfast', _breakfastTime, (time) {
              setState(() => _breakfastTime = time);
            }),
            const SizedBox(height: AppTheme.spacing12),
            _buildTimeSelector('Lunch', _lunchTime, (time) {
              setState(() => _lunchTime = time);
            }),
            const SizedBox(height: AppTheme.spacing12),
            _buildTimeSelector('Dinner', _dinnerTime, (time) {
              setState(() => _dinnerTime = time);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector(String label, String time, Function(String) onTimeChanged) {
    return InkWell(
      onTap: () async {
        final TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
            hour: int.parse(time.split(':')[0]),
            minute: int.parse(time.split(':')[1]),
          ),
        );
        
        if (selectedTime != null) {
          final formattedTime = '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
          onTimeChanged(formattedTime);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$label:',
              style: AppTextStyles.bodyLarge,
            ),
            Row(
              children: [
                Text(
                  time,
                  style: AppTextStyles.cardTitle.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing8),
                const Icon(
                  FontAwesomeIcons.clock,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing24),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(color: AppColors.borderLight),
        ),
      ),
      child: AnimatedButton(
        onPressed: _canProceed() ? _nextStep : null,
        text: _currentStep == 3 ? 'Complete' : 'Next',
        isEnabled: _canProceed(),
      ),
    );
  }
} 