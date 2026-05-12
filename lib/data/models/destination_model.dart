import '../../domain/entities/destination.dart';

class DestinationModel extends Destination {
  const DestinationModel({
    required super.id,
    required super.name,
    required super.country,
    required super.description,
    required super.hotelCount,
    required super.imageUrl,
    required super.slug,
    required super.heroImageUrl,
    required super.startingPrice,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      description: json['description'],
      hotelCount: json['hotelCount'],
      imageUrl: json['imageUrl'],
      slug: json['slug'],
      heroImageUrl: json['heroImageUrl'],
      startingPrice: json['startingPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'description': description,
      'hotelCount': hotelCount,
      'imageUrl': imageUrl,
      'slug': slug,
      'heroImageUrl': heroImageUrl,
      'startingPrice': startingPrice,
    };
  }
}
