import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/center_dashboard/top_navigation.dart';
import '../../providers/dashboard_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _emailNotifications = true;
  bool _biometricAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopNavigation(title: 'Settings'),
              const SizedBox(height: 20),
              
              // Settings Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  boxShadow: AppConstants.softShadows,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account & Preferences',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Customize your workspace environment, notification thresholds, and security measures.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    _buildSwitchTile('Email Notifications', 'Receive daily digest summaries and employee check-in logs.', _emailNotifications, (val) {
                      setState(() => _emailNotifications = val);
                    }),
                    const Divider(color: Color(0xFFF4F7FE), height: 24),
                    Consumer(
                      builder: (context, ref, child) {
                        final themeMode = ref.watch(themeModeProvider);
                        final isDark = themeMode == ThemeMode.dark;
                        return _buildSwitchTile(
                          'Dark Mode Theme',
                          'Activate premium high-contrast dark visual interfaces.',
                          isDark,
                          (val) {
                            ref.read(themeModeProvider.notifier).state =
                                val ? ThemeMode.dark : ThemeMode.light;
                          },
                        );
                      },
                    ),
                    const Divider(color: Color(0xFFF4F7FE), height: 24),
                    _buildSwitchTile('Biometric Sign-In', 'Ensure high-end security using fingerprint or face scanner.', _biometricAuth, (val) {
                      setState(() => _biometricAuth = val);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: AppConstants.primaryColor,
        ),
      ],
    );
  }
}
