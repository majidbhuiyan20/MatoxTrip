import '../../domain/entities/destination.dart';
import '../../domain/repositories/destination_repository.dart';
import '../datasources/local_data_source.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final LocalDataSource localDataSource;

  DestinationRepositoryImpl(this.localDataSource);

  @override
  Future<List<Destination>> getAllDestinations() async {
    return localDataSource.getDestinations();
  }

  @override
  Future<Destination?> getDestinationBySlug(String slug) async {
    try {
      return localDataSource
          .getDestinations()
          .firstWhere((dest) => dest.slug == slug);
    } catch (_) {
      return null;
    }
  }
}
