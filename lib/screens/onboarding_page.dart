import 'package:flutter/material.dart';
import 'dart:async'; // For auto-sliding timer

/// OnboardingPage - A carousel that introduces app features to new users
/// Uses PageView for smooth horizontal swiping between pages
class OnboardingPage extends StatefulWidget {
  /// Default constructor
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  /// Controller to manage page scrolling and transitions
  final PageController _pageController = PageController();
  
  /// Current page index for tracking position in carousel
  int _currentPage = 0;
  
  /// Timer for auto-sliding functionality
  Timer? _timer;
  
  /// List of onboarding content - each page's data is stored here
  final List<Map<String, String>> _onboardingContent = [
    {
      'title': 'Smart School Management, Simplified.',
      'subtitle': 'Manage everything from students to staff — all in one secure platform, tailored for your school.',
      'icon': 'school', // Material icon name
    },
    {
      'title': 'Full Control at Your Fingertips.',
      'subtitle': 'Admins can manage finance, staff, students, and reports — with role-based access to keep your school data safe.',
      'icon': 'admin_panel_settings', // Material icon name
    },
    {
      'title': 'Focus More on Teaching, Less on Paperwork.',
      'subtitle': 'Teachers can track classes, record grades, and communicate with students — all from one place.',
      'icon': 'person', // Material icon name
    },
    {
      'title': 'Stay Informed, Stay Connected.',
      'subtitle': 'Students (and parents) get real-time access to performance, schedules, and important updates from the school.',
      'icon': 'family_restroom', // Material icon name
    },
  ];

  @override
  void initState() {
    super.initState();
    // Start auto-sliding timer when the widget initializes
    _startAutoSlide();
  }

  @override
  void dispose() {
    // Cancel timer and dispose of controller when widget is removed
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// Setup auto-sliding functionality with a timer
  void _startAutoSlide() {
    // Create a periodic timer that advances the page every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < _onboardingContent.length) {
        _currentPage++;
      } else {
        _currentPage = 0; // Loop back to the first page
      }
      
      // Check if the controller is attached to a widget
      if (_pageController.hasClients) {
        // Smoothly animate to the next page
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;
    final bool isDesktop = screenSize.width > 1200;
    
    return Scaffold(
      // Use white background for a clean look
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button aligned to the right (only shown before the last page)
            if (_currentPage < _onboardingContent.length - 1)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {
                      // Skip to the last page
                      _pageController.animateToPage(
                        _onboardingContent.length,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            
            // Main content area with PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                // Update current page index when user swipes
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                // Add an extra page for the login button
                itemCount: _onboardingContent.length + 1,
                itemBuilder: (context, index) {
                  // Check if we're on the last page (login page)
                  if (index == _onboardingContent.length) {
                    return _buildLoginPage(context, isTablet, isDesktop);
                  }
                  // Otherwise build a content page
                  return _buildContentPage(
                    context,
                    _onboardingContent[index]['title']!,
                    _onboardingContent[index]['subtitle']!,
                    _onboardingContent[index]['icon']!,
                    isTablet,
                    isDesktop,
                  );
                },
              ),
            ),
            
            // Page indicator dots
            Container(
              margin: EdgeInsets.only(bottom: isTablet ? 30 : 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingContent.length + 1, // +1 for login page
                  (index) => _buildPageIndicator(index == _currentPage),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Builds a single content page in the onboarding carousel
  Widget _buildContentPage(
    BuildContext context,
    String title,
    String subtitle,
    String iconName,
    bool isTablet,
    bool isDesktop,
  ) {
    // Map string icon names to Material icons
    final Map<String, IconData> iconMap = {
      'school': Icons.school,
      'admin_panel_settings': Icons.admin_panel_settings,
      'person': Icons.person,
      'family_restroom': Icons.family_restroom,
    };
    
    // Get the icon or use a default
    final IconData icon = iconMap[iconName] ?? Icons.info;
    
    // Determine which color to use based on the icon
    Color iconColor = Theme.of(context).colorScheme.primary;
    if (iconName == 'admin_panel_settings') {
      iconColor = Theme.of(context).colorScheme.primary;
    } else if (iconName == 'person') {
      iconColor = Theme.of(context).colorScheme.secondary;
    } else if (iconName == 'family_restroom') {
      iconColor = Theme.of(context).colorScheme.tertiary;
    }
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with background
          Container(
            padding: EdgeInsets.all(isTablet ? 28 : 20),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: isDesktop ? 100 : (isTablet ? 80 : 60),
              color: iconColor,
            ),
          ),
          
          SizedBox(height: isTablet ? 40 : 30),
          
          // Title with gradient
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                iconColor,
                Theme.of(context).colorScheme.primary,
              ],
            ).createShader(bounds),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
                fontWeight: FontWeight.bold,
                color: Colors.white, // Color is applied by shader
                height: 1.2,
              ),
            ),
          ),
          
          SizedBox(height: isTablet ? 24 : 16),
          
          // Subtitle text
          Container(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 20 : 10),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isDesktop ? 18 : (isTablet ? 16 : 15),
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Builds the final login page
  Widget _buildLoginPage(BuildContext context, bool isTablet, bool isDesktop) {
    // Get screen dimensions for the login button
    final Size screenSize = MediaQuery.of(context).size;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // School icon
        Icon(
          Icons.school,
          size: isDesktop ? 120 : (isTablet ? 100 : 80),
          color: Theme.of(context).colorScheme.primary,
        ),
        
        SizedBox(height: isTablet ? 40 : 30),
        
        // Welcome text
        Text(
          'Welcome to ShuleApp',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isDesktop ? 36 : (isTablet ? 32 : 28),
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        
        SizedBox(height: isTablet ? 16 : 12),
        
        // Subtitle
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 30),
          child: Text(
            'Your complete school management solution',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 18 : (isTablet ? 16 : 15),
              color: Colors.grey[700],
            ),
          ),
        ),
        
        SizedBox(height: isTablet ? 60 : 40),
        
        // Login button
        Container(
          width: isDesktop 
              ? screenSize.width * 0.3
              : (isTablet ? screenSize.width * 0.5 : screenSize.width * 0.75),
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the login page
              // Note: Replace with your actual login page navigation
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
              elevation: 4,
              shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
              ),
            ),
            child: Text(
              'Login with School ID',
              style: TextStyle(
                fontSize: isTablet ? 20 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  /// Builds the page indicator dots
  Widget _buildPageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive 
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
    );
  }
}
