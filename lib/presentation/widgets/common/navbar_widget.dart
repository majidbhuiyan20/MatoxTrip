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
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
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
                  const Icon(Icons.travel_explore, color: AppColors.white, size: 32),
                  const SizedBox(width: 8),
                  Text(
                    'MatoxTrip',
                    style: AppTextStyles.headingSmall.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Navigation Items
            if (!isMobile) ...[
              _NavLink(title: 'Stays', icon: Icons.bed, onTap: () => context.go('/hotels')),
              _NavLink(title: 'Destinations', icon: Icons.map, onTap: () {}),
              _NavLink(title: 'Blog', icon: Icons.article, onTap: () => context.go('/blog')),
              _NavLink(title: 'Contact', icon: Icons.contact_support, onTap: () => context.go('/contact')),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primary,
                ),
                child: const Text('Sign In / Register'),
              ),
            ] else
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.white),
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
            Icon(icon, color: AppColors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
