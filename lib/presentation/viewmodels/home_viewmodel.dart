import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
final homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel());

class HomeViewModel extends StateNotifier<AsyncValue<void>> {
  HomeViewModel() : super(const AsyncValue.data(null));
}

// Alternatively, keeping it simple as a ChangeNotifier if you prefer that style with Riverpod


final homeProvider = ChangeNotifierProvider((ref) => HomeNotifier());

class HomeNotifier extends ChangeNotifier {}
