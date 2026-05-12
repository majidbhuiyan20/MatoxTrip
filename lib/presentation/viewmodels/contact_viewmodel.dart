import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactState {
  final bool isSubmitting;
  final String? error;
  final bool isSuccess;

  ContactState({
    this.isSubmitting = false,
    this.error,
    this.isSuccess = false,
  });

  ContactState copyWith({
    bool? isSubmitting,
    String? error,
    bool? isSuccess,
  }) {
    return ContactState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

final contactViewModelProvider = StateNotifierProvider<ContactViewModel, ContactState>((ref) {
  return ContactViewModel();
});

class ContactViewModel extends StateNotifier<ContactState> {
  ContactViewModel() : super(ContactState());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  Future<void> submitForm() async {
    if (nameController.text.isEmpty || 
        emailController.text.isEmpty || 
        messageController.text.isEmpty) {
      state = state.copyWith(error: 'Please fill all fields');
      return;
    }

    state = state.copyWith(isSubmitting: true, error: null, isSuccess: false);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      state = state.copyWith(isSubmitting: false, isSuccess: true);
      nameController.clear();
      emailController.clear();
      messageController.clear();
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: 'Failed to send message');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
