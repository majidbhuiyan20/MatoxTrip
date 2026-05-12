import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/blog_post.dart';
import '../../core/providers/injection.dart';

class BlogState {
  final List<BlogPost> blogPosts;
  final bool isLoading;

  BlogState({
    this.blogPosts = const [],
    this.isLoading = false,
  });

  BlogState copyWith({
    List<BlogPost>? blogPosts,
    bool? isLoading,
  }) {
    return BlogState(
      blogPosts: blogPosts ?? this.blogPosts,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final blogViewModelProvider = StateNotifierProvider<BlogViewModel, BlogState>((ref) {
  return BlogViewModel(ref);
});

class BlogViewModel extends StateNotifier<BlogState> {
  final Ref _ref;
  BlogViewModel(this._ref) : super(BlogState());

  Future<void> loadBlogPosts() async {
    state = state.copyWith(isLoading: true);

    try {
      final posts = await _ref.read(getBlogPostsProvider).call();
      state = state.copyWith(blogPosts: posts, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  List<BlogPost> get featuredPosts =>
      state.blogPosts.where((post) => post.isFeatured).toList();
}
