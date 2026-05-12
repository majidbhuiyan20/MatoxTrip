import '../entities/destination.dart';
import '../repositories/destination_repository.dart';

class GetAllDestinations {
  final DestinationRepository repository;

  GetAllDestinations(this.repository);

  Future<List<Destination>> call() async {
    return await repository.getAllDestinations();
  }
}
