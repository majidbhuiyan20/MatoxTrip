import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final blogProvider = ChangeNotifierProvider((ref) => BlogNotifier());

class BlogNotifier extends ChangeNotifier {}
