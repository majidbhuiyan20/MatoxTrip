import '../../domain/entities/blog_post.dart';
import '../../domain/repositories/blog_repository.dart';
import '../datasources/local_data_source.dart';

class BlogRepositoryImpl implements BlogRepository {
  final LocalDataSource localDataSource;

  BlogRepositoryImpl(this.localDataSource);

  @override
  Future<List<BlogPost>> getBlogPosts() async {
    return localDataSource.getBlogs();
  }

  @override
  Future<BlogPost?> getBlogPostBySlug(String slug) async {
    try {
      return localDataSource
          .getBlogs()
          .firstWhere((blog) => blog.slug == slug);
    } catch (_) {
      return null;
    }
  }
}
