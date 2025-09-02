import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../providers/auth_provider.dart';

/// SplashScreen - Initial loading screen and auth state checker
class SplashScreen extends StatefulWidget {
  /// Default constructor
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Animation controller
  late AnimationController _controller;
  // Various animations
  late Animation<double> _rotation;
  late Animation<double> _scale;
  late Animation<double> _opacity;
  late Animation<Color?> _colorAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Even faster animation
    );
    
    // Create animations
    _rotation = Tween<double>(begin: 0, end: 2 * math.pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _scale = Tween<double>(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _opacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _colorAnimation = ColorTween(
      begin: const Color(0xFF4A55A2), // Blue
      end: const Color(0xFF9376E0),   // Purple
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    // Start animation
    _controller.forward();
    
    // Start auth check immediately but only navigate when animation is complete
    _checkAuthState();
  }
  
  /// Check auth state but don't navigate immediately
  void _checkAuthState() async {
    // Start loading auth data immediately
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    // Set a minimum display time for the splash screen
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Only navigate if widget is still mounted
    if (mounted) {
      _navigateBasedOnAuthState(authProvider);
    }
  }
  
  /// Navigate based on the authentication state
  void _navigateBasedOnAuthState(AuthProvider authProvider) {
    switch (authProvider.authState) {
      case AuthState.authenticated:
        // If authenticated, go to home page
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case AuthState.unauthenticated:
        // For simplicity, we're going to onboarding for new users
        // In a real app, use shared preferences to check if first launch
        Navigator.pushReplacementNamed(context, '/onboarding');
        break;
      case AuthState.error:
        // Show error screen or dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${authProvider.errorMessage}')),
        );
        Navigator.pushReplacementNamed(context, '/login');
        break;
      case AuthState.loading:
      case AuthState.initial:
        // If still loading, wait a bit more and check again
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            _navigateBasedOnAuthState(authProvider);
          }
        });
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create a gradient background with blue, green, and purple
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          // Animated gradient background
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4A55A2), // Blue
                  const Color(0xFF7895CB), // Light blue
                  const Color(0xFF7DC8E7), // Cyan/Green-blue
                  const Color(0xFF9376E0), // Purple
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App icon with rotation and scale animation
                  AnimatedBuilder(
                    animation: _rotation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotation.value,
                        child: Transform.scale(
                          scale: _scale.value,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.school,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // App name with fade-in animation
                  FadeTransition(
                    opacity: _opacity,
                    child: const Text(
                      'ShuleApp',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Tagline with fade-in animation
                  FadeTransition(
                    opacity: _opacity,
                    child: const Text(
                      'Smart School Management',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Custom loading indicator
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                math.sin((_controller.value * 10) + (index * 1.5)).abs() * 0.8 + 0.2,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
