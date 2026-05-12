import '../../domain/entities/hotel.dart';

class HotelModel extends Hotel {
  const HotelModel({
    required super.id,
    required super.name,
    required super.location,
    required super.destinationId,
    required super.rating,
    required super.reviewCount,
    required super.starRating,
    required super.pricePerNight,
    required super.originalPrice,
    required super.affiliateUrl,
    required super.imageUrl,
    required super.images,
    required super.description,
    required super.amenities,
    required super.isTopDeal,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      destinationId: json['destinationId'],
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      starRating: json['starRating'],
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      originalPrice: json['originalPrice'],
      affiliateUrl: json['affiliateUrl'],
      imageUrl: json['imageUrl'],
      images: List<String>.from(json['images']),
      description: json['description'],
      amenities: List<String>.from(json['amenities']),
      isTopDeal: json['isTopDeal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'destinationId': destinationId,
      'rating': rating,
      'reviewCount': reviewCount,
      'starRating': starRating,
      'pricePerNight': pricePerNight,
      'originalPrice': originalPrice,
      'affiliateUrl': affiliateUrl,
      'imageUrl': imageUrl,
      'images': images,
      'description': description,
      'amenities': amenities,
      'isTopDeal': isTopDeal,
    };
  }

  HotelModel copyWith({
    String? id,
    String? name,
    String? location,
    String? destinationId,
    double? rating,
    int? reviewCount,
    int? starRating,
    double? pricePerNight,
    String? originalPrice,
    String? affiliateUrl,
    String? imageUrl,
    List<String>? images,
    String? description,
    List<String>? amenities,
    bool? isTopDeal,
  }) {
    return HotelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      destinationId: destinationId ?? this.destinationId,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      starRating: starRating ?? this.starRating,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      originalPrice: originalPrice ?? this.originalPrice,
      affiliateUrl: affiliateUrl ?? this.affiliateUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      description: description ?? this.description,
      amenities: amenities ?? this.amenities,
      isTopDeal: isTopDeal ?? this.isTopDeal,
    );
  }
}
