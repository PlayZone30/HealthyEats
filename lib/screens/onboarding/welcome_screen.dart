import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import 'profile_setup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: Column(
              children: [
                const Spacer(flex: 2),
                
                // App Logo and Title
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.textOnPrimary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.appleWhole,
                          size: 60,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing24),
                      Text(
                        '🍎 HealthyEats',
                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.textOnPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppTheme.spacing32),
                
                // Tagline
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    '"Eat Smart, Live Better"',
                    style: AppTextStyles.h4.copyWith(
                      color: AppColors.textOnPrimary.withOpacity(0.9),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: AppTheme.spacing24),
                
                // Description
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 400),
                  child: Text(
                    'Personalized nutrition for\nyour health needs',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textOnPrimary.withOpacity(0.8),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const Spacer(flex: 3),
                
                // Features Preview
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.all(AppTheme.spacing20),
                    decoration: BoxDecoration(
                      color: AppColors.textOnPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                      border: Border.all(
                        color: AppColors.textOnPrimary.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildFeatureItem(
                          icon: FontAwesomeIcons.userDoctor,
                          text: 'AI-powered health recommendations',
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        _buildFeatureItem(
                          icon: FontAwesomeIcons.camera,
                          text: 'Smart food identification',
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        _buildFeatureItem(
                          icon: FontAwesomeIcons.chartLine,
                          text: 'Track your progress',
                        ),
                      ],
                    ),
                  ),
                ),
                
                const Spacer(flex: 2),
                
                // Action Buttons
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 800),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                    const ProfileSetupScreen(),
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
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textOnPrimary,
                            foregroundColor: AppColors.primary,
                            elevation: 4,
                            shadowColor: AppColors.textOnPrimary.withOpacity(0.3),
                          ),
                          child: const Text('Get Started'),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigate to sign in
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textOnPrimary,
                            side: const BorderSide(
                              color: AppColors.textOnPrimary,
                              width: 1.5,
                            ),
                          ),
                          child: const Text('Sign In'),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppTheme.spacing24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.textOnPrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.textOnPrimary,
          ),
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textOnPrimary.withOpacity(0.9),
            ),
          ),
        ),
      ],
    );
  }
} 