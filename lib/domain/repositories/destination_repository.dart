import '../entities/destination.dart';

abstract class DestinationRepository {
  Future<List<Destination>> getAllDestinations();
  Future<Destination?> getDestinationBySlug(String slug);
}
