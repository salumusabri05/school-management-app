import 'package:flutter/material.dart';

/// StudentDashboardPage - Dashboard for students with navigation and UI structure
class StudentDashboardPage extends StatefulWidget {
  /// Default constructor
  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> with SingleTickerProviderStateMixin {
  // Current selected index for bottom navigation
  int _currentNavIndex = 0;
  
  // Controller for the tab view
  late TabController _tabController;
  
  // Navigation tabs
  final List<Map<String, dynamic>> _navigationItems = [
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard,
      'tabs': ['Overview', 'Timetable', 'Calendar']
    },
    {
      'title': 'Academics',
      'icon': Icons.school,
      'tabs': ['Subjects', 'Grades', 'Resources']
    },
    {
      'title': 'Assignments',
      'icon': Icons.assignment,
      'tabs': ['Pending', 'Submitted', 'Graded']
    },
    {
      'title': 'Activities',
      'icon': Icons.sports_soccer,
      'tabs': ['Sports', 'Clubs', 'Events']
    },
    {
      'title': 'Profile',
      'icon': Icons.person,
      'tabs': ['Info', 'Settings', 'Help']
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Text(_navigationItems[_currentNavIndex]['title']),
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: _navigationItems[_currentNavIndex]['tabs']
              .map<Tab>((tab) => Tab(text: tab))
              .toList(),
        ),
      ),
      drawer: _buildDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: _navigationItems[_currentNavIndex]['tabs']
            .map<Widget>((tab) => Center(child: Text('$tab Content - Coming Soon')))
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: _changeNavIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: _navigationItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item['icon']),
            label: item['title'],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('John Smith'),
            accountEmail: const Text('Grade 10 - Section A'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('JS'),
            ),
            decoration: const BoxDecoration(
              color: Colors.teal,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Library'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Library feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Fees'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fees feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bus_alert),
            title: const Text('Transport'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transport feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Messages'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Messages feature coming soon')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
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
