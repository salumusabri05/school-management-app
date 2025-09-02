import 'package:flutter/material.dart';

/// FinanceInvoicesPage - Manages and generates student fee invoices
class FinanceInvoicesPage extends StatefulWidget {
  const FinanceInvoicesPage({super.key});

  @override
  State<FinanceInvoicesPage> createState() => _FinanceInvoicesPageState();
}

class _FinanceInvoicesPageState extends State<FinanceInvoicesPage> {
  // Mock data for invoices
  final List<Map<String, dynamic>> _invoices = [
    {
      'invoiceNumber': 'INV-2025-1125',
      'studentName': 'Michael Brown',
      'id': 'S1076',
      'grade': 'Grade 9',
      'amount': '\$1,150',
      'issueDate': '15 Aug 2025',
      'dueDate': '15 Sep 2025',
      'status': 'Unpaid',
      'items': [
        {'description': 'Tuition Fee', 'amount': '\$900'},
        {'description': 'Technology Fee', 'amount': '\$150'},
        {'description': 'Library Fee', 'amount': '\$100'},
      ],
    },
    {
      'invoiceNumber': 'INV-2025-1124',
      'studentName': 'Sophia Martinez',
      'id': 'S1043',
      'grade': 'Grade 11',
      'amount': '\$1,350',
      'issueDate': '15 Aug 2025',
      'dueDate': '15 Sep 2025',
      'status': 'Unpaid',
      'items': [
        {'description': 'Tuition Fee', 'amount': '\$1,100'},
        {'description': 'Technology Fee', 'amount': '\$150'},
        {'description': 'Library Fee', 'amount': '\$100'},
      ],
    },
    {
      'invoiceNumber': 'INV-2025-1123',
      'studentName': 'Emily Johnson',
      'id': 'S1052',
      'grade': 'Grade 10',
      'amount': '\$1,200',
      'issueDate': '15 Aug 2025',
      'dueDate': '15 Sep 2025',
      'status': 'Paid',
      'items': [
        {'description': 'Tuition Fee', 'amount': '\$950'},
        {'description': 'Technology Fee', 'amount': '\$150'},
        {'description': 'Library Fee', 'amount': '\$100'},
      ],
      'paymentDate': '01 Sep 2025',
      'transactionId': 'TXN-78945612',
    },
    {
      'invoiceNumber': 'INV-2025-1122',
      'studentName': 'James Rodriguez',
      'id': 'S1029',
      'grade': 'Grade 12',
      'amount': '\$1,450',
      'issueDate': '15 Aug 2025',
      'dueDate': '15 Sep 2025',
      'status': 'Overdue',
      'items': [
        {'description': 'Tuition Fee', 'amount': '\$1,200'},
        {'description': 'Technology Fee', 'amount': '\$150'},
        {'description': 'Library Fee', 'amount': '\$100'},
      ],
    },
    {
      'invoiceNumber': 'INV-2025-1121',
      'studentName': 'David Wilson',
      'id': 'S1128',
      'grade': 'Grade 8',
      'amount': '\$950',
      'issueDate': '15 Aug 2025',
      'dueDate': '15 Sep 2025',
      'status': 'Partially Paid',
      'items': [
        {'description': 'Tuition Fee', 'amount': '\$700'},
        {'description': 'Technology Fee', 'amount': '\$150'},
        {'description': 'Library Fee', 'amount': '\$100'},
      ],
      'paymentDate': '31 Aug 2025',
      'paidAmount': '\$500',
      'balanceAmount': '\$450',
    },
  ];

