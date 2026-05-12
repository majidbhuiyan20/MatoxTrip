import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/hotel_list_viewmodel.dart';
import '../../widgets/common/navbar_widget.dart';
import '../../widgets/common/footer_widget.dart';
import '../../widgets/hotel_card_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HotelListPage extends ConsumerStatefulWidget {
  final String destinationSlug;

  const HotelListPage({super.key, required this.destinationSlug});

  @override
  ConsumerState<HotelListPage> createState() => _HotelListPageState();
}

class _HotelListPageState extends ConsumerState<HotelListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(hotelListViewModelProvider.notifier).loadHotels(widget.destinationSlug));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hotelListViewModelProvider);
    final horizontalPadding = MediaQuery.of(context).size.width > 1200 
        ? MediaQuery.of(context).size.width * 0.1 
        : 20.0;

    return Scaffold(
      backgroundColor: AppColors.white,
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
                    'Hotels in ${widget.destinationSlug.replaceAll('-', ' ').toUpperCase()}',
                    style: AppTextStyles.headingLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${state.filteredHotels.length} properties found',
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state.filteredHotels.isEmpty)
                    const Center(child: Text('No hotels found matching your criteria.'))
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.filteredHotels.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return HotelCardWidget(
                          hotel: state.filteredHotels[index],
                          onTap: () {
                            // Navigation to detail page is handled via GoRouter
                          },
                        );
                      },
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
}
