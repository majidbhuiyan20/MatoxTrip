import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hotelDetailProvider = ChangeNotifierProvider((ref) => HotelDetailNotifier());

class HotelDetailNotifier extends ChangeNotifier {}
