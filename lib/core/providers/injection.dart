import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local_data_source.dart';
import '../../data/repositories/blog_repository_impl.dart';
import '../../data/repositories/destination_repository_impl.dart';
import '../../data/repositories/hotel_repository_impl.dart';
import '../../domain/repositories/blog_repository.dart';
import '../../domain/repositories/destination_repository.dart';
import '../../domain/repositories/hotel_repository.dart';
import '../../domain/usecases/get_all_destinations.dart';
import '../../domain/usecases/get_blog_posts.dart';
import '../../domain/usecases/get_hotels_by_destination.dart';
import '../../domain/usecases/get_trending_hotels.dart';

// Data Sources
final localDataSourceProvider = Provider((ref) => LocalDataSource());

// Repositories
final hotelRepositoryProvider = Provider<HotelRepository>((ref) {
  return HotelRepositoryImpl(ref.watch(localDataSourceProvider));
});

final destinationRepositoryProvider = Provider<DestinationRepository>((ref) {
  return DestinationRepositoryImpl(ref.watch(localDataSourceProvider));
});

final blogRepositoryProvider = Provider<BlogRepository>((ref) {
  return BlogRepositoryImpl(ref.watch(localDataSourceProvider));
});

// Use Cases
final getHotelsByDestinationProvider = Provider((ref) {
  return GetHotelsByDestination(ref.watch(hotelRepositoryProvider));
});

final getTrendingHotelsProvider = Provider((ref) {
  return GetTrendingHotels(ref.watch(hotelRepositoryProvider));
});

final getAllDestinationsProvider = Provider((ref) {
  return GetAllDestinations(ref.watch(destinationRepositoryProvider));
});

final getBlogPostsProvider = Provider((ref) {
  return GetBlogPosts(ref.watch(blogRepositoryProvider));
});
