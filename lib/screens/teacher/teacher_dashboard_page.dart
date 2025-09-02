import 'package:flutter/material.dart';

/// TeacherDashboardPage - Dashboard for teachers with navigation and UI structure
///
/// This page provides a comprehensive interface for teachers to access class information,
/// assignments, grades, student details, and communication features.
class TeacherDashboardPage extends StatefulWidget {
  /// Default constructor
  const TeacherDashboardPage({super.key});

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> with SingleTickerProviderStateMixin {
  // Current selected index for bottom navigation
  int _currentNavIndex = 0;
  
  // Controller for the tab view
  late TabController _tabController;
  
  // Navigation tabs
  final List<Map<String, dynamic>> _navigationItems = [
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard,
      'tabs': ['Overview', 'Schedule', 'Calendar']
    },
    {
      'title': 'Classes',
      'icon': Icons.class_,
      'tabs': ['My Classes', 'Attendance', 'Behavior']
    },
    {
      'title': 'Assignments',
      'icon': Icons.assignment,
      'tabs': ['Create', 'Grade', 'Statistics']
    },
    {
      'title': 'Communication',
      'icon': Icons.message,
      'tabs': ['Messages', 'Announcements', 'Meetings']
    },
    {
      'title': 'Resources',
      'icon': Icons.folder,
      'tabs': ['Materials', 'Templates', 'Library']
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _navigationItems[_currentNavIndex]['tabs'].length,
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  // Change navigation index and update tab controller
  void _changeNavIndex(int index) {
    setState(() {
      _currentNavIndex = index;
      _tabController = TabController(
        length: _navigationItems[_currentNavIndex]['tabs'].length,
        vsync: this,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Apply Nunito font to the entire dashboard
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Nunito',
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF7895CB), // Light blue
          foregroundColor: Colors.white,
          title: Text(
            _navigationItems[_currentNavIndex]['title'],
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications coming soon')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search coming soon')),
                );
              },
            ),
          ],
          // Fix for tab visibility
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white, // Ensure text is visible
            unselectedLabelColor: Colors.white.withOpacity(0.7), // Slightly transparent for unselected tabs
            labelStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
            tabs: _navigationItems[_currentNavIndex]['tabs']
                .map<Tab>((tab) => Tab(text: tab))
                .toList(),
          ),
        ),
        drawer: _buildDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: _navigationItems[_currentNavIndex]['tabs']
              .map<Widget>((tab) => Center(
                child: Text(
                  '$tab Content - Coming Soon',
                  style: const TextStyle(fontFamily: 'Nunito'),
                ),
              ))
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          onTap: _changeNavIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF7895CB), // Light blue
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 11),
          items: _navigationItems.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item['icon']),
              label: item['title'],
            );
          }).toList(),
        ),
        floatingActionButton: _currentNavIndex == 2 // Show FAB on Assignments tab
            ? FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Create assignment feature coming soon')),
                  );
                },
                backgroundColor: const Color(0xFF7895CB), // Light blue
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Jane Doe',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              'Math Teacher',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'JD',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF7895CB),
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF7895CB), // Light blue
            ),
          ),
          ListTile(
            leading: const Icon(Icons.groups),
            title: const Text(
              'My Students',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('My Students feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text(
              'Performance Analytics',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Analytics feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text(
              'Professional Development',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Professional Development feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.event_note),
            title: const Text(
              'School Calendar',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Calendar feature coming soon')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text(
              'Help & Support',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Logout',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'App Version 1.0.0',
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.grey[600],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
