import '../entities/hotel.dart';

abstract class HotelRepository {
  Future<List<Hotel>> getHotelsByDestination(String destinationId);
  Future<Hotel?> getHotelById(String id);
  Future<List<Hotel>> getTrendingHotels();
  Future<List<Hotel>> getAllHotels();
}
