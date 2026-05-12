import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/hotel_list_viewmodel.dart';
import '../../widgets/common/app_drawer.dart';
import '../../widgets/common/navbar_widget.dart';
import '../../widgets/common/footer_widget.dart';
import '../../widgets/hotel_card_widget.dart';
import '../../widgets/filter_sidebar_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HotelListPage extends ConsumerStatefulWidget {
  final String destinationSlug;
  final String? searchQuery;

  const HotelListPage({
    super.key,
    required this.destinationSlug,
    this.searchQuery,
  });

  @override
  ConsumerState<HotelListPage> createState() => _HotelListPageState();
}

class _HotelListPageState extends ConsumerState<HotelListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.destinationSlug == 'search' && widget.searchQuery != null) {
        // Implement search logic in viewmodel if needed, 
        // or just load all and filter by query
        ref.read(hotelListViewModelProvider.notifier).loadHotels('all', searchQuery: widget.searchQuery);
      } else {
        ref.read(hotelListViewModelProvider.notifier).loadHotels(widget.destinationSlug);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hotelListViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    
    final horizontalPadding = screenWidth > 1200 
        ? screenWidth * 0.1 
        : 20.0;

    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavbarWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.destinationSlug == 'search' 
                        ? 'Search Results for "${widget.searchQuery}"'
                        : 'Hotels in ${widget.destinationSlug.replaceAll('-', ' ').toUpperCase()}',
                    style: AppTextStyles.headingLarge,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${state.filteredHotels.length} properties found',
                        style: AppTextStyles.bodyMedium,
                      ),
                      _buildSortDropdown(ref),
                    ],
                  ),
                  const SizedBox(height: 30),
                  
                  if (state.isLoading)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(50.0),
                      child: CircularProgressIndicator(),
                    ))
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isDesktop)
                          const SizedBox(
                            width: 250,
                            child: FilterSidebarWidget(),
                          ),
                        if (isDesktop) const SizedBox(width: 30),
                        
                        Expanded(
                          child: Column(
                            children: [
                              if (!isDesktop) ...[
                                ElevatedButton.icon(
                                  onPressed: () => _showFilterMobile(context),
                                  icon: const Icon(Icons.filter_list),
                                  label: const Text('Filters'),
                                ),
                                const SizedBox(height: 20),
                              ],
                              
                              if (state.filteredHotels.isEmpty)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(50.0),
                                    child: Text('No hotels found matching your criteria.'),
                                  ),
                                )
                              else
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.filteredHotels.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: screenWidth > 1200 ? 3 : (screenWidth > 600 ? 2 : 1),
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.65,
                                  ),
                                  itemBuilder: (context, index) {
                                    final hotel = state.filteredHotels[index];
                                    return HotelCardWidget(
                                      hotel: hotel,
                                      onTap: () => context.go('/hotels/${hotel.id}'),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildSortDropdown(WidgetRef ref) {
    final state = ref.watch(hotelListViewModelProvider);
    return DropdownButton<String>(
      value: state.sortBy,
      underline: const SizedBox(),
      icon: const Icon(Icons.sort),
      items: const [
        DropdownMenuItem(value: 'popular', child: Text('Sort by: Popular')),
        DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
        DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
        DropdownMenuItem(value: 'rating', child: Text('Top Rated')),
      ],
      onChanged: (val) {
        if (val != null) {
          ref.read(hotelListViewModelProvider.notifier).setSortBy(val);
        }
      },
    );
  }

  void _showFilterMobile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (_, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: const FilterSidebarWidget(),
        ),
      ),
    );
  }
}
