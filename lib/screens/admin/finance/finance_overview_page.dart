import 'package:flutter/material.dart';

/// FinanceOverviewPage - Displays an overview of the school's financial status
class FinanceOverviewPage extends StatefulWidget {
  const FinanceOverviewPage({super.key});

  @override
  State<FinanceOverviewPage> createState() => _FinanceOverviewPageState();
}

class _FinanceOverviewPageState extends State<FinanceOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFinancialSummaryCard(),
          const SizedBox(height: 20),
          _buildRecentTransactionsCard(),
          const SizedBox(height: 20),
          _buildCollectionStatsCard(),
          const SizedBox(height: 20),
          _buildUpcomingPaymentsCard(),
        ],
      ),
    );
  }

  Widget _buildFinancialSummaryCard() {
    return Card(
      elevation: 3,
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
                  'Financial Summary',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Export', style: TextStyle(fontFamily: 'Nunito')),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Export feature coming soon')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildFinancialInfoItem(
                    title: 'Total Revenue',
                    amount: '\$582,400',
                    trend: '+5.3%',
                    trendUp: true,
                    iconData: Icons.trending_up,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFinancialInfoItem(
                    title: 'Total Expenses',
                    amount: '\$245,800',
                    trend: '+2.1%',
                    trendUp: true,
                    iconData: Icons.trending_up,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFinancialInfoItem(
                    title: 'Net Balance',
                    amount: '\$336,600',
                    trend: '+7.8%',
                    trendUp: true,
                    iconData: Icons.trending_up,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCollectionRateItem(
                  title: 'Collection Rate',
                  percentage: '87.5%',
                  color: Colors.green,
                ),
                _buildCollectionRateItem(
                  title: 'Pending Fees',
                  percentage: '\$72,600',
                  color: Colors.orange,
                ),
                _buildCollectionRateItem(
                  title: 'Overdue Fees',
                  percentage: '\$24,300',
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialInfoItem({
    required String title,
    required String amount,
    required String trend,
    required bool trendUp,
    required IconData iconData,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          amount,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              iconData,
              color: color,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              trend,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' from last month',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCollectionRateItem({
    required String title,
    required String percentage,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          percentage,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactionsCard() {
    return Card(
      elevation: 3,
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
                  'Recent Transactions',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.visibility, size: 18),
                  label: const Text('View All', style: TextStyle(fontFamily: 'Nunito')),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('View all transactions coming soon')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildTransactionItem(
              studentName: 'John Smith',
              transactionType: 'Tuition Fee',
              amount: '\$1,200',
              date: '01 Sep 2025',
              status: 'Completed',
              statusColor: Colors.green,
            ),
            const Divider(),
            _buildTransactionItem(
              studentName: 'Emily Johnson',
              transactionType: 'Lab Fee',
              amount: '\$350',
              date: '31 Aug 2025',
              status: 'Completed',
              statusColor: Colors.green,
            ),
            const Divider(),
            _buildTransactionItem(
              studentName: 'Michael Brown',
              transactionType: 'Library Fee',
              amount: '\$120',
              date: '29 Aug 2025',
              status: 'Pending',
              statusColor: Colors.orange,
            ),
            const Divider(),
            _buildTransactionItem(
              studentName: 'Sarah Davis',
              transactionType: 'Sports Fee',
              amount: '\$250',
              date: '28 Aug 2025',
              status: 'Completed',
              statusColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required String studentName,
    required String transactionType,
    required String amount,
    required String date,
    required String status,
    required Color statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF4A55A2).withOpacity(0.2),
            child: Text(
              studentName[0],
              style: const TextStyle(
                fontFamily: 'Nunito',
                color: Color(0xFF4A55A2),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentName,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$transactionType - $date',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionStatsCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fee Collection Statistics',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCollectionStatItem(
                        gradeLevel: 'Grade 1-5',
                        collected: 92,
                        total: 100,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 12),
                      _buildCollectionStatItem(
                        gradeLevel: 'Grade 6-8',
                        collected: 85,
                        total: 100,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 12),
                      _buildCollectionStatItem(
                        gradeLevel: 'Grade 9-10',
                        collected: 78,
                        total: 100,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 12),
                      _buildCollectionStatItem(
                        gradeLevel: 'Grade 11-12',
                        collected: 65,
                        total: 100,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 2,
                  // In a real app, this would be a pie chart
                  child: Center(
                    child: Icon(
                      Icons.pie_chart,
                      size: 100,
                      color: Color(0xFF4A55A2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionStatItem({
    required String gradeLevel,
    required int collected,
    required int total,
    required Color color,
  }) {
    final double percentage = collected / total;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              gradeLevel,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$collected/$total',
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
          borderRadius: BorderRadius.circular(10),
        ),
        const SizedBox(height: 2),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${(percentage * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingPaymentsCard() {
    return Card(
      elevation: 3,
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
                  'Upcoming Fee Due Dates',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.notifications, size: 18),
                  label: const Text('Send Reminders', style: TextStyle(fontFamily: 'Nunito')),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reminders feature coming soon')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildUpcomingPaymentItem(
              title: 'Second Quarter Tuition',
              dueDate: '15 Sep 2025',
              amount: '\$145,000',
              daysLeft: 13,
              studentsCount: 290,
            ),
            const Divider(),
            _buildUpcomingPaymentItem(
              title: 'Annual Library Fee',
              dueDate: '30 Sep 2025',
              amount: '\$36,000',
              daysLeft: 28,
              studentsCount: 720,
            ),
            const Divider(),
            _buildUpcomingPaymentItem(
              title: 'Technology Fee',
              dueDate: '05 Oct 2025',
              amount: '\$72,000',
              daysLeft: 33,
              studentsCount: 720,
            ),
            const Divider(),
            _buildUpcomingPaymentItem(
              title: 'Sports & Activities',
              dueDate: '15 Oct 2025',
              amount: '\$58,000',
              daysLeft: 43,
              studentsCount: 580,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingPaymentItem({
    required String title,
    required String dueDate,
    required String amount,
    required int daysLeft,
    required int studentsCount,
  }) {
    final bool isUrgent = daysLeft < 15;
    final Color textColor = isUrgent ? Colors.red : Colors.black87;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isUrgent ? Colors.red.withOpacity(0.1) : const Color(0xFF4A55A2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isUrgent ? Icons.warning : Icons.calendar_today,
              color: isUrgent ? Colors.red : const Color(0xFF4A55A2),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  'Due: $dueDate ($daysLeft days left)',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: textColor,
                    fontWeight: isUrgent ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                '$studentsCount Students',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
