import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/hotel.dart';
import '../../core/providers/injection.dart';

class HotelListState {
  final List<Hotel> allHotels;
  final List<Hotel> filteredHotels;
  final bool isLoading;
  final RangeValues priceRange;
  final List<int> selectedStars;
  final List<String> selectedAmenities;
  final String sortBy;

  HotelListState({
    this.allHotels = const [],
    this.filteredHotels = const [],
    this.isLoading = false,
    this.priceRange = const RangeValues(1000, 100000),
    this.selectedStars = const [],
    this.selectedAmenities = const [],
    this.sortBy = 'popular',
  });

  HotelListState copyWith({
    List<Hotel>? allHotels,
    List<Hotel>? filteredHotels,
    bool? isLoading,
    RangeValues? priceRange,
    List<int>? selectedStars,
    List<String>? selectedAmenities,
    String? sortBy,
  }) {
    return HotelListState(
      allHotels: allHotels ?? this.allHotels,
      filteredHotels: filteredHotels ?? this.filteredHotels,
      isLoading: isLoading ?? this.isLoading,
      priceRange: priceRange ?? this.priceRange,
      selectedStars: selectedStars ?? this.selectedStars,
      selectedAmenities: selectedAmenities ?? this.selectedAmenities,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

final hotelListViewModelProvider = StateNotifierProvider<HotelListViewModel, HotelListState>((ref) {
  return HotelListViewModel(ref);
});

class HotelListViewModel extends StateNotifier<HotelListState> {
  final Ref _ref;
  HotelListViewModel(this._ref) : super(HotelListState());

  Future<void> loadHotels(String destinationId) async {
    state = state.copyWith(isLoading: true);
    try {
      final hotels = await _ref.read(getHotelsByDestinationProvider).call(destinationId);
      state = state.copyWith(allHotels: hotels, isLoading: false);
      applyFilters();
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void applyFilters() {
    final filtered = state.allHotels.where((hotel) {
      final matchesPrice = hotel.pricePerNight >= state.priceRange.start &&
          hotel.pricePerNight <= state.priceRange.end;
      final matchesStars = state.selectedStars.isEmpty ||
          state.selectedStars.contains(hotel.starRating);
      return matchesPrice && matchesStars;
    }).toList();

    state = state.copyWith(filteredHotels: filtered);
    _sortHotels();
  }

  void _sortHotels() {
    final list = List<Hotel>.from(state.filteredHotels);
    if (state.sortBy == 'price_low') {
      list.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
    } else if (state.sortBy == 'price_high') {
      list.sort((a, b) => b.pricePerNight.compareTo(a.pricePerNight));
    }
    state = state.copyWith(filteredHotels: list);
  }

  void setSortBy(String sort) {
    state = state.copyWith(sortBy: sort);
    _sortHotels();
  }

  void updatePriceRange(RangeValues range) {
    state = state.copyWith(priceRange: range);
    applyFilters();
  }
}
