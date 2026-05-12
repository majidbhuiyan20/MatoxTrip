import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../domain/entities/hotel.dart';

class HotelCardWidget extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback? onTap;

  const HotelCardWidget({
    super.key,
    required this.hotel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColors.white,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/hotels/${hotel.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top: Hotel Image (16:9)
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: hotel.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: AppColors.surface),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.surface,
                      child: const Icon(Icons.hotel, color: AppColors.textHint),
                    ),
                  ),
                ),
                // Great Deal Badge
                if (hotel.isTopDeal)
                  Positioned(
                    top: 10,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: const BoxDecoration(
                        color: AppColors.deal,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Great Deal',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Name (bold, #333)
                  Text(
                    hotel.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Location with Pin Icon (#0071C2)
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: AppColors.primaryLight),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          hotel.location,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primaryLight,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Star Rating Row + Review Score Badge (blue pill #003580)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < hotel.starRating ? Icons.star : Icons.star_border,
                            size: 14,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                      _ReviewBadge(rating: hotel.rating, reviewCount: hotel.reviewCount),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Amenity Chips (max 3, then +X more)
                  _buildAmenities(),
                  
                  const Divider(height: 24, color: AppColors.divider),
                  
                  // Bottom Section: Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Starting from',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                          ),
                          Text(
                            'BDT ${hotel.pricePerNight.toStringAsFixed(0)}',
                            style: AppTextStyles.priceStyle.copyWith(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Check Deal Button (#006CE4, full width)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryButton,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Check Deal',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenities() {
    final displayAmenities = hotel.amenities.take(3).toList();
    final remainingCount = hotel.amenities.length - 3;

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        ...displayAmenities.map((amenity) => _AmenityChip(label: amenity)),
        if (remainingCount > 0) _AmenityChip(label: '+$remainingCount more'),
      ],
    );
  }
}

class _ReviewBadge extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const _ReviewBadge({required this.rating, required this.reviewCount});

  String get _ratingLabel {
    if (rating >= 9.0) return 'Exceptional';
    if (rating >= 8.5) return 'Excellent';
    if (rating >= 8.0) return 'Very Good';
    if (rating >= 7.0) return 'Good';
    return 'Good';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _ratingLabel,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '$reviewCount reviews',
              style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _AmenityChip extends StatelessWidget {
  final String label;

  const _AmenityChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(fontSize: 10, color: AppColors.success),
      ),
    );
  }
}
