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
      const DestinationModel(
        id: 'bali',
        name: 'Bali',
        country: 'Indonesia',
        description: 'Tropical paradise with lush jungles and beaches.',
        hotelCount: 8,
        imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
        slug: 'bali',
        heroImageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
        startingPrice: '6,500',
      ),
      const DestinationModel(
        id: 'paris',
        name: 'Paris',
        country: 'France',
        description: 'The city of light, romance, and culture.',
        hotelCount: 12,
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
        slug: 'paris',
        heroImageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
        startingPrice: '15,000',
      ),
      const DestinationModel(
        id: 'maldives',
        name: 'Maldives',
        country: 'Maldives',
        description: 'Luxury overwater villas and crystal clear waters.',
        hotelCount: 6,
        imageUrl: 'https://images.unsplash.com/photo-1514282401047-d79a71a590e8',
        slug: 'maldives',
        heroImageUrl: 'https://images.unsplash.com/photo-1514282401047-d79a71a590e8',
        startingPrice: '25,000',
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

      // Bali
      _hotel('h16', 'Ayana Resort', 'Jimbaran, Bali', 'bali', 9.2, 2800, 5, 28000, '35,000', true),
      _hotel('h17', 'The Kayon Jungle Resort', 'Ubud, Bali', 'bali', 9.6, 1500, 5, 32000, '40,000', true),
      _hotel('h18', 'Hard Rock Hotel Bali', 'Kuta, Bali', 'bali', 8.4, 4500, 4, 12000, '15,000', false),
      _hotel('h19', 'Padma Resort Ubud', 'Ubud, Bali', 'bali', 9.3, 1200, 5, 22000, '28,000', true),
      _hotel('h20', 'Grand Hyatt Bali', 'Nusa Dua, Bali', 'bali', 8.7, 3100, 5, 18000, '22,000', false),

      // Paris
      _hotel('h21', 'The Ritz Paris', 'Place Vendôme, Paris', 'paris', 9.8, 800, 5, 150000, '180,000', true),
      _hotel('h22', 'Pullman Paris Tour Eiffel', 'Trocadéro, Paris', 'paris', 8.8, 5200, 4, 35000, '45,000', true),
      _hotel('h23', 'Hotel Lutetia', 'Saint-Germain-des-Prés, Paris', 'paris', 9.4, 1100, 5, 85000, '100,000', false),
      _hotel('h24', 'Ibis Paris Tour Eiffel', 'Grenelle, Paris', 'paris', 7.5, 8500, 3, 15000, '20,000', false),
      _hotel('h25', 'Shangri-La Paris', 'Trocadéro, Paris', 'paris', 9.5, 950, 5, 120000, '150,000', true),

      // Maldives
      _hotel('h26', 'Soneva Fushi', 'Kunfunadhoo Island, Maldives', 'maldives', 9.7, 450, 5, 250000, '300,000', true),
      _hotel('h27', 'Kuramathi Maldives', 'Rasdhoo Atoll, Maldives', 'maldives', 9.1, 3200, 4, 45000, '55,000', true),
      _hotel('h28', 'Conrad Maldives Rangali Island', 'South Ari Atoll, Maldives', 'maldives', 9.3, 1800, 5, 85000, '110,000', false),
      _hotel('h29', 'Adaaran Prestige Vadoo', 'South Male Atoll, Maldives', 'maldives', 8.9, 1200, 5, 65000, '80,000', true),
      _hotel('h30', 'Bandos Maldives', 'North Male Atoll, Maldives', 'maldives', 8.5, 5600, 4, 25000, '35,000', false),
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
        content: 'Cox\'s Bazar is a town on the southeast coast of Bangladesh. It\'s known for its very long, sandy beachfront, stretching from Sea Beach in the north to Kolatoli Beach in the south. Aggameda Khyang monastery is home to bronze statues and old Buddhist manuscripts. South of town, the tropical rainforest of Himchari National Park has waterfalls and many birds. North of town, Kutubdia Island has a lighthouse and salt farms.',
        excerpt: 'Discover the best activities, food, and spots in the world\'s longest beach.',
        imageUrl: 'https://images.unsplash.com/photo-1583212292454-1fe6229603b7',
        author: 'Majid',
        date: 'Oct 24, 2023',
        readTimeMinutes: 5,
        isFeatured: true,
      ),
      const BlogModel(
        id: 'b2',
        title: 'Luxury and Adventure: A 48-Hour Guide to Dubai',
        slug: '48-hours-in-dubai',
        category: 'Itinerary',
        content: 'Dubai is a city and emirate in the United Arab Emirates known for luxury shopping, ultramodern architecture and a lively nightlife scene. Burj Khalifa, an 830m-tall tower, dominates the skyscraper-filled skyline. At its foot lies Dubai Fountain, with jets and lights choreographed to music. On artificial islands just offshore is Atlantis, The Palm, a resort with water and marine-animal parks.',
        excerpt: 'Experience the best of Dubai in just two days, from the Burj Khalifa to desert safaris.',
        imageUrl: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c',
        author: 'Sarah Khan',
        date: 'Nov 12, 2023',
        readTimeMinutes: 8,
        isFeatured: true,
      ),
      const BlogModel(
        id: 'b3',
        title: 'Exploring the Street Food Scene in Bangkok',
        slug: 'bangkok-street-food-guide',
        category: 'Food & Drink',
        content: 'Bangkok, Thailand’s capital, is a large city known for ornate shrines and vibrant street life. The boat-filled Chao Phraya River feeds its network of canals, flowing past the Rattanakosin royal district, home to opulent Grand Palace and its sacred Wat Phra Kaew Temple. Nearby is Wat Pho Temple with an enormous reclining Buddha and, on the opposite shore, Wat Arun Temple with its steep steps and Khmer-style spire.',
        excerpt: 'A culinary journey through the bustling streets of Bangkok. Don\'t miss the Pad Thai!',
        imageUrl: 'https://images.unsplash.com/photo-1508009603885-50cf7c579367',
        author: 'John Doe',
        date: 'Dec 05, 2023',
        readTimeMinutes: 6,
        isFeatured: false,
      ),
      const BlogModel(
        id: 'b4',
        title: 'Essential Packing Tips for International Travel',
        slug: 'international-travel-packing-tips',
        category: 'Travel Tips',
        content: 'Packing for an international trip can be daunting. From managing weight limits to ensuring you have all the necessary documents, there\'s a lot to consider. This guide covers everything from packing cubes to universal adapters and digital document backups to make your journey smoother.',
        excerpt: 'Avoid overpacking and ensure you have all the essentials with our expert checklist.',
        imageUrl: 'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9',
        author: 'Majid',
        date: 'Jan 15, 2024',
        readTimeMinutes: 4,
        isFeatured: false,
      ),
      const BlogModel(
        id: 'b5',
        title: 'The Ultimate Guide to Sustainable Travel',
        slug: 'sustainable-travel-guide',
        category: 'Eco-Tourism',
        content: 'Sustainable travel is about more than just reducing your carbon footprint. It\'s about making positive contributions to the conservation of biodiversity and cultural heritage. Learn how to choose eco-friendly accommodations, support local communities, and minimize your impact on the environment.',
        excerpt: 'Learn how to travel the world while protecting the planet and supporting local communities.',
        imageUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09',
        author: 'Eco Traveler',
        date: 'Feb 10, 2024',
        readTimeMinutes: 7,
        isFeatured: true,
      ),
      const BlogModel(
        id: 'b6',
        title: 'Budget Travel: How to See the World for Less',
        slug: 'budget-travel-tips',
        category: 'Finance',
        content: 'Travel doesn\'t have to be expensive. With a little planning and some smart choices, you can see the world on a budget. This post explores how to find cheap flights, save on accommodation, and eat like a local without breaking the bank.',
        excerpt: 'Smart strategies for travelers who want to maximize their experiences while minimizing costs.',
        imageUrl: 'https://images.unsplash.com/photo-1517154421773-0529f29ea451',
        author: 'Thrifty Nomad',
        date: 'Mar 02, 2024',
        readTimeMinutes: 5,
        isFeatured: false,
      ),
      const BlogModel(
        id: 'b7',
        title: 'Exploring the Hidden Gems of Saint Martin\'s Island',
        slug: 'saint-martins-island-guide',
        category: 'Destination',
        content: 'Saint Martin\'s Island is the only coral island in Bangladesh. It\'s a small island in the northeastern part of the Bay of Bengal, about 9 km south of the tip of the Cox\'s Bazar-Teknaf peninsula. It\'s a beautiful place with crystal clear water and a relaxing atmosphere.',
        excerpt: 'Your complete guide to the only coral island in Bangladesh.',
        imageUrl: 'https://images.unsplash.com/photo-1589182373726-e4f658ab50f0',
        author: 'Majid',
        date: 'Apr 10, 2024',
        readTimeMinutes: 6,
        isFeatured: true,
      ),
      const BlogModel(
        id: 'b8',
        title: 'A Foodie\'s Guide to Paris: Beyond Baguettes',
        slug: 'paris-food-guide',
        category: 'Food & Drink',
        content: 'Paris is a world capital of gastronomy. From Michelin-starred restaurants to cozy bistros, the city offers an endless array of culinary delights. This guide takes you through the best pastries, cheeses, and wines that Paris has to offer.',
        excerpt: 'Discover the best culinary experiences in the City of Light.',
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
        author: 'Sarah Khan',
        date: 'May 05, 2024',
        readTimeMinutes: 7,
        isFeatured: false,
      ),
      const BlogModel(
        id: 'b9',
        title: 'The Best Time to Visit the Maldives',
        slug: 'best-time-to-visit-maldives',
        category: 'Travel Tips',
        content: 'The Maldives is a year-round destination, but the best time to visit depends on what you want to do. Whether you\'re looking for the best weather for sunbathing or the best conditions for diving, this guide will help you plan your perfect trip.',
        excerpt: 'Plan your dream vacation to the Maldives with our seasonal guide.',
        imageUrl: 'https://images.unsplash.com/photo-1514282401047-d79a71a590e8',
        author: 'John Doe',
        date: 'Jun 15, 2024',
        readTimeMinutes: 5,
        isFeatured: true,
      ),
    ];
  }
}
