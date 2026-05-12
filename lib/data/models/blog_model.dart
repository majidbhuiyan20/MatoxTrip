import '../../domain/entities/blog_post.dart';

class BlogModel extends BlogPost {
  const BlogModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.category,
    required super.content,
    required super.excerpt,
    required super.imageUrl,
    required super.author,
    required super.date,
    required super.readTimeMinutes,
    required super.isFeatured,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      category: json['category'],
      content: json['content'],
      excerpt: json['excerpt'],
      imageUrl: json['imageUrl'],
      author: json['author'],
      date: json['date'],
      readTimeMinutes: json['readTimeMinutes'],
      isFeatured: json['isFeatured'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'category': category,
      'content': content,
      'excerpt': excerpt,
      'imageUrl': imageUrl,
      'author': author,
      'date': date,
      'readTimeMinutes': readTimeMinutes,
      'isFeatured': isFeatured,
    };
  }
}
