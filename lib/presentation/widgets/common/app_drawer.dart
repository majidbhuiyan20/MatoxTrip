import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/logo.png',
                    height: 50,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.travel_explore,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'MatoxTrip',
                    style: AppTextStyles.headingSmall.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            onTap: () => context.go('/'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.bed,
            title: 'Stays',
            onTap: () => context.go('/destinations/all'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.article,
            title: 'Blog',
            onTap: () => context.go('/blog'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.contact_support,
            title: 'Contact Us',
            onTap: () => context.go('/contact'),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Version 1.0.0',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        onTap();
      },
    );
  }
}
