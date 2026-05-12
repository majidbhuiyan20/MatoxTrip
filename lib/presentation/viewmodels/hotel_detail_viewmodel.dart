import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/hotel.dart';
import '../../core/providers/injection.dart';

class HotelDetailState {
  final Hotel? hotel;
  final List<Hotel> relatedHotels;
  final int selectedImageIndex;
  final bool isLoading;

  HotelDetailState({
    this.hotel,
    this.relatedHotels = const [],
    this.selectedImageIndex = 0,
    this.isLoading = false,
  });

  HotelDetailState copyWith({
    Hotel? hotel,
    List<Hotel>? relatedHotels,
    int? selectedImageIndex,
    bool? isLoading,
  }) {
    return HotelDetailState(
      hotel: hotel ?? this.hotel,
      relatedHotels: relatedHotels ?? this.relatedHotels,
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final hotelDetailViewModelProvider =
    StateNotifierProvider<HotelDetailViewModel, HotelDetailState>((ref) {
  return HotelDetailViewModel(ref);
});

class HotelDetailViewModel extends StateNotifier<HotelDetailState> {
  final Ref _ref;
  HotelDetailViewModel(this._ref) : super(HotelDetailState());

  Future<void> loadHotel(String hotelId) async {
    state = state.copyWith(isLoading: true, selectedImageIndex: 0);

    try {
      final allHotels = await _ref.read(getTrendingHotelsProvider).call();
      final hotel = allHotels.firstWhere((h) => h.id == hotelId);
      
      final relatedHotels = await _ref.read(getHotelsByDestinationProvider).call(hotel.destinationId);
      relatedHotels.removeWhere((h) => h.id == hotelId);

      state = state.copyWith(
        hotel: hotel,
        relatedHotels: relatedHotels,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> openAffiliateLink() async {
    final hotel = state.hotel;
    if (hotel == null) return;
    final url = Uri.parse(hotel.affiliateUrl);
    if (!await launchUrl(url)) {
      // Handle error
    }
  }

  void selectImage(int index) {
    state = state.copyWith(selectedImageIndex: index);
  }
}
