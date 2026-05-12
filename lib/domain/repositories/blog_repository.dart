import '../entities/blog_post.dart';

abstract class BlogRepository {
  Future<List<BlogPost>> getBlogPosts();
  Future<BlogPost?> getBlogPostBySlug(String slug);
}
