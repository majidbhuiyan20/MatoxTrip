import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/hotel_detail_viewmodel.dart';
import '../../widgets/common/navbar_widget.dart';
import '../../widgets/common/footer_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HotelDetailPage extends ConsumerStatefulWidget {
  final String hotelId;

  const HotelDetailPage({super.key, required this.hotelId});

  @override
  ConsumerState<HotelDetailPage> createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends ConsumerState<HotelDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(hotelDetailViewModelProvider.notifier).loadHotel(widget.hotelId));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hotelDetailViewModelProvider);
    final horizontalPadding = MediaQuery.of(context).size.width > 1200 
        ? MediaQuery.of(context).size.width * 0.1 
        : 20.0;

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.hotel == null) {
      return const Scaffold(body: Center(child: Text('Hotel not found')));
    }

    final hotel = state.hotel!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavbarWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hotel.name, style: AppTextStyles.headingLarge),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppColors.primaryLight),
                      const SizedBox(width: 4),
                      Text(hotel.location, style: AppTextStyles.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Simple placeholder for detail content
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Icon(Icons.image, size: 100, color: Colors.grey)),
                  ),
                  const SizedBox(height: 40),
                  Text('Description', style: AppTextStyles.headingMedium),
                  const SizedBox(height: 10),
                  Text(hotel.description, style: AppTextStyles.bodyLarge),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => ref.read(hotelDetailViewModelProvider.notifier).openAffiliateLink(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryButton,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      ),
                      child: const Text('Book Now'),
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
}
