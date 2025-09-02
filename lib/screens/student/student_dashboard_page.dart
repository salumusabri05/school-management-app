import 'package:flutter/material.dart';

/// StudentDashboardPage - Dashboard for students with navigation and UI structure
///
/// This page provides a comprehensive interface for students to access their classes,
/// assignments, grades, schedule, and resources.
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
      'tabs': ['Overview', 'Schedule', 'Calendar']
    },
    {
      'title': 'Classes',
      'icon': Icons.class_,
      'tabs': ['Current', 'Attendance', 'Materials']
    },
    {
      'title': 'Assignments',
      'icon': Icons.assignment,
      'tabs': ['Due', 'Submitted', 'Grades']
    },
    {
      'title': 'Resources',
      'icon': Icons.menu_book,
      'tabs': ['Library', 'Downloads', 'Links']
    },
    {
      'title': 'Activities',
      'icon': Icons.sports_soccer,
      'tabs': ['Clubs', 'Events', 'Sports']
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
          backgroundColor: const Color(0xFF9376E0), // Purple
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
              icon: const Icon(Icons.message),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Messages coming soon')),
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
              .map<Widget>((tab) {
                return _buildTabContent(tab);
              })
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          onTap: _changeNavIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF9376E0), // Purple
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
      ),
    );
  }

  Widget _buildTabContent(String tab) {
    // Showing a sample UI for the Overview tab
    if (_currentNavIndex == 0 && tab == 'Overview') {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUpcomingCard(),
            const SizedBox(height: 16),
            _buildRecentGradesCard(),
            const SizedBox(height: 16),
            _buildAnnouncementsCard(),
          ],
        ),
      );
    }
    
    // For all other tabs, show a placeholder
    return Center(
      child: Text(
        '$tab Content - Coming Soon',
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
        ),
      ),
    );
  }
  
  Widget _buildUpcomingCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Assignments',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            _buildUpcomingAssignmentItem(
              'Math Homework',
              'Algebra Chapter 5',
              DateTime.now().add(const Duration(days: 1)),
              Icons.calculate,
              Colors.blue,
            ),
            _buildUpcomingAssignmentItem(
              'Science Project',
              'Ecosystem Research',
              DateTime.now().add(const Duration(days: 3)),
              Icons.science,
              Colors.green,
            ),
            _buildUpcomingAssignmentItem(
              'Literature Essay',
              'Character Analysis',
              DateTime.now().add(const Duration(days: 5)),
              Icons.book,
              Colors.orange,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View All Assignments',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Color(0xFF9376E0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAssignmentItem(
      String title, String description, DateTime dueDate, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.2),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Due',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              Text(
                '${dueDate.day}/${dueDate.month}/${dueDate.year}',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9376E0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentGradesCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Grades',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            _buildGradeItem('Math Quiz', 'A', Colors.green),
            _buildGradeItem('Science Lab Report', 'B+', Colors.blue),
            _buildGradeItem('History Presentation', 'A-', Colors.green),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View All Grades',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Color(0xFF9376E0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeItem(String subject, String grade, Color gradeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              subject,
              style: const TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: gradeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              grade,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: gradeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Announcements',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            _buildAnnouncementItem(
              'School Holiday',
              'School will be closed for Foundation Day on Friday.',
              DateTime.now().subtract(const Duration(hours: 3)),
              Icons.event,
            ),
            _buildAnnouncementItem(
              'Science Fair',
              'Annual science fair registrations are now open.',
              DateTime.now().subtract(const Duration(hours: 18)),
              Icons.science,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View All Announcements',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Color(0xFF9376E0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementItem(String title, String content, DateTime postedTime, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF9376E0)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  content,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_getTimeAgo(postedTime)}',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  String _getTimeAgo(DateTime time) {
    final Duration difference = DateTime.now().difference(time);
    if (difference.inHours < 24) {
      return difference.inHours == 1 
          ? '1 hour ago' 
          : '${difference.inHours} hours ago';
    } else {
      final int days = difference.inDays;
      return days == 1 ? '1 day ago' : '$days days ago';
    }
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'John Smith',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              'Grade 10 - Science',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'JS',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF9376E0),
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF9376E0), // Purple
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'My Profile',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text(
              'Report Card',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Report Card feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text(
              'Attendance Record',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Attendance feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text(
              'Quizzes & Tests',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Quizzes feature coming soon')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text(
              'Help Center',
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
