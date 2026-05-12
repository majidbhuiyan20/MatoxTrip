import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/hotel_list_viewmodel.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class FilterSidebarWidget extends ConsumerWidget {
  const FilterSidebarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hotelListViewModelProvider);
    final viewModel = ref.read(hotelListViewModelProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filters', style: AppTextStyles.headingMedium),
              TextButton(
                onPressed: viewModel.clearFilters,
                child: const Text('Clear all'),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          
          // Price Range
          Text('Price per night', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
          RangeSlider(
            values: state.priceRange,
            min: 0,
            max: 100000,
            divisions: 20,
            activeColor: AppColors.primary,
            labels: RangeLabels(
              '৳${state.priceRange.start.round()}',
              '৳${state.priceRange.end.round()}',
            ),
            onChanged: (values) => viewModel.updatePriceRange(values),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('৳${state.priceRange.start.round()}'),
              Text('৳${state.priceRange.end.round()}'),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Star Rating
          Text('Star Rating', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...[5, 4, 3, 2, 1].map((star) => CheckboxListTile(
            title: Row(
              children: List.generate(star, (index) => const Icon(Icons.star, color: AppColors.accent, size: 18)),
            ),
            value: state.selectedStars.contains(star),
            onChanged: (val) => viewModel.toggleStarRating(star),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
          )),

          const SizedBox(height: 24),

          // Amenities
          Text('Amenities', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...['WiFi', 'Pool', 'Breakfast', 'Parking', 'AC', 'Gym'].map((amenity) => CheckboxListTile(
            title: Text(amenity),
            value: state.selectedAmenities.contains(amenity),
            onChanged: (val) => viewModel.toggleAmenity(amenity),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
          )),
        ],
      ),
    );
  }
}
