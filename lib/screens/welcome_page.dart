import 'package:flutter/material.dart';

/// WelcomePage widget - The initial screen of the application
/// Displays the app logo and name with a simple, clean design
class WelcomePage extends StatelessWidget {
  /// Default constructor
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final Size screenSize = MediaQuery.of(context).size;

    // Define responsive breakpoints
    final bool isTablet = screenSize.width > 600;
    final bool isDesktop = screenSize.width > 1200;

    // Calculate logo size based on screen dimensions
    final double logoHeight =
        screenSize.height * (isDesktop ? 0.25 : (isTablet ? 0.22 : 0.18));

    return Scaffold(
      // Use white background for a clean look
      backgroundColor: Colors.white,
      body: SafeArea(
        // Make the content scrollable to avoid overflow issues
        child: SingleChildScrollView(
          child: Container(
            // Center content vertically and add padding
            height:
                screenSize.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
            // Use Center widget to ensure horizontal centering
            child: Center(
              child: Column(
                // Center content vertically
                mainAxisAlignment: MainAxisAlignment.center,
                // Center content horizontally
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo with error handling
                  Container(
                    margin: EdgeInsets.all(isTablet ? 40 : 25),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/logo.png',
                      height: logoHeight,
                      // Error builder to display a fallback if image fails to load
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: logoHeight,
                          width: logoHeight,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.school,
                            size: logoHeight * 0.6,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                    ),
                  ),

                  // App name with styled text
                  Text(
                    'ShuleApp',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isDesktop ? 48 : (isTablet ? 40 : 32),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.2,
                    ),
                  ),

                  SizedBox(height: isTablet ? 20 : 12),

                  // Subtitle text
                  Text(
                    'School Management Made Simple',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.08),

                  // Get Started button with animation
                  SizedBox(
                    // Responsive width for the button
                    width: isDesktop
                        ? screenSize.width * 0.3
                        : (isTablet
                              ? screenSize.width * 0.5
                              : screenSize.width * 0.8),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to home page using the named route
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 20 : 16,
                        ),
                        elevation: 4,
                        shadowColor: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            isTablet ? 16 : 12,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: isTablet ? 15 : 10),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: isTablet ? 24 : 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
