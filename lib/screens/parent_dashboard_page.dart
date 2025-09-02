import 'package:flutter/material.dart';

/// ParentDashboardPage - Dashboard for parents with navigation and UI structure
class ParentDashboardPage extends StatefulWidget {
  /// Default constructor
  const ParentDashboardPage({super.key});

  @override
  State<ParentDashboardPage> createState() => _ParentDashboardPageState();
}

class _ParentDashboardPageState extends State<ParentDashboardPage> with SingleTickerProviderStateMixin {
  // Current selected index for bottom navigation
  int _currentNavIndex = 0;
  
  // Controller for the tab view
  late TabController _tabController;
  
  // Navigation tabs
  final List<Map<String, dynamic>> _navigationItems = [
    {
      'title': 'Children',
      'icon': Icons.family_restroom,
      'tabs': ['Overview', 'Select Child']
    },
    {
      'title': 'Academics',
      'icon': Icons.school,
      'tabs': ['Grades', 'Attendance', 'Homework']
    },
    {
      'title': 'Finance',
      'icon': Icons.payment,
      'tabs': ['Fees', 'Payments', 'Receipts']
    },
    {
      'title': 'Communication',
      'icon': Icons.message,
      'tabs': ['Messages', 'Notices', 'Meetings']
    },
    {
      'title': 'Calendar',
      'icon': Icons.calendar_today,
      'tabs': ['Events', 'Schedules', 'Reminders']
    }
  ];
  
  // Mock children data
  final List<Map<String, String>> _children = [
    {
      'name': 'Emily Smith',
      'grade': 'Grade 8',
      'image': 'https://picsum.photos/id/237/200'
    },
    {
      'name': 'Michael Smith',
      'grade': 'Grade 5',
      'image': 'https://picsum.photos/id/238/200'
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
        backgroundColor: const Color(0xFF9376E0), // Purple
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
        children: _buildTabViews(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: _changeNavIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF9376E0), // Purple
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

  // Build tab views based on current navigation index
  List<Widget> _buildTabViews() {
    // For the Children section, provide some actual UI
    if (_currentNavIndex == 0) {
      return [
        // Overview tab
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Children',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ..._children.map((child) => _buildChildCard(child)),
              
              const SizedBox(height: 24),
              const Text(
                'Recent Updates',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildUpdateCard(
                title: 'Emily - Math Quiz',
                message: 'Emily scored 95% on her Math quiz',
                time: '2 hours ago',
                icon: Icons.grade,
                color: Colors.green,
              ),
              _buildUpdateCard(
                title: 'Michael - Absence',
                message: 'Michael was absent yesterday',
                time: '1 day ago',
                icon: Icons.person_off,
                color: Colors.red,
              ),
              _buildUpdateCard(
                title: 'Fee Payment Reminder',
                message: 'Term 2 fees due in 5 days',
                time: '2 days ago',
                icon: Icons.payment,
                color: Colors.orange,
              ),
            ],
          ),
        ),
        
        // Select Child tab
        ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _children.length,
          itemBuilder: (context, index) {
            final child = _children[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    child['name']![0],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  child['name']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(child['grade']!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Switch to selected child
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Switched to ${child['name']}'),
                      backgroundColor: const Color(0xFF9376E0),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ];
    }
    
    // For other sections, just return placeholder content
    return _navigationItems[_currentNavIndex]['tabs']
        .map<Widget>((tab) => Center(
          child: Text('$tab Content - Coming Soon'),
        ))
        .toList();
  }

  // Build child summary card
  Widget _buildChildCard(Map<String, String> child) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              child: Text(
                child['name']![0],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    child['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    child['grade']!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildStatChip(
                        'Attendance',
                        '95%',
                        Icons.calendar_today,
                      ),
                      const SizedBox(width: 8),
                      _buildStatChip(
                        'GPA',
                        '3.8',
                        Icons.star,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
  
  // Build stat chip
  Widget _buildStatChip(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF9376E0).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF9376E0)),
          const SizedBox(width: 4),
          Text(
            '$label: $value',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  // Build update card
  Widget _buildUpdateCard({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Text(
          time,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Robert & Mary Smith'),
            accountEmail: const Text('Parents of Emily & Michael'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('RS'),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF9376E0), // Purple
            ),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Receipts & Documents'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Receipts feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('School Calendar'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Calendar feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Teacher Contacts'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contacts feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('School Resources'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Resources feature coming soon')),
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
