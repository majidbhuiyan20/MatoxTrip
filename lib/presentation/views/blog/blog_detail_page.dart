import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/blog_viewmodel.dart';
import '../../widgets/common/app_drawer.dart';
import '../../widgets/common/navbar_widget.dart';
import '../../widgets/common/footer_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class BlogDetailPage extends ConsumerStatefulWidget {
  final String slug;

  const BlogDetailPage({super.key, required this.slug});

  @override
  ConsumerState<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends ConsumerState<BlogDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(blogViewModelProvider.notifier).loadPostBySlug(widget.slug));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(blogViewModelProvider);
    final horizontalPadding = MediaQuery.of(context).size.width > 1200 
        ? MediaQuery.of(context).size.width * 0.1 
        : 20.0;

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final blogPost = state.currentPost;

    if (blogPost == null) {
      return Scaffold(
        body: Column(
          children: [
            const NavbarWidget(),
            const Expanded(child: Center(child: Text('Blog post not found'))),
            const FooterWidget(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const NavbarWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            blogPost.category.toUpperCase(),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          blogPost.title,
                          style: AppTextStyles.headingLarge,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.person_outline, size: 16, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(blogPost.author, style: AppTextStyles.bodyMedium),
                            const SizedBox(width: 20),
                            const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(blogPost.date, style: AppTextStyles.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 40),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            blogPost.imageUrl,
                            width: double.infinity,
                            height: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          blogPost.content,
                          style: AppTextStyles.bodyLarge.copyWith(height: 1.8),
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