  // Filters
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Paid', 'Unpaid', 'Overdue', 'Partially Paid'];

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
          _buildInvoicesList(),
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
              hintText: 'Search by invoice #, student name, or ID',
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
          label: const Text('Create Invoice', style: TextStyle(fontFamily: 'Nunito')),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A55A2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onPressed: () {
            _showCreateInvoiceDialog(context);
          },
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.send),
          label: const Text('Bulk Send', style: TextStyle(fontFamily: 'Nunito')),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bulk send feature coming soon')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInvoicesList() {
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
                    'Invoices',
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
            _buildInvoicesTableHeader(),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemCount: _invoices.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final invoice = _invoices[index];
                  return _buildInvoiceRow(invoice);
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
                    'Showing ${_invoices.length} entries',
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

  Widget _buildInvoicesTableHeader() {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Text(
              'Invoice',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
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
              'Amount',
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
              'Due Date',
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

  Widget _buildInvoiceRow(Map<String, dynamic> invoice) {
    Color statusColor;
    
    switch (invoice['status']) {
      case 'Paid':
        statusColor = Colors.green;
        break;
      case 'Partially Paid':
        statusColor = Colors.blue;
        break;
      case 'Unpaid':
        statusColor = Colors.orange;
        break;
      case 'Overdue':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }
    
    return InkWell(
      onTap: () {
        _showInvoiceDetailsDialog(context, invoice);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice['invoiceNumber'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Issued: ${invoice['issueDate']}',
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
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice['studentName'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${invoice['id']} | ${invoice['grade']}',
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
              child: Text(
                invoice['amount'],
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                invoice['dueDate'],
                style: const TextStyle(
                  fontFamily: 'Nunito',
                ),
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
                  invoice['status'],
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
                      _showInvoiceDetailsDialog(context, invoice);
                      break;
                    case 'print':
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Print invoice feature coming soon')),
                      );
                      break;
                    case 'email':
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email invoice feature coming soon')),
                      );
                      break;
                    case 'edit':
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit invoice feature coming soon')),
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
                    value: 'print',
                    child: Text('Print Invoice', style: TextStyle(fontFamily: 'Nunito')),
                  ),
                  const PopupMenuItem<String>(
                    value: 'email',
                    child: Text('Email Invoice', style: TextStyle(fontFamily: 'Nunito')),
                  ),
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: Text('Edit Invoice', style: TextStyle(fontFamily: 'Nunito')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInvoiceDetailsDialog(BuildContext context, Map<String, dynamic> invoice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'INVOICE',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF4A55A2),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          invoice['invoiceNumber'],
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Issue Date: ${invoice['issueDate']}',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'BILL TO',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            invoice['studentName'],
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${invoice['id']} | ${invoice['grade']}',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: Colors.grey[600],
                            ),
                          ),
                          const Text(
                            'Parent: Mr. & Mrs. Smith',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DUE DATE',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            invoice['dueDate'],
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(invoice['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              invoice['status'],
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                color: _getStatusColor(invoice['status']),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                              flex: 5,
                              child: Text(
                                'DESCRIPTION',
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
                                'AMOUNT',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, thickness: 1),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: invoice['items'].length,
                        itemBuilder: (context, index) {
                          final item = invoice['items'][index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    item['description'],
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item['amount'],
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 5,
                              child: Text(
                                'TOTAL AMOUNT',
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
                                invoice['amount'],
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (invoice['status'] == 'Partially Paid')
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'PAYMENT RECEIVED',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                invoice['paidAmount'],
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'BALANCE DUE',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                invoice['balanceAmount'],
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (invoice['status'] == 'Paid')
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PAYMENT INFORMATION',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Payment Date: ${invoice['paymentDate']}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Transaction ID: ${invoice['transactionId']}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                const Text(
                  'PAYMENT INSTRUCTIONS',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1. Please make payment before the due date.\n'
                  '2. Payment can be made online through the parent portal.\n'
                  '3. For bank transfers, use the school\'s account details below:\n'
                  '   Bank: National Bank\n'
                  '   Account Name: ABC School\n'
                  '   Account Number: 1234-5678-9012\n'
                  '4. Late payments will incur a 5% late fee.',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.print),
                      label: const Text('Print Invoice'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Print invoice feature coming soon')),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      icon: const Icon(Icons.email),
                      label: const Text('Email Invoice'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email invoice feature coming soon')),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    if (invoice['status'] != 'Paid')
                      ElevatedButton.icon(
                        icon: const Icon(Icons.payments),
                        label: const Text('Record Payment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A55A2),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Record payment feature coming soon')),
                          );
                        },
                      ),
                    if (invoice['status'] == 'Paid')
                      ElevatedButton.icon(
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Close'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return Colors.green;
      case 'Partially Paid':
        return Colors.blue;
      case 'Unpaid':
        return Colors.orange;
      case 'Overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showCreateInvoiceDialog(BuildContext context) {
    final _studentController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.receipt, color: Color(0xFF4A55A2), size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Create New Invoice',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Select students or classes to create invoices for:',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _studentController,
                  decoration: const InputDecoration(
                    labelText: 'Search students or classes',
                    labelStyle: TextStyle(fontFamily: 'Nunito'),
                    hintText: 'Enter student name, ID or class',
                    hintStyle: TextStyle(fontFamily: 'Nunito'),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontFamily: 'Nunito'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Or select by category:',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildSelectionChip('Grade 1'),
                    _buildSelectionChip('Grade 2'),
                    _buildSelectionChip('Grade 3'),
                    _buildSelectionChip('Grade 4'),
                    _buildSelectionChip('Grade 5'),
                    _buildSelectionChip('Grade 6'),
                    _buildSelectionChip('Grade 7'),
                    _buildSelectionChip('Grade 8'),
                    _buildSelectionChip('Grade 9'),
                    _buildSelectionChip('Grade 10'),
                    _buildSelectionChip('Grade 11'),
                    _buildSelectionChip('Grade 12'),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Select fee type:',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildSelectionChip('Tuition Fee'),
                    _buildSelectionChip('Technology Fee'),
                    _buildSelectionChip('Library Fee'),
                    _buildSelectionChip('Sports Fee'),
                    _buildSelectionChip('Transport Fee'),
                    _buildSelectionChip('Lab Fee'),
                    _buildSelectionChip('Custom Fee'),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Due Date:',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: const [
                              Text(
                                '15 Oct 2025',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.calendar_today, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '0 students selected',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.receipt_long),
                      label: const Text('Generate Invoices'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A55A2),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invoice generation feature coming soon')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectionChip(String label) {
    return FilterChip(
      label: Text(
        label,
        style: const TextStyle(fontFamily: 'Nunito'),
      ),
      selected: false,
      onSelected: (bool selected) {
        // Selection logic would go here
      },
    );
  }
}
