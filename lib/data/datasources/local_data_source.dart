import '../models/hotel_model.dart';
import '../models/destination_model.dart';
import '../models/blog_model.dart';

class LocalDataSource {
  // Destinations Dummy Data
  List<DestinationModel> getDestinations() {
    return [
      const DestinationModel(
        id: 'cox-bazar',
        name: 'Cox\'s Bazar',
        country: 'Bangladesh',
        description: 'World\'s longest natural sea beach.',
        hotelCount: 5,
        imageUrl: 'https://images.unsplash.com/photo-1583212292454-1fe6229603b7',
        slug: 'cox-bazar',
        heroImageUrl: 'https://images.unsplash.com/photo-1583212292454-1fe6229603b7',
        startingPrice: '3,500',
      ),
      const DestinationModel(
        id: 'dubai',
        name: 'Dubai',
        country: 'UAE',
        description: 'City of gold and futuristic architecture.',
        hotelCount: 5,
        imageUrl: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c',
        slug: 'dubai',
        heroImageUrl: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c',
        startingPrice: '12,000',
      ),
      const DestinationModel(
        id: 'bangkok',
        name: 'Bangkok',
        country: 'Thailand',
        description: 'Vibrant street life and ornate shrines.',
        hotelCount: 5,
        imageUrl: 'https://images.unsplash.com/photo-1508009603885-50cf7c579367',
        slug: 'bangkok',
        heroImageUrl: 'https://images.unsplash.com/photo-1508009603885-50cf7c579367',
        startingPrice: '4,000',
      ),
    ];
  }

  // Hotels Dummy Data
  List<HotelModel> getHotels() {
    return [
      // Cox's Bazar
      _hotel('h1', 'Long Beach Hotel', 'Cox\'s Bazar', 'cox-bazar', 8.8, 1200, 5, 8500, '10,000', true),
      _hotel('h2', 'Sea Palace', 'Cox\'s Bazar', 'cox-bazar', 7.9, 850, 4, 4500, '5,500', false),
      _hotel('h3', 'Seagull Hotel', 'Cox\'s Bazar', 'cox-bazar', 8.2, 2100, 5, 7000, '9,000', true),
      _hotel('h4', 'Ocean Paradise', 'Cox\'s Bazar', 'cox-bazar', 8.5, 1500, 5, 9500, '12,000', false),
      _hotel('h5', 'The Cox Today', 'Cox\'s Bazar', 'cox-bazar', 8.0, 980, 4, 3500, '4,500', true),

      // Dubai
      _hotel('h6', 'Burj Al Arab', 'Jumeirah, Dubai', 'dubai', 9.5, 4500, 5, 85000, '100,000', true),
      _hotel('h7', 'JW Marriott Marquis', 'Business Bay, Dubai', 'dubai', 9.0, 3200, 5, 25000, '30,000', true),
      _hotel('h8', 'Atlantis The Palm', 'Palm Jumeirah, Dubai', 'dubai', 9.2, 5000, 5, 45000, '55,000', false),
      _hotel('h9', 'Holiday Inn Dubai', 'Al Barsha, Dubai', 'dubai', 8.1, 1200, 4, 12000, '15,000', false),
      _hotel('h10', 'Ibis Dubai Al Rigga', 'Deira, Dubai', 'dubai', 7.8, 2500, 3, 14000, '18,000', true),

      // Bangkok
      _hotel('h11', 'Mandarin Oriental', 'Riverside, Bangkok', 'bangkok', 9.4, 1800, 5, 35000, '45,000', true),
      _hotel('h12', 'Chatrium Hotel Riverside', 'Riverside, Bangkok', 'bangkok', 8.9, 3500, 5, 12000, '15,000', true),
      _hotel('h13', 'Ibis Bangkok Sukhumvit', 'Sukhumvit, Bangkok', 'bangkok', 7.7, 4200, 3, 4000, '5,500', false),
      _hotel('h14', 'Novotel Bangkok Platinum', 'Pratunam, Bangkok', 'bangkok', 8.5, 2800, 4, 9000, '11,000', false),
      _hotel('h15', 'Pullman Bangkok King Power', 'Rang Nam, Bangkok', 'bangkok', 8.8, 2100, 5, 11000, '14,000', true),
    ];
  }

  HotelModel _hotel(String id, String name, String loc, String dId, double r, int rc, int star, double p, String op, bool td) {
    return HotelModel(
      id: id,
      name: name,
      location: loc,
      destinationId: dId,
      rating: r,
      reviewCount: rc,
      starRating: star,
      pricePerNight: p,
      originalPrice: op,
      affiliateUrl: 'https://www.booking.com/search.html?ss=$name&aid=YOUR_AID',
      imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      images: const ['https://images.unsplash.com/photo-1566073771259-6a8506099945'],
      description: 'A luxurious stay with world-class amenities and breathtaking views.',
      amenities: const ['WiFi', 'Pool', 'Breakfast', 'Parking', 'AC', 'Gym'],
      isTopDeal: td,
    );
  }

  // Blog Dummy Data
  List<BlogModel> getBlogs() {
    return [
      const BlogModel(
        id: 'b1',
        title: 'Top 10 Things to do in Cox\'s Bazar',
        slug: 'top-10-cox-bazar',
        category: 'Travel Guide',
        content: 'Full content here...',
        excerpt: 'Discover the best activities, food, and spots in the world\'s longest beach.',
        imageUrl: 'https://images.unsplash.com/photo-1583212292454-1fe6229603b7',
        author: 'Majid',
        date: 'Oct 24, 2023',
        readTimeMinutes: 5,
        isFeatured: true,
      ),
    ];
  }
}
