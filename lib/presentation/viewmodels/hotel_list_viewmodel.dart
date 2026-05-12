import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hotelListProvider = ChangeNotifierProvider((ref) => HotelListNotifier());

class HotelListNotifier extends ChangeNotifier {}
