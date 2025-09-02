import 'package:flutter/material.dart';

/// ParentDashboardPage - Dashboard for parents with navigation and UI structure
///
/// This page provides a comprehensive interface for parents to access their children's
/// academic information, attendance, fees, and communication channels with teachers.
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
      'title': 'Dashboard',
      'icon': Icons.dashboard,
      'tabs': ['Overview', 'Calendar', 'Notices']
    },
    {
      'title': 'Children',
      'icon': Icons.people,
      'tabs': ['Academic', 'Attendance', 'Behavior']
    },
    {
      'title': 'Finances',
      'icon': Icons.payments,
      'tabs': ['Fees', 'Payments', 'History']
    },
    {
      'title': 'Communication',
      'icon': Icons.message,
      'tabs': ['Teachers', 'Admin', 'Other Parents']
    },
    {
      'title': 'Resources',
      'icon': Icons.article,
      'tabs': ['School Info', 'Policies', 'Help']
    }
  ];

  // List of children (in a real app, this would come from a database)
  final List<Map<String, dynamic>> _children = [
    {
      'name': 'Emily Johnson',
      'grade': '8th Grade',
      'attendance': '95%',
      'section': 'Science A',
      'image': 'assets/logo.png', // Placeholder, would be child's photo
      'gpa': '3.8',
    },
    {
      'name': 'Daniel Johnson',
      'grade': '5th Grade',
      'attendance': '92%',
      'section': 'Elementary B',
      'image': 'assets/logo.png', // Placeholder, would be child's photo
      'gpa': '3.6',
    },
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
          backgroundColor: const Color(0xFF4E8DDF), // Blue
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
              icon: const Icon(Icons.settings),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings coming soon')),
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
                return _buildTabContent(_currentNavIndex, tab);
              })
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          onTap: _changeNavIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF4E8DDF), // Blue
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
        floatingActionButton: _currentNavIndex == 3 // Show FAB on Communication tab
            ? FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('New message feature coming soon')),
                  );
                },
                backgroundColor: const Color(0xFF4E8DDF), // Blue
                child: const Icon(Icons.add_comment),
              )
            : null,
      ),
    );
  }

  Widget _buildTabContent(int navIndex, String tab) {
    // Dashboard Overview Tab
    if (navIndex == 0 && tab == 'Overview') {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChildrenOverviewCards(),
            const SizedBox(height: 16),
            _buildUpcomingEventsCard(),
            const SizedBox(height: 16),
            _buildRecentMessagesCard(),
            const SizedBox(height: 16),
            _buildQuickActionsCard(),
          ],
        ),
      );
    }
    
    // Finances Fees Tab
    if (navIndex == 2 && tab == 'Fees') {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeeSummaryCard(),
            const SizedBox(height: 16),
            _buildPendingFeesCard(),
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

  Widget _buildChildrenOverviewCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Children',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _children.length,
          itemBuilder: (context, index) {
            final child = _children[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                child['name'],
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${child['grade']} • ${child['section']}',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildChildStatCard('Attendance', child['attendance'], Icons.timer, Colors.green),
                        _buildChildStatCard('GPA', child['gpa'], Icons.school, Colors.blue),
                        _buildChildStatCard('Homework', '2 Due', Icons.assignment, Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${child['name']}\'s detailed profile coming soon')),
                          );
                        },
                        child: const Text(
                          'View Full Profile',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Color(0xFF4E8DDF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingEventsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Events',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            _buildEventItem(
              'Parent-Teacher Meeting',
              DateTime.now().add(const Duration(days: 3)),
              'School Auditorium',
              Colors.blue,
            ),
            _buildEventItem(
              'Annual Sports Day',
              DateTime.now().add(const Duration(days: 12)),
              'School Ground',
              Colors.green,
            ),
            _buildEventItem(
              'Science Exhibition',
              DateTime.now().add(const Duration(days: 18)),
              'School Hall',
              Colors.orange,
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'View All Events',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Color(0xFF4E8DDF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventItem(String title, DateTime date, String location, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
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
                  location,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${date.day}/${date.month}/${date.year}',
            style: TextStyle(
              fontFamily: 'Nunito',
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMessagesCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Messages',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '3 New',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            _buildMessageItem(
              'Mrs. Wilson',
              'Math Teacher',
              'About Daniel\'s recent math test performance',
              DateTime.now().subtract(const Duration(hours: 3)),
              true,
            ),
            _buildMessageItem(
              'Principal Roberts',
              'Administration',
              'Information about upcoming school renovation',
              DateTime.now().subtract(const Duration(days: 1)),
              true,
            ),
            _buildMessageItem(
              'Mr. Thompson',
              'Science Teacher',
              'Emily\'s science project received top marks',
              DateTime.now().subtract(const Duration(days: 2)),
              true,
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'View All Messages',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Color(0xFF4E8DDF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(
      String sender, String role, String preview, DateTime time, bool isUnread) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF4E8DDF).withOpacity(0.2),
                child: Text(
                  sender[0],
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    color: Color(0xFF4E8DDF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isUnread)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  preview,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13,
                    color: isUnread ? Colors.black : Colors.grey[600],
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            _getTimeAgo(time),
            style: TextStyle(
              fontFamily: 'Nunito',
              color: isUnread ? const Color(0xFF4E8DDF) : Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: [
                _buildQuickActionItem('Pay Fees', Icons.payment, Colors.green),
                _buildQuickActionItem('Apply Leave', Icons.calendar_today, Colors.orange),
                _buildQuickActionItem('Schedule Meeting', Icons.person, Colors.purple),
                _buildQuickActionItem('View Report', Icons.assessment, Colors.blue),
                _buildQuickActionItem('School Bus', Icons.directions_bus, Colors.amber),
                _buildQuickActionItem('Calendar', Icons.event, Colors.teal),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title feature coming soon')),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeeSummaryCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fees Summary - 2023/24',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: _buildFeeSummaryItem('Total Fees', '\$8,500', Colors.blue),
                ),
                Expanded(
                  child: _buildFeeSummaryItem('Paid', '\$5,500', Colors.green),
                ),
                Expanded(
                  child: _buildFeeSummaryItem('Pending', '\$3,000', Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 5500 / 8500, // Paid / Total
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              'Payment Progress: ${(5500 / 8500 * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment feature coming soon')),
                );
              },
              icon: const Icon(Icons.payment),
              label: const Text(
                'Make a Payment',
                style: TextStyle(fontFamily: 'Nunito'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E8DDF),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeSummaryItem(String title, String amount, Color color) {
    return Column(
      children: [
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'Nunito',
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Nunito',
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildPendingFeesCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pending Fees',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            _buildPendingFeeItem(
              'Second Term Tuition',
              '\$1,800',
              DateTime.now().add(const Duration(days: 10)),
            ),
            _buildPendingFeeItem(
              'Annual Library Fee',
              '\$500',
              DateTime.now().add(const Duration(days: 20)),
            ),
            _buildPendingFeeItem(
              'School Trip - Science Museum',
              '\$700',
              DateTime.now().add(const Duration(days: 45)),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'View Payment History',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Color(0xFF4E8DDF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingFeeItem(String title, String amount, DateTime dueDate) {
    final bool isUrgent = dueDate.difference(DateTime.now()).inDays < 15;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: isUrgent ? Colors.red : Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Due: ${dueDate.day}/${dueDate.month}/${dueDate.year}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 13,
                        color: isUrgent ? Colors.red : Colors.grey[600],
                        fontWeight: isUrgent ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              amount,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment feature coming soon')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isUrgent ? Colors.red : const Color(0xFF4E8DDF),
              foregroundColor: Colors.white,
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: const Text(
              'Pay',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
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
              'Sarah Johnson',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              'Parent of 2 Children',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'SJ',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF4E8DDF),
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF4E8DDF), // Blue
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
            leading: const Icon(Icons.family_restroom),
            title: const Text(
              'Family Details',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Family Details feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text(
              'Payment Receipts',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment Receipts feature coming soon')),
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
            leading: const Icon(Icons.settings),
            title: const Text(
              'Settings',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings feature coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text(
              'Help Center',
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help Center feature coming soon')),
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
