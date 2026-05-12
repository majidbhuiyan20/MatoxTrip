import '../entities/hotel.dart';
import '../repositories/hotel_repository.dart';

class GetTrendingHotels {
  final HotelRepository repository;

  GetTrendingHotels(this.repository);

  Future<List<Hotel>> call() async {
    return await repository.getTrendingHotels();
  }
}
