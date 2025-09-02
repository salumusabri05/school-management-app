import 'package:flutter/material.dart';
import '../screens/welcome_page.dart';
import '../screens/home_page.dart';

/// AppRouter class handles application routing
class AppRouter {
  /// Define all application routes
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const WelcomePage(),
      '/home': (context) => const HomePage(),
      // Add more routes as needed
    };
  }

  /// Handle unknown routes
  static Route<dynamic> onGenerateUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found!'),
        ),
      ),
    );
  }
}
