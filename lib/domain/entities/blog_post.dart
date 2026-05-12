class BlogPost {
  final String id;
  final String title;
  final String slug;
  final String category;
  final String content;
  final String excerpt;
  final String imageUrl;
  final String author;
  final String date;
  final int readTimeMinutes;
  final bool isFeatured;

  const BlogPost({
    required this.id,
    required this.title,
    required this.slug,
    required this.category,
    required this.content,
    required this.excerpt,
    required this.imageUrl,
    required this.author,
    required this.date,
    required this.readTimeMinutes,
    required this.isFeatured,
  });
}
