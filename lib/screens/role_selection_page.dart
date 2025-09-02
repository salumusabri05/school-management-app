import 'package:flutter/material.dart';

/// RoleSelectionPage - Allow users to select their role
class RoleSelectionPage extends StatelessWidget {
  /// Default constructor
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;
    
    return Scaffold(
      // Beautiful gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF4A55A2), // Blue
              const Color(0xFF7895CB), // Light blue
              const Color(0xFF9376E0), // Purple
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 40.0 : 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                
                // Header text
                Text(
                  "Select Your Role",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isTablet ? 36 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Subtitle
                Text(
                  "Choose your role to access the appropriate features",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                
                const SizedBox(height: 60),
                
                // Role selection cards
                Expanded(
                  child: GridView.count(
                    crossAxisCount: isTablet ? 2 : 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      // Admin role card
                      _buildRoleCard(
                        context,
                        title: 'Administrator',
                        description: 'Manage school, staff, students, and all resources',
                        icon: Icons.admin_panel_settings,
                        color: const Color(0xFF4A55A2), // Blue
                        onTap: () => _navigateToRole(context, 'admin'),
                      ),
                      
                      // Teacher role card
                      _buildRoleCard(
                        context,
                        title: 'Teacher',
                        description: 'Manage classes, grades, and student information',
                        icon: Icons.school,
                        color: const Color(0xFF7895CB), // Light blue
                        onTap: () => _navigateToRole(context, 'teacher'),
                      ),
                      
                      // Parent role card
                      _buildRoleCard(
                        context,
                        title: 'Parent',
                        description: 'View student progress, attendance, and communicate with teachers',
                        icon: Icons.family_restroom,
                        color: const Color(0xFF9376E0), // Purple
                        onTap: () => _navigateToRole(context, 'parent'),
                      ),
                      
                      // Student role card
                      _buildRoleCard(
                        context,
                        title: 'Student',
                        description: 'Access assignments, grades, and class materials',
                        icon: Icons.person,
                        color: Colors.teal,
                        onTap: () => _navigateToRole(context, 'student'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  /// Navigate to the appropriate screen based on selected role
  void _navigateToRole(BuildContext context, String role) {
    // Store the selected role (in a real app, save this to auth provider)
    
    // Navigate to the appropriate dashboard based on role
    switch (role) {
      case 'admin':
        Navigator.pushReplacementNamed(context, '/admin_dashboard');
        break;
      case 'teacher':
        Navigator.pushReplacementNamed(context, '/teacher_dashboard');
        break;
      case 'student':
        Navigator.pushReplacementNamed(context, '/student_dashboard');
        break;
      case 'parent':
        Navigator.pushReplacementNamed(context, '/parent_dashboard');
        break;
      default:
        // For any other roles, navigate to the general home page
        Navigator.pushReplacementNamed(
          context, 
          '/home',
          arguments: {'role': role},
        );
    }
    
    // Show confirmation of selection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logged in as $role'),
        backgroundColor: role == 'admin' 
            ? const Color(0xFF4A55A2) 
            : (role == 'teacher' 
                ? const Color(0xFF7895CB) 
                : const Color(0xFF9376E0)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  
  /// Build a role selection card with animation
  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Hero(
      tag: 'role_$title',
      child: Material(
        color: Colors.transparent,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            splashColor: color.withOpacity(0.3),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.9),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Role icon with animated container
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        size: 50,
                        color: color,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Role title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Role description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
