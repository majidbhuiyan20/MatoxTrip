class Hotel {
  final String id;
  final String name;
  final String location;
  final String destinationId;
  final double rating;
  final int reviewCount;
  final int starRating;
  final double pricePerNight;
  final String originalPrice; // for showing discount
  final String affiliateUrl;
  final String imageUrl;
  final List<String> images;
  final String description;
  final List<String> amenities;
  final bool isTopDeal;

  const Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.destinationId,
    required this.rating,
    required this.reviewCount,
    required this.starRating,
    required this.pricePerNight,
    required this.originalPrice,
    required this.affiliateUrl,
    required this.imageUrl,
    required this.images,
    required this.description,
    required this.amenities,
    required this.isTopDeal,
  });
}
