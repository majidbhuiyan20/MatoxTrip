import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/views/home/home_page.dart';
import '../../presentation/views/hotels/hotel_list_page.dart';
import '../../presentation/views/hotels/hotel_detail_page.dart';
import '../../presentation/views/blog/blog_list_page.dart';
import '../../presentation/views/blog/blog_detail_page.dart';
import '../../presentation/views/contact/contact_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text('404 - Page Not Found')),
    ),
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/destinations/:slug',
        name: 'hotel_list',
        builder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          return HotelListPage(destinationSlug: slug);
        },
      ),
      GoRoute(
        path: '/hotels/:hotelId',
        name: 'hotel_detail',
        builder: (context, state) {
          final hotelId = state.pathParameters['hotelId'] ?? '';
          return HotelDetailPage(hotelId: hotelId);
        },
      ),
      GoRoute(
        path: '/blog',
        name: 'blog_list',
        builder: (context, state) => const BlogListPage(),
        routes: [
          GoRoute(
            path: ':slug',
            name: 'blog_detail',
            builder: (context, state) {
              final slug = state.pathParameters['slug'] ?? '';
              return BlogDetailPage(slug: slug);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/contact',
        name: 'contact',
        builder: (context, state) => const ContactPage(),
      ),
    ],
  );
}
