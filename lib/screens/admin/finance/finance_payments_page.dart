import 'package:flutter/material.dart';

/// FinancePaymentsPage - Manages and processes student fee payments
class FinancePaymentsPage extends StatefulWidget {
  const FinancePaymentsPage({super.key});

  @override
  State<FinancePaymentsPage> createState() => _FinancePaymentsPageState();
}

class _FinancePaymentsPageState extends State<FinancePaymentsPage> {
  // Mock data for payments
  final List<Map<String, dynamic>> _recentPayments = [
    {
      'studentName': 'Emily Johnson',
      'id': 'S1052',
      'grade': 'Grade 10',
      'paymentAmount': '\$1,200',
      'paymentDate': '01 Sep 2025',
      'paymentMethod': 'Credit Card',
      'transactionId': 'TXN-78945612',
      'status': 'Completed',
    },
    {
      'studentName': 'David Wilson',
      'id': 'S1128',
      'grade': 'Grade 8',
      'paymentAmount': '\$950',
      'paymentDate': '31 Aug 2025',
      'paymentMethod': 'Bank Transfer',
      'transactionId': 'TXN-78945589',
      'status': 'Completed',
    },
    {
      'studentName': 'Sophia Martinez',
      'id': 'S1043',
      'grade': 'Grade 11',
      'paymentAmount': '\$1,350',
      'paymentDate': '30 Aug 2025',
      'paymentMethod': 'PayPal',
      'transactionId': 'TXN-78945520',
      'status': 'Pending',
    },
    {
      'studentName': 'James Brown',
      'id': 'S1076',
      'grade': 'Grade 9',
      'paymentAmount': '\$1,150',
      'paymentDate': '29 Aug 2025',
      'paymentMethod': 'Credit Card',
      'transactionId': 'TXN-78945480',
      'status': 'Completed',
    },
    {
      'studentName': 'Olivia Smith',
      'id': 'S1018',
      'grade': 'Grade 12',
      'paymentAmount': '\$1,400',
      'paymentDate': '28 Aug 2025',
      'paymentMethod': 'Bank Transfer',
      'transactionId': 'TXN-78945412',
      'status': 'Failed',
    },
  ];

  // Filters
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Completed', 'Pending', 'Failed'];

  // Search controller
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterBar(),
          const SizedBox(height: 16),
          _buildSearchAndActionButtons(),
          const SizedBox(height: 16),
          _buildPaymentsList(),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          final option = _filterOptions[index];
          final isSelected = option == _selectedFilter;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              selected: isSelected,
              label: Text(
                option,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              backgroundColor: Colors.grey[200],
              selectedColor: const Color(0xFF4A55A2),
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = option;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchAndActionButtons() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by name, ID, or transaction ID',
              hintStyle: const TextStyle(fontFamily: 'Nunito'),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            style: const TextStyle(fontFamily: 'Nunito'),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Record Payment', style: TextStyle(fontFamily: 'Nunito')),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A55A2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onPressed: () {
            _showRecordPaymentDialog(context);
          },
        ),
      ],
    );
  }

  Widget _buildPaymentsList() {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Payments',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Export feature coming soon')),
                      );
                    },
                    tooltip: 'Export as CSV',
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            _buildPaymentsTableHeader(),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemCount: _recentPayments.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final payment = _recentPayments[index];
                  return _buildPaymentRow(payment);
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Showing ${_recentPayments.length} entries',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 18),
                        onPressed: () {
                          // Pagination logic would go here
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A55A2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 18),
                        onPressed: () {
                          // Pagination logic would go here
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentsTableHeader() {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              'Student',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Payment',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Method',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Status',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(Map<String, dynamic> payment) {
    Color statusColor;
    
    switch (payment['status']) {
      case 'Completed':
        statusColor = Colors.green;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Failed':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }
    
    return InkWell(
      onTap: () {
        _showPaymentDetailsDialog(context, payment);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment['studentName'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${payment['id']} | ${payment['grade']}',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment['paymentAmount'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    payment['paymentDate'],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment['paymentMethod'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                    ),
                  ),
                  Text(
                    payment['transactionId'],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  payment['status'],
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
              child: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  switch (value) {
                    case 'details':
                      _showPaymentDetailsDialog(context, payment);
                      break;
                    case 'receipt':
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Print receipt feature coming soon')),
                      );
                      break;
                    case 'edit':
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit payment feature coming soon')),
                      );
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'details',
                    child: Text('View Details', style: TextStyle(fontFamily: 'Nunito')),
                  ),
                  const PopupMenuItem<String>(
                    value: 'receipt',
                    child: Text('Print Receipt', style: TextStyle(fontFamily: 'Nunito')),
                  ),
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: Text('Edit Payment', style: TextStyle(fontFamily: 'Nunito')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentDetailsDialog(BuildContext context, Map<String, dynamic> payment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.receipt, color: Color(0xFF4A55A2)),
              const SizedBox(width: 8),
              const Text(
                'Payment Details',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDetailItem('Student Name', payment['studentName']),
                  _buildDetailItem('Student ID', payment['id']),
                  _buildDetailItem('Grade', payment['grade']),
                  const Divider(),
                  _buildDetailItem('Amount', payment['paymentAmount']),
                  _buildDetailItem('Payment Date', payment['paymentDate']),
                  _buildDetailItem('Payment Method', payment['paymentMethod']),
                  _buildDetailItem('Transaction ID', payment['transactionId']),
                  _buildDetailItem('Status', payment['status'], 
                    valueColor: payment['status'] == 'Completed' 
                      ? Colors.green 
                      : payment['status'] == 'Pending'
                        ? Colors.orange
                        : Colors.red),
                ],
              ),
            ),
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.print),
              label: const Text('Print Receipt'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Print receipt feature coming soon')),
                );
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailItem(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRecordPaymentDialog(BuildContext context) {
    final _studentController = TextEditingController();
    final _amountController = TextEditingController();
    String _selectedPaymentMethod = 'Credit Card';
    final List<String> _paymentMethods = ['Credit Card', 'Bank Transfer', 'Cash', 'PayPal'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: const [
                  Icon(Icons.payments, color: Color(0xFF4A55A2)),
                  SizedBox(width: 8),
                  Text(
                    'Record New Payment',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _studentController,
                        decoration: const InputDecoration(
                          labelText: 'Student ID or Name',
                          labelStyle: TextStyle(fontFamily: 'Nunito'),
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontFamily: 'Nunito'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Payment Amount',
                          labelStyle: TextStyle(fontFamily: 'Nunito'),
                          prefixText: '\$ ',
                          prefixStyle: TextStyle(fontFamily: 'Nunito'),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontFamily: 'Nunito'),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Payment Method',
                          labelStyle: TextStyle(fontFamily: 'Nunito'),
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedPaymentMethod,
                        items: _paymentMethods.map((method) {
                          return DropdownMenuItem<String>(
                            value: method,
                            child: Text(method, style: const TextStyle(fontFamily: 'Nunito')),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedPaymentMethod = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Notes (Optional)',
                          labelStyle: TextStyle(fontFamily: 'Nunito'),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontFamily: 'Nunito'),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Payment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A55A2),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Save payment logic would go here
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment recorded successfully')),
                    );
                    // In a real app, we would refresh the payments list here
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
