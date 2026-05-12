import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : MediaQuery.of(context).size.width * 0.1,
        vertical: 60,
      ),
      child: Column(
        children: [
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildAboutSection()),
                Expanded(child: _buildLinksSection('Support', ['Customer Service', 'Partner Help', 'Careers', 'Sustainability'])),
                Expanded(child: _buildLinksSection('Discover', ['Genius loyalty program', 'Seasonal deals', 'Travel articles', 'Booking.com for Business'])),
                Expanded(child: _buildLinksSection('Terms', ['Privacy & Cookie Statement', 'Terms & Conditions', 'Grievance Officer'])),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAboutSection(),
                const SizedBox(height: 40),
                _buildLinksSection('Support', ['Customer Service', 'Partner Help', 'Careers']),
                const SizedBox(height: 20),
                _buildLinksSection('Discover', ['Seasonal deals', 'Travel articles']),
              ],
            ),
          const Divider(color: Colors.white24, height: 80),
          Text(
            'Copyright © 2023 MatoxTrip™. All rights reserved.',
            style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.travel_explore, color: Colors.white, size: 30),
            const SizedBox(width: 10),
            Text(
              'MatoxTrip',
              style: AppTextStyles.headingSmall.copyWith(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'MatoxTrip.com is part of Matox Holdings Inc., the world leader in online travel & related services.',
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildLinksSection(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            link,
            style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
          ),
        )),
      ],
    );
  }
}
