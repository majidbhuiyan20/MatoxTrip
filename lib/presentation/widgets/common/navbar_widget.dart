import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.divider, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : MediaQuery.of(context).size.width * 0.1,
        ),
        child: Row(
          children: [
            // Logo
            GestureDetector(
              onTap: () => context.go('/'),
              child: Row(
                children: [
                  const Icon(Icons.travel_explore, color: AppColors.primary, size: 32),
                  const SizedBox(width: 8),
                  Text(
                    'MatoxTrip',
                    style: AppTextStyles.headingSmall.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Navigation Items
            if (!isMobile) ...[
              _NavLink(title: 'Stays', icon: Icons.bed, onTap: () => context.go('/destinations/all')),
              _NavLink(title: 'Destinations', icon: Icons.map, onTap: () => context.go('/')),
              _NavLink(title: 'Blog', icon: Icons.article, onTap: () => context.go('/blog')),
              _NavLink(title: 'Contact', icon: Icons.contact_support, onTap: () => context.go('/contact')),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButton,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                child: const Text('Find Deals'),
              ),
            ] else
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.primary),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _NavLink({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textPrimary, size: 18),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
