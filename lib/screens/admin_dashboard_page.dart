import 'package:flutter/material.dart';

/// AdminDashboardPage - Advanced dashboard for school administrators
class AdminDashboardPage extends StatefulWidget {
  /// Default constructor
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> with SingleTickerProviderStateMixin {
  // Current selected index for bottom navigation
  int _currentNavIndex = 0;
  
  // Controller for the top tabs
  late TabController _tabController;
  
  // Key for the scaffold to control drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Top tab categories by navigation section
  final List<Map<String, List<String>>> _navigationTabs = [
    // Finance & Fees tabs
    {
      'tabs': ['Overview', 'Payments', 'Invoices', 'Reports']
    },
    // Student Records tabs
    {
      'tabs': ['Directory', 'Admissions', 'Attendance', 'Discipline']
    },
    // Academics tabs
    {
      'tabs': ['Results', 'Performance', 'Curriculum', 'Schedule']
    },
    // Staff Management tabs
    {
      'tabs': ['Teachers', 'Attendance', 'Payroll', 'Evaluations']
    },
    // Communication tabs
    {
      'tabs': ['Messages', 'Notices', 'Events', 'Feedback']
    },
    // Reports tabs
    {
      'tabs': ['Financial', 'Academic', 'Staff', 'Export']
    },
  ];
  
  @override
  void initState() {
    super.initState();
    // Initialize tab controller with the tabs for the first nav item
    _tabController = TabController(
      length: _navigationTabs[_currentNavIndex]['tabs']!.length,
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
      // Create a new tab controller with the tabs for the selected nav item
      _tabController = TabController(
        length: _navigationTabs[_currentNavIndex]['tabs']!.length,
        vsync: this,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // App Bar with tabs
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A55A2), // Blue
        foregroundColor: Colors.white,
        title: Text(_getAppBarTitle()),
        centerTitle: false,
        elevation: 2,
        actions: _buildAppBarActions(),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: _navigationTabs[_currentNavIndex]['tabs']!.map((tab) {
            return Tab(text: tab);
          }).toList(),
        ),
      ),
      
      // Left drawer
      drawer: _buildDrawer(),
      
      // Main body with tab views
      body: TabBarView(
        controller: _tabController,
        children: _buildTabViews(),
      ),
      
      // Bottom navigation bar
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  
  // Get the title for the app bar based on current navigation index
  String _getAppBarTitle() {
    switch (_currentNavIndex) {
      case 0:
        return 'Finance & Fees';
      case 1:
        return 'Student Records';
      case 2:
        return 'Academics';
      case 3:
        return 'Staff Management';
      case 4:
        return 'Communication';
      case 5:
        return 'Reports';
      default:
        return 'Admin Dashboard';
    }
  }
  
  // Build the actions for the app bar
  List<Widget> _buildAppBarActions() {
    return [
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
      IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('More options coming soon')),
          );
        },
      ),
    ];
  }
  
  // Build the drawer with user info and navigation options
  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // User header
          UserAccountsDrawerHeader(
            accountName: const Text('Admin User'),
            accountEmail: const Text('admin@school.edu'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'A',
                style: TextStyle(
                  fontSize: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF4A55A2), // Blue
            ),
          ),
          
          // School Info
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('School Profile'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('School Profile coming soon')),
              );
            },
          ),
          
          // Settings
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('System Settings'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('System Settings coming soon')),
              );
            },
          ),
          
          // Academic Year
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Academic Calendar'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Academic Calendar coming soon')),
              );
            },
          ),
          
          // User Management
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('User Management'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User Management coming soon')),
              );
            },
          ),
          
          const Divider(),
          
          // Help
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help & Support coming soon')),
              );
            },
          ),
          
          // Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          
          const Spacer(),
          
          // Version info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0',
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
  
  // Build the bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentNavIndex,
      onTap: _changeNavIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF4A55A2), // Blue
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Finance',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Students',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Academics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Staff',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Comm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Reports',
        ),
      ],
    );
  }
  
  // Build the tab views for the current navigation section
  List<Widget> _buildTabViews() {
    switch (_currentNavIndex) {
      case 0: // Finance & Fees
        return [
          _buildFinanceOverviewTab(),
          _buildFinancePaymentsTab(),
          _buildFinanceInvoicesTab(),
          _buildFinanceReportsTab(),
        ];
      case 1: // Student Records
        return [
          _buildStudentDirectoryTab(),
          _buildStudentAdmissionsTab(),
          _buildStudentAttendanceTab(),
          _buildStudentDisciplineTab(),
        ];
      case 2: // Academics
        return [
          _buildAcademicsResultsTab(),
          _buildAcademicsPerformanceTab(),
          _buildAcademicsCurriculumTab(),
          _buildAcademicsScheduleTab(),
        ];
      case 3: // Staff Management
        return [
          _buildStaffTeachersTab(),
          _buildStaffAttendanceTab(),
          _buildStaffPayrollTab(),
          _buildStaffEvaluationsTab(),
        ];
      case 4: // Communication
        return [
          _buildCommunicationMessagesTab(),
          _buildCommunicationNoticesTab(),
          _buildCommunicationEventsTab(),
          _buildCommunicationFeedbackTab(),
        ];
      case 5: // Reports
        return [
          _buildReportsFinancialTab(),
          _buildReportsAcademicTab(),
          _buildReportsStaffTab(),
          _buildReportsExportTab(),
        ];
      default:
        return [Container()];
    }
  }
  
  // Finance & Fees Tab Views
  
  Widget _buildFinanceOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Financial Overview'),
          const SizedBox(height: 16),
          
          // Financial summary cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildStatCard('Total Collections', '\$145,280', Colors.green),
              _buildStatCard('Outstanding Fees', '\$32,450', Colors.red),
              _buildStatCard('This Month', '\$24,680', Colors.blue),
              _buildStatCard('Expenses', '\$118,350', Colors.orange),
            ],
          ),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Recent Transactions'),
          const SizedBox(height: 16),
          
          // Transactions list
          _buildTransactionItem('John Smith', 'Term 2 Fees', '\$850', Colors.green, Icons.arrow_upward),
          _buildTransactionItem('Emma Johnson', 'Library Fine', '\$25', Colors.green, Icons.arrow_upward),
          _buildTransactionItem('Supplies Purchase', 'Office Supplies', '\$320', Colors.red, Icons.arrow_downward),
          _buildTransactionItem('Sarah Williams', 'Activity Fee', '\$150', Colors.green, Icons.arrow_upward),
          _buildTransactionItem('Staff Salary', 'March 2023', '\$12,450', Colors.red, Icons.arrow_downward),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Fee Collection Progress'),
          const SizedBox(height: 16),
          
          // Fee collection progress
          _buildProgressIndicator('Grade 1', 0.92, Colors.green),
          _buildProgressIndicator('Grade 2', 0.85, Colors.green),
          _buildProgressIndicator('Grade 3', 0.78, Colors.amber),
          _buildProgressIndicator('Grade 4', 0.65, Colors.orange),
          _buildProgressIndicator('Grade 5', 0.58, Colors.red),
        ],
      ),
    );
  }
  
  Widget _buildFinancePaymentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Payments'),
          const SizedBox(height: 16),
          
          // Search and filter bar
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name or ID',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('New Payment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A55A2), // Blue
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Show payment form
                },
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Recent Payments'),
          const SizedBox(height: 16),
          
          // Payments list
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildDataTable([
              'Receipt #',
              'Student',
              'Payment Type',
              'Amount',
              'Date',
              'Actions'
            ], [
              ['REC-2023-001', 'John Smith', 'Term Fees', '\$850', '01/03/2023', 'View'],
              ['REC-2023-002', 'Emma Johnson', 'Library Fine', '\$25', '02/03/2023', 'View'],
              ['REC-2023-003', 'Sarah Williams', 'Activity Fee', '\$150', '03/03/2023', 'View'],
              ['REC-2023-004', 'Michael Brown', 'Term Fees', '\$850', '05/03/2023', 'View'],
              ['REC-2023-005', 'David Wilson', 'Lab Fee', '\$100', '07/03/2023', 'View'],
              ['REC-2023-006', 'Linda Martinez', 'Term Fees', '\$850', '10/03/2023', 'View'],
            ]),
          ),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Payment Methods'),
          const SizedBox(height: 16),
          
          // Payment methods
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPaymentMethodCard('Cash', Icons.money, 42),
              _buildPaymentMethodCard('Bank Transfer', Icons.account_balance, 28),
              _buildPaymentMethodCard('Mobile Money', Icons.phone_android, 18),
              _buildPaymentMethodCard('Other', Icons.more_horiz, 12),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildFinanceInvoicesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Invoices & Billing'),
          const SizedBox(height: 16),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search invoices',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('New Invoice'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A55A2), // Blue
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Show invoice form
                },
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Invoices'),
          const SizedBox(height: 16),
          
          // Invoices list
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildDataTable([
              'Invoice #',
              'Student',
              'Description',
              'Amount',
              'Status',
              'Actions'
            ], [
              ['INV-2023-001', 'John Smith', 'Term 2 Fees', '\$850', 'Paid', 'View'],
              ['INV-2023-002', 'Emma Johnson', 'Term 2 Fees', '\$850', 'Pending', 'View'],
              ['INV-2023-003', 'Sarah Williams', 'Term 2 Fees', '\$850', 'Overdue', 'View'],
              ['INV-2023-004', 'Michael Brown', 'Term 2 Fees', '\$850', 'Paid', 'View'],
              ['INV-2023-005', 'David Wilson', 'Term 2 Fees', '\$850', 'Pending', 'View'],
              ['INV-2023-006', 'Linda Martinez', 'Term 2 Fees', '\$850', 'Paid', 'View'],
            ]),
          ),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Fee Structure'),
          const SizedBox(height: 16),
          
          // Fee structure
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Academic Year Fee Structure',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeeItem('Tuition Fee', '\$600'),
                  _buildFeeItem('Lab Fee', '\$100'),
                  _buildFeeItem('Activity Fee', '\$150'),
                  _buildFeeItem('Total Per Term', '\$850'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                        onPressed: () {
                          // Show fee structure edit form
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFinanceReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Financial Reports'),
          const SizedBox(height: 16),
          
          // Report filters
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Generate Reports',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Report Type',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'collection', child: Text('Fee Collection')),
                            DropdownMenuItem(value: 'outstanding', child: Text('Outstanding Fees')),
                            DropdownMenuItem(value: 'expense', child: Text('Expenses')),
                            DropdownMenuItem(value: 'summary', child: Text('Financial Summary')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Time Period',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'daily', child: Text('Daily')),
                            DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                            DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                            DropdownMenuItem(value: 'yearly', child: Text('Yearly')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.print),
                        label: const Text('Print'),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.download),
                        label: const Text('Generate Report'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A55A2), // Blue
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Saved Reports'),
          const SizedBox(height: 16),
          
          // Saved reports
          _buildReportItem(
            'Fee Collection Report - March 2023',
            'Generated on 31/03/2023',
            Icons.assignment,
          ),
          _buildReportItem(
            'Outstanding Fees Report - Term 1',
            'Generated on 15/03/2023',
            Icons.assignment_late,
          ),
          _buildReportItem(
            'Expense Report - Q1 2023',
            'Generated on 01/04/2023',
            Icons.receipt_long,
          ),
          _buildReportItem(
            'Annual Financial Summary - 2022',
            'Generated on 10/01/2023',
            Icons.summarize,
          ),
        ],
      ),
    );
  }
  
  // Helper widgets for Finance section
  
  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTransactionItem(String name, String description, String amount, Color amountColor, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: amountColor.withOpacity(0.1),
          child: Icon(icon, color: amountColor),
        ),
        title: Text(name),
        subtitle: Text(description),
        trailing: Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: amountColor,
          ),
        ),
      ),
    );
  }
  
  Widget _buildProgressIndicator(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('${(value * 100).toInt()}%'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPaymentMethodCard(String title, IconData icon, int percentage) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: const Color(0xFF4A55A2)),
            const SizedBox(height: 8),
            Text(title),
            const SizedBox(height: 4),
            Text(
              '$percentage%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFeeItem(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReportItem(String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF4A55A2).withOpacity(0.1),
          child: Icon(icon, color: const Color(0xFF4A55A2)),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
  
  // Student Records Tab Views
  
  Widget _buildStudentDirectoryTab() {
    return Center(
      child: Text('Student Directory Tab - Coming Soon'),
    );
  }
  
  Widget _buildStudentAdmissionsTab() {
    return Center(
      child: Text('Student Admissions Tab - Coming Soon'),
    );
  }
  
  Widget _buildStudentAttendanceTab() {
    return Center(
      child: Text('Student Attendance Tab - Coming Soon'),
    );
  }
  
  Widget _buildStudentDisciplineTab() {
    return Center(
      child: Text('Student Discipline Tab - Coming Soon'),
    );
  }
  
  // Academics Tab Views
  
  Widget _buildAcademicsResultsTab() {
    return Center(
      child: Text('Academic Results Tab - Coming Soon'),
    );
  }
  
  Widget _buildAcademicsPerformanceTab() {
    return Center(
      child: Text('Performance Analytics Tab - Coming Soon'),
    );
  }
  
  Widget _buildAcademicsCurriculumTab() {
    return Center(
      child: Text('Curriculum Tab - Coming Soon'),
    );
  }
  
  Widget _buildAcademicsScheduleTab() {
    return Center(
      child: Text('Schedule Tab - Coming Soon'),
    );
  }
  
  // Staff Management Tab Views
  
  Widget _buildStaffTeachersTab() {
    return Center(
      child: Text('Teachers Tab - Coming Soon'),
    );
  }
  
  Widget _buildStaffAttendanceTab() {
    return Center(
      child: Text('Staff Attendance Tab - Coming Soon'),
    );
  }
  
  Widget _buildStaffPayrollTab() {
    return Center(
      child: Text('Payroll Tab - Coming Soon'),
    );
  }
  
  Widget _buildStaffEvaluationsTab() {
    return Center(
      child: Text('Staff Evaluations Tab - Coming Soon'),
    );
  }
  
  // Communication Tab Views
  
  Widget _buildCommunicationMessagesTab() {
    return Center(
      child: Text('Messages Tab - Coming Soon'),
    );
  }
  
  Widget _buildCommunicationNoticesTab() {
    return Center(
      child: Text('Notices Tab - Coming Soon'),
    );
  }
  
  Widget _buildCommunicationEventsTab() {
    return Center(
      child: Text('Events Tab - Coming Soon'),
    );
  }
  
  Widget _buildCommunicationFeedbackTab() {
    return Center(
      child: Text('Feedback Tab - Coming Soon'),
    );
  }
  
  // Reports Tab Views
  
  Widget _buildReportsFinancialTab() {
    return Center(
      child: Text('Financial Reports Tab - Coming Soon'),
    );
  }
  
  Widget _buildReportsAcademicTab() {
    return Center(
      child: Text('Academic Reports Tab - Coming Soon'),
    );
  }
  
  Widget _buildReportsStaffTab() {
    return Center(
      child: Text('Staff Reports Tab - Coming Soon'),
    );
  }
  
  Widget _buildReportsExportTab() {
    return Center(
      child: Text('Export Reports Tab - Coming Soon'),
    );
  }
  
  // Common Widgets
  
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  
  Widget _buildDataTable(List<String> columns, List<List<String>> rows) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns.map((col) => DataColumn(label: Text(col))).toList(),
        rows: rows.map((row) {
          return DataRow(
            cells: row.map((cell) {
              // For the "View" action, return a button
              if (cell == 'View') {
                return DataCell(
                  TextButton(
                    child: const Text('View'),
                    onPressed: () {},
                  ),
                );
              }
              // For status cells, style based on the status
              else if (columns.contains('Status') && row[columns.indexOf('Status')] == cell) {
                Color statusColor;
                switch (cell) {
                  case 'Paid':
                    statusColor = Colors.green;
                    break;
                  case 'Pending':
                    statusColor = Colors.orange;
                    break;
                  case 'Overdue':
                    statusColor = Colors.red;
                    break;
                  default:
                    statusColor = Colors.black;
                }
                
                return DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      cell,
                      style: TextStyle(
                        color: statusColor,
                      ),
                    ),
                  ),
                );
              } 
              // For all other cells, return plain text
              else {
                return DataCell(Text(cell));
              }
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
