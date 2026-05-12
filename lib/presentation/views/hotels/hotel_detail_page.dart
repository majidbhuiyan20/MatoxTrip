import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/hotel.dart';
import '../../viewmodels/hotel_detail_viewmodel.dart';
import '../../widgets/common/app_drawer.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavbarWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs / Title
                  Row(
                    children: [
                      Text('Hotels', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryLight)),
                      const Icon(Icons.chevron_right, size: 16, color: AppColors.textSecondary),
                      Text(hotel.destinationId.toUpperCase(), style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryLight)),
                      const Icon(Icons.chevron_right, size: 16, color: AppColors.textSecondary),
                      Expanded(child: Text(hotel.name, style: AppTextStyles.bodyMedium, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  Flex(
                    direction: isDesktop ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: isDesktop ? 1 : 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text('Hotel', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 8),
                                ...List.generate(hotel.starRating, (index) => const Icon(Icons.star, color: AppColors.accent, size: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(hotel.name, style: isDesktop ? AppTextStyles.headingLarge : AppTextStyles.headingMedium),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 18, color: AppColors.primaryLight),
                                const SizedBox(width: 4),
                                Expanded(child: Text(hotel.location, style: AppTextStyles.bodyMedium)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (!isDesktop) const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: isDesktop ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: isDesktop ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  const Text('Excellent', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('${hotel.reviewCount} reviews', style: AppTextStyles.bodySmall),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  hotel.rating.toString(),
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),

                  // Image Gallery
                  Flex(
                    direction: isDesktop ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: isDesktop ? 2 : 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            hotel.images[state.selectedImageIndex],
                            height: isDesktop ? 450 : 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (isDesktop) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 450,
                            child: GridView.builder(
                              itemCount: hotel.images.length > 5 ? 5 : hotel.images.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => ref.read(hotelDetailViewModelProvider.notifier).selectImage(index),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.network(hotel.images[index], fit: BoxFit.cover),
                                        if (index == 4 && hotel.images.length > 5)
                                          Container(
                                            color: Colors.black54,
                                            child: Center(
                                              child: Text(
                                                '+${hotel.images.length - 5}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ] else ...[
                         const SizedBox(height: 10),
                         SizedBox(
                           height: 80,
                           child: ListView.builder(
                             scrollDirection: Axis.horizontal,
                             itemCount: hotel.images.length,
                             itemBuilder: (context, index) {
                               return GestureDetector(
                                 onTap: () => ref.read(hotelDetailViewModelProvider.notifier).selectImage(index),
                                 child: Container(
                                   width: 80,
                                   margin: const EdgeInsets.only(right: 10),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(4),
                                     border: Border.all(
                                       color: state.selectedImageIndex == index ? AppColors.primary : Colors.transparent,
                                       width: 2,
                                     ),
                                   ),
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(2),
                                     child: Image.network(hotel.images[index], fit: BoxFit.cover),
                                   ),
                                 ),
                               );
                             },
                           ),
                         ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Content Layout
                  Flex(
                    direction: isDesktop ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: isDesktop ? 2 : 0,
                        child: _buildHotelDescription(hotel),
                      ),
                      
                      if (isDesktop) const SizedBox(width: 40) else const SizedBox(height: 30),
                      
                      // Booking Card
                      Expanded(
                        flex: isDesktop ? 1 : 0,
                        child: _buildBookingCard(hotel, ref),
                      ),
                    ],
                  ),
                  
                  // Related Hotels
                  if (state.relatedHotels.isNotEmpty) ...[
                    const SizedBox(height: 60),
                    Text('Recommended properties nearby', style: AppTextStyles.headingMedium),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.relatedHotels.length,
                        itemBuilder: (context, index) {
                          final related = state.relatedHotels[index];
                          return Container(
                            width: 280,
                            margin: const EdgeInsets.only(right: 20),
                            child: InkWell(
                              onTap: () => context.go('/hotels/${related.id}'),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(related.imageUrl, height: 180, width: 280, fit: BoxFit.cover),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(related.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  Text(related.location, style: AppTextStyles.bodySmall),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4)),
                                        child: Text(related.rating.toString(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('Excellent', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 4),
                                      Text('· ${related.reviewCount} reviews', style: AppTextStyles.bodySmall),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Starting from ৳${related.pricePerNight.round()}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelDescription(Hotel hotel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: AppTextStyles.headingMedium),
        const SizedBox(height: 16),
        Text(hotel.description, style: AppTextStyles.bodyLarge),
        const SizedBox(height: 30),
        Text('Most popular facilities', style: AppTextStyles.headingSmall),
        const SizedBox(height: 16),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: hotel.amenities.map((amenity) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check, color: AppColors.success, size: 20),
              const SizedBox(width: 8),
              Text(amenity),
            ],
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildBookingCard(Hotel hotel, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryLight.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Price starts from', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '৳${hotel.pricePerNight.round()}',
                style: AppTextStyles.headingLarge.copyWith(color: AppColors.primary),
              ),
              const Text(' / night'),
            ],
          ),
          if (hotel.originalPrice.isNotEmpty)
            Text(
              '৳${hotel.originalPrice}',
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: AppColors.textSecondary,
              ),
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => ref.read(hotelDetailViewModelProvider.notifier).openAffiliateLink(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButton,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text('Check Availability', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.flash_on, color: AppColors.success, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'It takes only 2 minutes',
                  style: TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
