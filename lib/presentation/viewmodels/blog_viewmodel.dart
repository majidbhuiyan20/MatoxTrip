import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/blog_post.dart';
import '../../core/providers/injection.dart';

class BlogState {
  final List<BlogPost> blogPosts;
  final BlogPost? currentPost;
  final bool isLoading;

  BlogState({
    this.blogPosts = const [],
    this.currentPost,
    this.isLoading = false,
  });

  BlogState copyWith({
    List<BlogPost>? blogPosts,
    BlogPost? currentPost,
    bool? isLoading,
  }) {
    return BlogState(
      blogPosts: blogPosts ?? this.blogPosts,
      currentPost: currentPost ?? this.currentPost,
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

  Future<void> loadPostBySlug(String slug) async {
    state = state.copyWith(isLoading: true, currentPost: null);
    try {
      final post = await _ref.read(getBlogPostBySlugProvider).call(slug);
      state = state.copyWith(currentPost: post, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  List<BlogPost> get featuredPosts =>
      state.blogPosts.where((post) => post.isFeatured).toList();
}
