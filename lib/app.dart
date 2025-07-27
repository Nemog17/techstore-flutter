import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/login_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/register_screen.dart';
import 'screens/admin/admin_panel.dart';
import 'providers/auth_provider.dart';

class TechStoreApp extends ConsumerWidget {
  TechStoreApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/cart', builder: (_, __) => const CartScreen()),
      GoRoute(path: '/payment', builder: (_, __) => const PaymentScreen()),
      GoRoute(path: '/product/:id', builder: (_, state) {
        final id = state.pathParameters['id']!;
        return ProductDetailScreen(productId: id);
      }),
      GoRoute(path: '/admin', builder: (_, __) => const AdminPanel()),
    ],
    redirect: (context, state) {
      final container = ProviderScope.containerOf(context, listen: false);
      final auth = container.read(authProvider);
      final isLoggedIn = auth.isLoggedIn;
      final isAdmin = auth.isAdmin;
      if (state.uri.path == '/admin' && (!isLoggedIn || !isAdmin)) {
        return '/';
      }
      return null;
    },
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'TechStore',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      routerConfig: _router,
    );
  }
}
