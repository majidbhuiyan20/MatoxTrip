import '../entities/hotel.dart';
import '../repositories/hotel_repository.dart';

class GetAllHotels {
  final HotelRepository repository;

  GetAllHotels(this.repository);

  Future<List<Hotel>> call() async {
    return await repository.getAllHotels();
  }
}
