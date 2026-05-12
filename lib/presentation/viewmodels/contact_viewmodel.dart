import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactProvider = ChangeNotifierProvider((ref) => ContactNotifier());

class ContactNotifier extends ChangeNotifier {}
