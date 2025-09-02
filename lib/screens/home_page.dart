import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

/// HomePage widget - The main dashboard screen after welcome
/// Displays different content based on user role
class HomePage extends StatelessWidget {
  /// Default constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get role from navigation arguments, default to 'admin' if not specified
    final Map<String, dynamic> args = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final String userRole = args['role'] ?? 'admin';
    
    // Select title and color based on role
    String dashboardTitle;
    Color primaryColor;
    
    switch (userRole) {
      case 'admin':
        dashboardTitle = 'Admin Dashboard';
        primaryColor = const Color(0xFF4A55A2); // Blue
        break;
      case 'teacher':
        dashboardTitle = 'Teacher Dashboard';
        primaryColor = const Color(0xFF7895CB); // Light blue
        break;
      case 'parent':
        dashboardTitle = 'Parent Dashboard';
        primaryColor = const Color(0xFF9376E0); // Purple
        break;
      case 'student':
        dashboardTitle = 'Student Portal';
        primaryColor = Colors.teal;
        break;
      default:
        dashboardTitle = 'ShuleApp Dashboard';
        primaryColor = Theme.of(context).colorScheme.primary;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(dashboardTitle),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          // Profile menu
          PopupMenuButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text('Settings'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'logout') {
                // Show confirmation dialog
                final bool? confirm = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
                
                if (confirm == true) {
                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                  await authProvider.signOut();
                  // Navigate to login page
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                }
              } else if (value == 'profile') {
                // Navigate to profile page
                // Navigator.pushNamed(context, '/profile');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile feature coming soon!')),
                );
              } else if (value == 'settings') {
                // Navigate to settings page
                // Navigator.pushNamed(context, '/settings');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings feature coming soon!')),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    final userDetails = authProvider.userDetails;
                    final String firstName = userDetails?['first_name'] as String? ?? 'User';
                    final String lastName = userDetails?['last_name'] as String? ?? '';
                    final String role = userDetails?['role'] as String? ?? '';
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, $firstName!',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (role.isNotEmpty)
                          Text(
                            'Role: ${role[0].toUpperCase()}${role.substring(1)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              
              // Dashboard overview cards based on user role
              GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: _getDashboardCardsForRole(context, userRole),
              ),
              
              const SizedBox(height: 24),
              
              // Recent activities with custom title based on role
              Text(
                userRole == 'parent' ? 'Recent Updates' : 
                (userRole == 'student' ? 'Latest Notifications' : 'Recent Activities'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // List of role-specific activities
              ..._getActivitiesForRole(context, userRole),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Builds a dashboard stat card
  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to detail page for this category
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title details coming soon!')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 36,
                color: color,
              ),
              const Spacer(),
              Text(
                count,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Builds an activity list tile
  Widget _buildActivityTile(
    BuildContext context, {
    required String title,
    required String description,
    required String time,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Text(
          time,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        onTap: () {
          // Show activity details
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Details for $title coming soon!')),
          );
        },
      ),
    );
  }
  
  /// Returns role-specific activity tiles
  List<Widget> _getActivitiesForRole(BuildContext context, String role) {
    switch (role) {
      case 'admin':
        return [
          _buildActivityTile(
            context, 
            title: 'New Student Registration', 
            description: 'John Doe was registered to Grade 10', 
            time: '10 mins ago',
            icon: Icons.person_add,
          ),
          _buildActivityTile(
            context, 
            title: 'Teacher Absence Reported', 
            description: 'Mrs. Smith requested leave for Friday', 
            time: '1 hour ago',
            icon: Icons.report_problem,
          ),
          _buildActivityTile(
            context, 
            title: 'Budget Approved', 
            description: 'Science lab equipment budget approved', 
            time: '2 hours ago',
            icon: Icons.monetization_on,
          ),
          _buildActivityTile(
            context, 
            title: 'System Update Complete', 
            description: 'School management system updated to v2.4', 
            time: '3 hours ago',
            icon: Icons.system_update,
          ),
        ];
        
      case 'teacher':
        return [
          _buildActivityTile(
            context, 
            title: 'Assignment Submitted', 
            description: '15 students submitted Math homework', 
            time: '30 mins ago',
            icon: Icons.assignment_turned_in,
          ),
          _buildActivityTile(
            context, 
            title: 'Parent Meeting Requested', 
            description: 'Emma\'s parents requested a meeting', 
            time: '1 hour ago',
            icon: Icons.group,
          ),
          _buildActivityTile(
            context, 
            title: 'Staff Meeting Reminder', 
            description: 'Reminder: Staff meeting today at 3 PM', 
            time: '2 hours ago',
            icon: Icons.event_note,
          ),
          _buildActivityTile(
            context, 
            title: 'Syllabus Updated', 
            description: 'Science syllabus updated for Term 2', 
            time: '1 day ago',
            icon: Icons.update,
          ),
        ];
        
      case 'parent':
        return [
          _buildActivityTile(
            context, 
            title: 'Attendance Marked', 
            description: 'Sarah was present today', 
            time: '3 hours ago',
            icon: Icons.check_circle,
          ),
          _buildActivityTile(
            context, 
            title: 'Quiz Results', 
            description: 'Sarah scored 85% in Science quiz', 
            time: '1 day ago',
            icon: Icons.score,
          ),
          _buildActivityTile(
            context, 
            title: 'Fee Due Reminder', 
            description: 'Term 2 fees due in 5 days', 
            time: '1 day ago',
            icon: Icons.payment,
          ),
          _buildActivityTile(
            context, 
            title: 'School Event', 
            description: 'Annual Sports Day next Friday', 
            time: '2 days ago',
            icon: Icons.event,
          ),
        ];

      case 'student':
        return [
          _buildActivityTile(
            context, 
            title: 'Assignment Posted', 
            description: 'New Math assignment due Friday', 
            time: '2 hours ago',
            icon: Icons.assignment,
          ),
          _buildActivityTile(
            context, 
            title: 'Quiz Scheduled', 
            description: 'English quiz scheduled for tomorrow', 
            time: '3 hours ago',
            icon: Icons.quiz,
          ),
          _buildActivityTile(
            context, 
            title: 'Grade Posted', 
            description: 'You received an A in History project', 
            time: '1 day ago',
            icon: Icons.grade,
          ),
          _buildActivityTile(
            context, 
            title: 'Club Meeting', 
            description: 'Chess club meets Thursday at 3 PM', 
            time: '1 day ago',
            icon: Icons.groups,
          ),
        ];
        
      default:
        return [
          _buildActivityTile(
            context, 
            title: 'Welcome to ShuleApp', 
            description: 'Get started with your school management dashboard', 
            time: 'Just now',
            icon: Icons.waving_hand,
          ),
        ];
    }
  }

  /// Returns dashboard cards based on user role
  List<Widget> _getDashboardCardsForRole(BuildContext context, String role) {
    switch (role) {
      case 'admin':
        return [
          // Students Card
          _buildDashboardCard(
            context,
            title: 'Students',
            count: '850',
            icon: Icons.people,
            color: const Color(0xFF4A55A2), // Blue
          ),
          // Teachers Card
          _buildDashboardCard(
            context,
            title: 'Teachers',
            count: '45',
            icon: Icons.school,
            color: const Color(0xFF7895CB), // Light blue
          ),
          // Classes Card
          _buildDashboardCard(
            context,
            title: 'Classes',
            count: '24',
            icon: Icons.class_,
            color: const Color(0xFF9376E0), // Purple
          ),
          // Finance Card
          _buildDashboardCard(
            context,
            title: 'Finance',
            count: '\$125K',
            icon: Icons.attach_money,
            color: Colors.green,
          ),
          // Reports Card
          _buildDashboardCard(
            context,
            title: 'Reports',
            count: '36',
            icon: Icons.bar_chart,
            color: Colors.orange,
          ),
          // Settings Card
          _buildDashboardCard(
            context,
            title: 'Settings',
            count: 'Admin',
            icon: Icons.settings,
            color: Colors.purple,
          ),
        ];
        
      case 'teacher':
        return [
          // My Classes Card
          _buildDashboardCard(
            context,
            title: 'My Classes',
            count: '5',
            icon: Icons.class_,
            color: const Color(0xFF7895CB), // Light blue
          ),
          // Students Card
          _buildDashboardCard(
            context,
            title: 'My Students',
            count: '120',
            icon: Icons.people,
            color: const Color(0xFF4A55A2), // Blue
          ),
          // Assignments Card
          _buildDashboardCard(
            context,
            title: 'Assignments',
            count: '18',
            icon: Icons.assignment,
            color: Colors.amber,
          ),
          // Grades Card
          _buildDashboardCard(
            context,
            title: 'Grades',
            count: '43',
            icon: Icons.grade,
            color: const Color(0xFF9376E0), // Purple
          ),
          // Schedule Card
          _buildDashboardCard(
            context,
            title: 'Schedule',
            count: 'Today',
            icon: Icons.calendar_today,
            color: Colors.teal,
          ),
          // Resources Card
          _buildDashboardCard(
            context,
            title: 'Resources',
            count: '24',
            icon: Icons.book,
            color: Colors.indigo,
          ),
        ];
        
      case 'parent':
        return [
          // Children Card
          _buildDashboardCard(
            context,
            title: 'Children',
            count: '2',
            icon: Icons.child_care,
            color: const Color(0xFF9376E0), // Purple
          ),
          // Attendance Card
          _buildDashboardCard(
            context,
            title: 'Attendance',
            count: '95%',
            icon: Icons.calendar_today,
            color: Colors.teal,
          ),
          // Grades Card
          _buildDashboardCard(
            context,
            title: 'Grades',
            count: 'View',
            icon: Icons.grade,
            color: Colors.amber,
          ),
          // Fees Card
          _buildDashboardCard(
            context,
            title: 'Fees',
            count: '\$750',
            icon: Icons.payment,
            color: Colors.green,
          ),
          // Communication Card
          _buildDashboardCard(
            context,
            title: 'Messages',
            count: '5 New',
            icon: Icons.message,
            color: const Color(0xFF7895CB), // Light blue
          ),
          // Events Card
          _buildDashboardCard(
            context,
            title: 'Events',
            count: '3',
            icon: Icons.event,
            color: Colors.orange,
          ),
        ];

      case 'student':
        return [
          // Classes Card
          _buildDashboardCard(
            context,
            title: 'My Classes',
            count: '6',
            icon: Icons.class_,
            color: Colors.teal,
          ),
          // Assignments Card
          _buildDashboardCard(
            context,
            title: 'Assignments',
            count: '8',
            icon: Icons.assignment,
            color: Colors.amber,
          ),
          // Grades Card
          _buildDashboardCard(
            context,
            title: 'My Grades',
            count: 'View',
            icon: Icons.grade,
            color: const Color(0xFF9376E0), // Purple
          ),
          // Schedule Card
          _buildDashboardCard(
            context,
            title: 'Schedule',
            count: 'Today',
            icon: Icons.calendar_today,
            color: const Color(0xFF4A55A2), // Blue
          ),
          // Library Card
          _buildDashboardCard(
            context,
            title: 'Library',
            count: '2 Due',
            icon: Icons.book,
            color: Colors.indigo,
          ),
          // Activities Card
          _buildDashboardCard(
            context,
            title: 'Activities',
            count: '3',
            icon: Icons.sports_soccer,
            color: Colors.green,
          ),
        ];
        
      default:
        return [
          // Default cards
          _buildDashboardCard(
            context,
            title: 'Dashboard',
            count: 'View',
            icon: Icons.dashboard,
            color: Theme.of(context).colorScheme.primary,
          ),
          _buildDashboardCard(
            context,
            title: 'Profile',
            count: 'View',
            icon: Icons.person,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ];
    }
  }
}
