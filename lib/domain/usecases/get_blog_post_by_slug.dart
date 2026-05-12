import '../entities/blog_post.dart';
import '../repositories/blog_repository.dart';

class GetBlogPostBySlug {
  final BlogRepository repository;

  GetBlogPostBySlug(this.repository);

  Future<BlogPost?> call(String slug) async {
    final posts = await repository.getBlogPosts();
    try {
      return posts.firstWhere((post) => post.slug == slug);
    } catch (e) {
      return null;
    }
  }
}
