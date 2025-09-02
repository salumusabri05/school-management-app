import 'package:flutter/material.dart';
import 'package:school/screens/admin/reports/reports_performance_page.dart';
import 'package:school/screens/admin/reports/reports_attendance_page.dart';

/// ReportsPage - Main page for the reports section that provides navigation to different report types
class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabTitles = [
    'Overview',
    'Performance',
    'Attendance',
    'Financial',
    'Behavior',
    'Staff'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: const Color(0xFF4A55A2),
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            indicatorColor: const Color(0xFF4A55A2),
            tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReportsOverview(),
          const ReportsPerformancePage(),
          const ReportsAttendancePage(),
          _buildFinancialReports(),
          _buildBehaviorReports(),
          _buildStaffReports(),
        ],
      ),
    );
  }

  // Reports overview dashboard with quick access to all report types
  Widget _buildReportsOverview() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(),
          const SizedBox(height: 24),
          _buildQuickStatsRow(),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildReportCategoriesGrid(),
                  const SizedBox(height: 24),
                  _buildRecentReportsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reports Dashboard',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Get insights and analytics from all school operations',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Generate Report'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A55A2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Generate report feature coming soon')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickStatsRow() {
    return Row(
      children: [
        _buildQuickStatCard(
          icon: Icons.school,
          color: Colors.blue,
          title: 'Students',
          value: '650',
          trend: '+15',
          trendUp: true,
        ),
        _buildQuickStatCard(
          icon: Icons.people,
          color: Colors.purple,
          title: 'Staff',
          value: '78',
          trend: '+3',
          trendUp: true,
        ),
        _buildQuickStatCard(
          icon: Icons.insert_chart,
          color: Colors.green,
          title: 'Avg. Performance',
          value: '76%',
          trend: '+1.2%',
          trendUp: true,
        ),
        _buildQuickStatCard(
          icon: Icons.attach_money,
          color: Colors.amber,
          title: 'Revenue',
          value: '\$98.5K',
          trend: '+5.4%',
          trendUp: true,
        ),
      ],
    );
  }

  Widget _buildQuickStatCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    required String trend,
    required bool trendUp,
  }) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  Row(
                    children: [
                      Icon(
                        trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                        color: trendUp ? Colors.green : Colors.red,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        trend,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: trendUp ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportCategoriesGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildReportCategoryCard(
          title: 'Academic Performance',
          description: 'Student grades, assessments, and progress tracking',
          icon: Icons.bar_chart,
          color: const Color(0xFF4A55A2),
          onTap: () => _tabController.animateTo(1), // Performance tab
        ),
        _buildReportCategoryCard(
          title: 'Attendance Reports',
          description: 'Student and staff attendance patterns and statistics',
          icon: Icons.people,
          color: Colors.teal,
          onTap: () => _tabController.animateTo(2), // Attendance tab
        ),
        _buildReportCategoryCard(
          title: 'Financial Reports',
          description: 'Revenue, expenses, fees collection and budget analysis',
          icon: Icons.account_balance,
          color: Colors.amber[700]!,
          onTap: () => _tabController.animateTo(3), // Financial tab
        ),
        _buildReportCategoryCard(
          title: 'Behavior & Discipline',
          description: 'Student conduct, incidents and disciplinary actions',
          icon: Icons.psychology,
          color: Colors.deepOrange,
          onTap: () => _tabController.animateTo(4), // Behavior tab
        ),
        _buildReportCategoryCard(
          title: 'Staff Performance',
          description: 'Teacher evaluations, workload and efficiency metrics',
          icon: Icons.group,
          color: Colors.purple,
          onTap: () => _tabController.animateTo(5), // Staff tab
        ),
        _buildReportCategoryCard(
          title: 'Custom Reports',
          description: 'Generate custom reports based on specific requirements',
          icon: Icons.dashboard_customize,
          color: Colors.indigo,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Custom reports feature coming soon')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildReportCategoryCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.arrow_forward, color: color, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentReportsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Reports',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('View all reports feature coming soon')),
                );
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildRecentReportItem(
                title: 'Q1 Academic Performance Summary',
                category: 'Performance',
                date: 'Mar 15, 2024',
                icon: Icons.bar_chart,
                color: const Color(0xFF4A55A2),
              ),
              const Divider(height: 1),
              _buildRecentReportItem(
                title: 'Monthly Attendance Analysis - Grade 9',
                category: 'Attendance',
                date: 'Mar 10, 2024',
                icon: Icons.people,
                color: Colors.teal,
              ),
              const Divider(height: 1),
              _buildRecentReportItem(
                title: 'February Financial Statement',
                category: 'Financial',
                date: 'Mar 5, 2024',
                icon: Icons.account_balance,
                color: Colors.amber[700]!,
              ),
              const Divider(height: 1),
              _buildRecentReportItem(
                title: 'Staff Performance Evaluation - Q1',
                category: 'Staff',
                date: 'Feb 28, 2024',
                icon: Icons.group,
                color: Colors.purple,
              ),
              const Divider(height: 1),
              _buildRecentReportItem(
                title: 'Discipline Incidents - February',
                category: 'Behavior',
                date: 'Feb 25, 2024',
                icon: Icons.psychology,
                color: Colors.deepOrange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentReportItem({
    required String title,
    required String category,
    required String date,
    required IconData icon,
    required Color color,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              date,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.download, size: 20),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Download report feature coming soon')),
          );
        },
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('View report details feature coming soon')),
        );
      },
    );
  }

  // Placeholder for financial reports tab
  Widget _buildFinancialReports() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance,
            size: 64,
            color: Colors.amber[700],
          ),
          const SizedBox(height: 16),
          const Text(
            'Financial Reports',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Financial reports module coming soon',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _tabController.animateTo(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A55A2),
              foregroundColor: Colors.white,
            ),
            child: const Text('Back to Overview'),
          ),
        ],
      ),
    );
  }

  // Placeholder for behavior reports tab
  Widget _buildBehaviorReports() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.psychology,
            size: 64,
            color: Colors.deepOrange,
          ),
          const SizedBox(height: 16),
          const Text(
            'Behavior & Discipline Reports',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Behavior reports module coming soon',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _tabController.animateTo(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A55A2),
              foregroundColor: Colors.white,
            ),
            child: const Text('Back to Overview'),
          ),
        ],
      ),
    );
  }

  // Placeholder for staff reports tab
  Widget _buildStaffReports() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.group,
            size: 64,
            color: Colors.purple,
          ),
          const SizedBox(height: 16),
          const Text(
            'Staff Performance Reports',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Staff performance reports module coming soon',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _tabController.animateTo(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A55A2),
              foregroundColor: Colors.white,
            ),
            child: const Text('Back to Overview'),
          ),
        ],
      ),
    );
  }
}
