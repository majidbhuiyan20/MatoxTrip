import 'package:flutter/material.dart';

class HotelListPage extends StatelessWidget {
  const HotelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotels')),
      body: const Center(child: Text('Hotel List Page')),
    );
  }
}
