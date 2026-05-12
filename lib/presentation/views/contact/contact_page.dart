import 'package:flutter/material.dart';
import '../../widgets/common/app_drawer.dart';
import '../../widgets/common/navbar_widget.dart';
import '../../widgets/common/footer_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth > 1200 ? screenWidth * 0.1 : 20.0;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavbarWidget(),
            
            // Hero Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 80),
              color: AppColors.primary,
              child: Column(
                children: [
                  Text(
                    'Contact Us',
                    style: AppTextStyles.headingLarge.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We\'re here to help and answer any question you might have.',
                    style: AppTextStyles.bodyLarge.copyWith(color: AppColors.white.withOpacity(0.9)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 60),
              child: Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Info
                  Expanded(
                    flex: isDesktop ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Get in Touch', style: AppTextStyles.headingMedium),
                        const SizedBox(height: 30),
                        _buildContactItem(
                          Icons.location_on,
                          'Our Office',
                          'House 12, Road 5, Sector 3, Uttara, Dhaka, Bangladesh',
                        ),
                        const SizedBox(height: 24),
                        _buildContactItem(
                          Icons.email,
                          'Email Us',
                          'info@matoxtrip.com\nsupport@matoxtrip.com',
                        ),
                        const SizedBox(height: 24),
                        _buildContactItem(
                          Icons.phone,
                          'Call Us',
                          '+880 1234 567890\n+880 9876 543210',
                        ),
                        const SizedBox(height: 40),
                        Text('Follow Us', style: AppTextStyles.headingSmall),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildSocialIcon(Icons.facebook),
                            const SizedBox(width: 12),
                            _buildSocialIcon(Icons.camera_alt),
                            const SizedBox(width: 12),
                            _buildSocialIcon(Icons.alternate_email),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  if (isDesktop) const SizedBox(width: 60) else const SizedBox(height: 60),

                  // Contact Form
                  Expanded(
                    flex: isDesktop ? 1 : 0,
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Send us a Message', style: AppTextStyles.headingSmall),
                          const SizedBox(height: 24),
                          _buildTextField('Your Name', 'Enter your name'),
                          const SizedBox(height: 20),
                          _buildTextField('Your Email', 'Enter your email'),
                          const SizedBox(height: 20),
                          _buildTextField('Subject', 'Enter subject'),
                          const SizedBox(height: 20),
                          _buildTextField('Message', 'Enter your message', maxLines: 5),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryButton,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              ),
                              child: const Text(
                                'Send Message',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: AppColors.primary),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodySmall,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.border),
            ),
          ),
        ),
      ],
    );
  }
}
