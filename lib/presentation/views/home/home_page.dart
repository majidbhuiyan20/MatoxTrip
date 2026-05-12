import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../widgets/common/app_drawer.dart';
import '../../widgets/common/navbar_widget.dart';
import '../../widgets/hotel_card_widget.dart';
import '../../widgets/blog_card_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load data on startup
    Future.microtask(() =>
        ref.read(homeViewModelProvider.notifier).loadHomeData());
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.go('/hotels?search=$query');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const NavbarWidget(),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroSection(),
                        _buildDestinationCarousel(state),
                        _buildTrendingSection(state),
                        _buildFeaturedBlogsSection(state),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCarousel(HomeState state) {
    if (state.destinations.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width > 900 
                  ? MediaQuery.of(context).size.width * 0.1 
                  : 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Explore Popular Destinations', style: AppTextStyles.headingMedium),
                const SizedBox(height: 4),
                Text('Hand-picked destinations for your next escape', style: AppTextStyles.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 24),
          CarouselSlider(
            options: CarouselOptions(
              height: 300,
              aspectRatio: 16/9,
              viewportFraction: MediaQuery.of(context).size.width > 900 ? 0.3 : 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
            items: state.destinations.map((destination) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () => context.go('/destinations/${destination.slug}'),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: destination.imageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    destination.name,
                                    style: AppTextStyles.headingSmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Starting from BDT ${destination.startingPrice}',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBlogsSection(HomeState state) {
    if (state.featuredBlogs.isEmpty) return const SizedBox.shrink();

    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : MediaQuery.of(context).size.width * 0.1,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Featured Stories', style: AppTextStyles.headingMedium),
          const SizedBox(height: 4),
          Text('Get inspiration for your next trip with our latest travel guides',
              style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),
          LayoutBuilder(builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 1200
                ? 3
                : constraints.maxWidth > 800
                    ? 2
                    : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.featuredBlogs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.85,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
              ),
              itemBuilder: (context, index) {
                final blog = state.featuredBlogs[index];
                return BlogCardWidget(
                  blogPost: blog,
                  onTap: () => context.go('/blog/${blog.slug}'),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Column(
        children: [
          Text(
            'Find your next stay',
            style: AppTextStyles.headingLarge.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Search deals on hotels, homes, and much more...',
            style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          // Search Bar
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: (_) => _handleSearch(),
                      decoration: const InputDecoration(
                        hintText: 'Where are you going?',
                        prefixIcon: Icon(Icons.bed, color: AppColors.textHint),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryButton,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: const Text('Search'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection(HomeState state) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : MediaQuery.of(context).size.width * 0.1,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending Deals', style: AppTextStyles.headingMedium),
          const SizedBox(height: 4),
          Text('Most popular choices for travelers from Bangladesh',
              style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),
          // Horizontal or Grid list based on width
          LayoutBuilder(builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 1200
                ? 4
                : constraints.maxWidth > 800
                    ? 3
                    : constraints.maxWidth > 600
                        ? 2
                        : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.trendingHotels.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final hotel = state.trendingHotels[index];
                return HotelCardWidget(
                  hotel: hotel,
                  onTap: () => context.go('/hotels/${hotel.id}'),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
