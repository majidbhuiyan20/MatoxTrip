import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/blog_viewmodel.dart';
import '../../widgets/common/navbar_widget.dart';
import '../../widgets/common/footer_widget.dart';
import '../../widgets/blog_card_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class BlogListPage extends ConsumerStatefulWidget {
  const BlogListPage({super.key});

  @override
  ConsumerState<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends ConsumerState<BlogListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(blogViewModelProvider.notifier).loadBlogPosts());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(blogViewModelProvider);
    final horizontalPadding = MediaQuery.of(context).size.width > 1200 
        ? MediaQuery.of(context).size.width * 0.1 
        : 20.0;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const NavbarWidget(),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Travel Blog',
                                style: AppTextStyles.headingLarge,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Insights, tips and stories for your next adventure',
                                style: AppTextStyles.bodyLarge,
                              ),
                              const SizedBox(height: 40),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.blogPosts.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
                                  crossAxisSpacing: 24,
                                  mainAxisSpacing: 24,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (context, index) {
                                  return BlogCardWidget(
                                    blogPost: state.blogPosts[index],
                                    onTap: () {}, // Handled by widget's go_router logic
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
          ),
        ],
      ),
    );
  }
}
