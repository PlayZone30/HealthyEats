import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _mealReminders = true;
  bool _progressUpdates = true;
  bool _healthTips = false;
  String _selectedLanguage = 'English';
  String _weightUnit = 'kg';
  String _volumeUnit = 'ml';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showHelp,
            icon: const Icon(FontAwesomeIcons.circleQuestion),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile section
            FadeInDown(
              child: _buildProfileSection(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // Health conditions
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _buildHealthConditionsSection(),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Notifications
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: _buildNotificationsSection(),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Units & Preferences
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: _buildUnitsSection(),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Language
            FadeInUp(
              delay: const Duration(milliseconds: 800),
              child: _buildLanguageSection(),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Data & Privacy
            FadeInUp(
              delay: const Duration(milliseconds: 1000),
              child: _buildDataPrivacySection(),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            // App info
            FadeInUp(
              delay: const Duration(milliseconds: 1200),
              child: _buildAppInfoSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
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
                FontAwesomeIcons.user,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'Profile',
                style: AppTextStyles.cardTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.user,
                  color: AppColors.textOnPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DummyData.sampleUser.name,
                      style: AppTextStyles.h4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${DummyData.sampleUser.age} years old',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _editProfile,
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthConditionsSection() {
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
                    FontAwesomeIcons.heartPulse,
                    color: AppColors.error,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Health Conditions',
                    style: AppTextStyles.cardTitle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: _manageConditions,
                child: const Text('Manage'),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing12),
          
          ...DummyData.sampleUser.healthConditions.map((condition) => 
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Text(
                    condition,
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSection() {
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
                    FontAwesomeIcons.bell,
                    color: AppColors.warning,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Notifications',
                    style: AppTextStyles.cardTitle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: _notificationSettings,
                child: const Text('Settings'),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          _buildSwitchTile(
            'Meal reminders',
            _mealReminders,
            (value) => setState(() => _mealReminders = value),
          ),
          _buildSwitchTile(
            'Progress updates',
            _progressUpdates,
            (value) => setState(() => _progressUpdates = value),
          ),
          _buildSwitchTile(
            'Health tips',
            _healthTips,
            (value) => setState(() => _healthTips = value),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitsSection() {
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
                    FontAwesomeIcons.ruler,
                    color: AppColors.accent,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Units & Preferences',
                    style: AppTextStyles.cardTitle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: _changeUnits,
                child: const Text('Change'),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          Row(
            children: [
              Expanded(
                child: _buildUnitItem('Weight', _weightUnit),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildUnitItem('Volume', _volumeUnit),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection() {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.language,
                color: AppColors.secondary,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'Language',
                style: AppTextStyles.cardTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                _selectedLanguage,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              TextButton(
                onPressed: _changeLanguage,
                child: const Text('Change'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataPrivacySection() {
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
                FontAwesomeIcons.shield,
                color: AppColors.success,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'Data & Privacy',
                style: AppTextStyles.cardTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _exportData,
                  icon: const Icon(FontAwesomeIcons.download, size: 16),
                  label: const Text('Export Data'),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _privacyPolicy,
                  icon: const Icon(FontAwesomeIcons.fileContract, size: 16),
                  label: const Text('Privacy Policy'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoSection() {
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
                FontAwesomeIcons.mobileScreen,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'App Information',
                style: AppTextStyles.cardTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing16),
          
          _buildInfoRow('Version', '1.0.0'),
          _buildInfoRow('Build', '100'),
          _buildInfoRow('Last Updated', 'Jan 15, 2024'),
          
          const SizedBox(height: AppTheme.spacing16),
          
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _aboutApp,
                  child: const Text('About'),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _contactSupport,
                  child: const Text('Support'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium,
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildUnitItem(String label, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          unit,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
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
    );
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );
  }

  void _manageConditions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HealthConditionsScreen(),
      ),
    );
  }

  void _notificationSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationSettingsScreen(),
      ),
    );
  }

  void _changeUnits() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Units & Preferences',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppTheme.spacing16),
            ListTile(
              title: const Text('Weight Units'),
              subtitle: Text(_weightUnit),
              trailing: const Icon(FontAwesomeIcons.chevronRight),
              onTap: () => _selectWeightUnit(),
            ),
            ListTile(
              title: const Text('Volume Units'),
              subtitle: Text(_volumeUnit),
              trailing: const Icon(FontAwesomeIcons.chevronRight),
              onTap: () => _selectVolumeUnit(),
            ),
          ],
        ),
      ),
    );
  }

  void _selectWeightUnit() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Weight Units'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Kilograms (kg)'),
              value: 'kg',
              groupValue: _weightUnit,
              onChanged: (value) {
                setState(() => _weightUnit = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Pounds (lbs)'),
              value: 'lbs',
              groupValue: _weightUnit,
              onChanged: (value) {
                setState(() => _weightUnit = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectVolumeUnit() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Volume Units'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Milliliters (ml)'),
              value: 'ml',
              groupValue: _volumeUnit,
              onChanged: (value) {
                setState(() => _volumeUnit = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Fluid Ounces (fl oz)'),
              value: 'fl oz',
              groupValue: _volumeUnit,
              onChanged: (value) {
                setState(() => _volumeUnit = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Cups'),
              value: 'cups',
              groupValue: _volumeUnit,
              onChanged: (value) {
                setState(() => _volumeUnit = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Spanish'),
              value: 'Spanish',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('French'),
              value: 'French',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _exportData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('Your health data will be exported as a PDF file. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data export started...')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _privacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PrivacyPolicyScreen(),
      ),
    );
  }

  void _aboutApp() {
    showAboutDialog(
      context: context,
      applicationName: 'HealthyEats',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        FontAwesomeIcons.appleWhole,
        color: AppColors.primary,
        size: 32,
      ),
      children: [
        const Text('Personalized nutrition for your health needs.'),
      ],
    );
  }

  void _contactSupport() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Contact Support',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppTheme.spacing16),
            ListTile(
              leading: const Icon(FontAwesomeIcons.envelope),
              title: const Text('Email Support'),
              subtitle: const Text('support@healthyeats.com'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.phone),
              title: const Text('Phone Support'),
              subtitle: const Text('1-800-HEALTHY'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.comment),
              title: const Text('Live Chat'),
              subtitle: const Text('Available 24/7'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HelpScreen(),
      ),
    );
  }
}

// Placeholder screens
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: const Center(child: Text('Edit Profile Screen Coming Soon')),
    );
  }
}

class HealthConditionsScreen extends StatelessWidget {
  const HealthConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Conditions')),
      body: const Center(child: Text('Health Conditions Screen Coming Soon')),
    );
  }
}

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: const Center(child: Text('Notification Settings Screen Coming Soon')),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const Center(child: Text('Privacy Policy Screen Coming Soon')),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: const Center(child: Text('Help Screen Coming Soon')),
    );
  }
} 