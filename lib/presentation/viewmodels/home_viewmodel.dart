import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/destination.dart';
import '../../domain/entities/hotel.dart';
import '../../domain/entities/blog_post.dart';
import '../../core/providers/injection.dart';

class HomeState {
  final List<Destination> destinations;
  final List<Hotel> trendingHotels;
  final List<BlogPost> featuredBlogs;
  final bool isLoading;
  final String searchQuery;

  HomeState({
    this.destinations = const [],
    this.trendingHotels = const [],
    this.featuredBlogs = const [],
    this.isLoading = false,
    this.searchQuery = '',
  });

  HomeState copyWith({
    List<Destination>? destinations,
    List<Hotel>? trendingHotels,
    List<BlogPost>? featuredBlogs,
    bool? isLoading,
    String? searchQuery,
  }) {
    return HomeState(
      destinations: destinations ?? this.destinations,
      trendingHotels: trendingHotels ?? this.trendingHotels,
      featuredBlogs: featuredBlogs ?? this.featuredBlogs,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(ref);
});

class HomeViewModel extends StateNotifier<HomeState> {
  final Ref _ref;
  
  HomeViewModel(this._ref) : super(HomeState());

  Future<void> loadHomeData() async {
    state = state.copyWith(isLoading: true);

    try {
      final destinations = await _ref.read(getAllDestinationsProvider).call();
      final trendingHotels = await _ref.read(getTrendingHotelsProvider).call();
      final allBlogs = await _ref.read(getBlogPostsProvider).call();
      
      state = state.copyWith(
        destinations: destinations,
        trendingHotels: trendingHotels,
        featuredBlogs: allBlogs.where((blog) => blog.isFeatured).toList(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void onSearchChanged(String query) {
    state = state.copyWith(searchQuery: query);
  }
}
