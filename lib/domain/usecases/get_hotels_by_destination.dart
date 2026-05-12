import '../entities/hotel.dart';
import '../repositories/hotel_repository.dart';

class GetHotelsByDestination {
  final HotelRepository repository;

  GetHotelsByDestination(this.repository);

  Future<List<Hotel>> call(String destinationId) async {
    return await repository.getHotelsByDestination(destinationId);
  }
}
