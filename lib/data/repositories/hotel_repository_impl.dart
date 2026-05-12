import '../../domain/entities/hotel.dart';
import '../../domain/repositories/hotel_repository.dart';
import '../datasources/local_data_source.dart';

class HotelRepositoryImpl implements HotelRepository {
  final LocalDataSource localDataSource;

  HotelRepositoryImpl(this.localDataSource);

  @override
  Future<List<Hotel>> getHotelsByDestination(String destinationId) async {
    return localDataSource
        .getHotels()
        .where((hotel) => hotel.destinationId == destinationId)
        .toList();
  }

  @override
  Future<Hotel?> getHotelById(String id) async {
    try {
      return localDataSource.getHotels().firstWhere((hotel) => hotel.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Hotel>> getTrendingHotels() async {
    return localDataSource
        .getHotels()
        .where((hotel) => hotel.isTopDeal)
        .toList();
  }

  @override
  Future<List<Hotel>> getAllHotels() async {
    return localDataSource.getHotels();
  }
}
