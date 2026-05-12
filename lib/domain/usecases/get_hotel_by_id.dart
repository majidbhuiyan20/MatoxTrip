import '../entities/hotel.dart';
import '../repositories/hotel_repository.dart';

class GetHotelById {
  final HotelRepository repository;

  GetHotelById(this.repository);

  Future<Hotel?> call(String id) async {
    final hotels = await repository.getTrendingHotels();
    // This is a temporary solution since we are using local dummy data.
    // In a real app, the repository would have a specific getHotelById method.
    try {
      return hotels.firstWhere((hotel) => hotel.id == id);
    } catch (e) {
      return null;
    }
  }
}
