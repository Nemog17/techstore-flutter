import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isAdmin;
  AuthState({required this.isLoggedIn, required this.isAdmin});
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(isLoggedIn: false, isAdmin: false));

  void login(String email, String password) {
    // For demo purposes, any password 'admin' is admin
    final admin = email.contains('admin');
    state = AuthState(isLoggedIn: true, isAdmin: admin);
  }

  void logout() {
    state = AuthState(isLoggedIn: false, isAdmin: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
