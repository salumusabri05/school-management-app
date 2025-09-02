import 'package:flutter/material.dart';

/// CommunicationAnnouncementsPage - Allows admin to create, manage and send announcements to various groups
class CommunicationAnnouncementsPage extends StatefulWidget {
  const CommunicationAnnouncementsPage({super.key});

  @override
  State<CommunicationAnnouncementsPage> createState() => _CommunicationAnnouncementsPageState();
}

class _CommunicationAnnouncementsPageState extends State<CommunicationAnnouncementsPage> {
  // Controllers for the announcement creation form
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  
  // Selected recipients
  String _selectedRecipientGroup = 'All';
  String _selectedPriority = 'Normal';
  
  // Tab index
  int _selectedTabIndex = 0;
  
  // Mock data for announcements
  final List<Map<String, dynamic>> _announcements = [
    {
      'id': 'A1001',
      'title': 'School Closing for Annual Maintenance',
      'message': 'Dear all, please note that the school will be closed for annual maintenance from 15th July to 20th July. All classes and activities will resume on 21st July. Please plan accordingly.',
      'sender': 'Principal',
      'recipients': 'All',
      'sentDate': '10 Jul 2023',
      'priority': 'High',
      'status': 'Active',
      'attachments': [],
    },
    {
      'id': 'A1002',
      'title': 'Staff Meeting - Curriculum Development',
      'message': 'All teaching staff are required to attend the curriculum development meeting on Friday, 5th August at 3:00 PM in the conference room. Please bring your subject plans and any suggestions for improvements.',
      'sender': 'Vice Principal',
      'recipients': 'Teachers',
      'sentDate': '01 Aug 2023',
      'priority': 'Normal',
      'status': 'Active',
      'attachments': ['Meeting_Agenda.pdf'],
    },
    {
      'id': 'A1003',
      'title': 'Annual Sports Day Registration',
      'message': 'The annual sports day will be held on 20th September. Students interested in participating should register with their PE teacher by 10th September. Parents are welcome to attend and cheer for their children.',
      'sender': 'Sports Coordinator',
      'recipients': 'Students, Parents',
      'sentDate': '25 Aug 2023',
      'priority': 'Normal',
      'status': 'Active',
      'attachments': ['Sports_Day_Schedule.pdf', 'Registration_Form.docx'],
    },
    {
      'id': 'A1004',
      'title': 'Parent-Teacher Meeting Schedule',
      'message': 'The parent-teacher meetings for this semester will be held from 10th to 12th October. Please book your slots with the respective class teachers. Online booking will open on 1st October.',
      'sender': 'Admin Office',
      'recipients': 'Parents',
      'sentDate': '28 Sep 2023',
      'priority': 'High',
      'status': 'Active',
      'attachments': ['PTM_Schedule.pdf'],
    },
    {
      'id': 'A1005',
      'title': 'End-of-Term Examination Guidelines',
      'message': 'End-of-term examinations will commence on 15th November. Please review the attached guidelines for exam procedures, permitted materials, and attendance requirements. Students should ensure they have cleared all outstanding library dues before the exams.',
      'sender': 'Examination Committee',
      'recipients': 'Students, Teachers',
      'sentDate': '01 Nov 2023',
      'priority': 'High',
      'status': 'Active',
      'attachments': ['Exam_Guidelines.pdf', 'Seating_Arrangement.xlsx'],
    },
    {
      'id': 'A1006',
      'title': 'Holiday Homework Submission',
      'message': 'All students are reminded to submit their holiday homework by 10th January, the first day of the new term. Late submissions will result in marks deduction as per the school policy.',
      'sender': 'Academic Coordinator',
      'recipients': 'Students',
      'sentDate': '15 Dec 2023',
      'priority': 'Normal',
      'status': 'Scheduled',
      'sendDate': '20 Dec 2023',
      'attachments': [],
    },
    {
      'id': 'A1007',
      'title': 'School Fee Payment Reminder',
      'message': 'This is a reminder that the last date for payment of the third quarter school fees is 15th January. Please ensure timely payment to avoid late fees.',
      'sender': 'Accounts Department',
      'recipients': 'Parents',
      'sentDate': '05 Jan 2024',
      'priority': 'Normal',
      'status': 'Active',
      'attachments': ['Fee_Structure.pdf'],
    },
    {
      'id': 'A1008',
      'title': 'New Library Resources Available',
      'message': 'The school library has added several new resources including books, journals, and digital subscriptions. Students and teachers are encouraged to explore these new additions. A detailed list is attached.',
      'sender': 'Librarian',
      'recipients': 'All',
      'sentDate': '18 Jan 2024',
      'priority': 'Low',
      'status': 'Draft',
      'attachments': ['New_Resources_List.xlsx'],
    },
    {
      'id': 'A1009',
      'title': 'Career Counseling Session',
      'message': 'A career counseling session for 11th and 12th grade students will be conducted on 10th February by university representatives and industry professionals. Attendance is mandatory for all senior students.',
      'sender': 'Counseling Department',
      'recipients': 'Students',
      'sentDate': '01 Feb 2024',
      'priority': 'Normal',
      'status': 'Active',
      'attachments': ['Guest_Speakers_Profile.pdf'],
    },
    {
      'id': 'A1010',
      'title': 'Infrastructure Upgrade Notice',
      'message': 'The school will be upgrading its IT infrastructure from 5th to 7th February. During this period, there may be intermittent issues with the school network, internet access, and digital resources. Please plan your lessons accordingly.',
      'sender': 'IT Department',
      'recipients': 'Teachers',
      'sentDate': '29 Jan 2024',
      'priority': 'Normal',
      'status': 'Active',
      'attachments': [],
    },
  ];

  // Recipient groups
  final List<String> _recipientGroups = [
    'All', 'Teachers', 'Students', 'Parents', 'Admin Staff', 
    'Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5',
    'Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 'Grade 10',
    'Grade 11', 'Grade 12'
  ];

  // Priority levels
  final List<String> _priorityLevels = [
    'Low', 'Normal', 'High', 'Urgent'
  ];

  // Filter variables
  String _filterStatus = 'All';
  String _filterRecipient = 'All Groups';
  String _searchQuery = '';
  
  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
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
          _buildPageHeader(),
          const SizedBox(height: 16),
          _buildTabs(),
          const SizedBox(height: 24),
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: [
                _buildAnnouncementsTab(),
                _buildCreateAnnouncementTab(),
                _buildTemplatesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Communication & Announcements',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildTabButton(
            title: 'All Announcements',
            icon: Icons.announcement,
            index: 0,
          ),
          _buildTabButton(
            title: 'Create Announcement',
            icon: Icons.add_circle_outline,
            index: 1,
          ),
          _buildTabButton(
            title: 'Templates',
            icon: Icons.description_outlined,
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required IconData icon,
    required int index,
  }) {
    final isSelected = _selectedTabIndex == index;
    
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4A55A2) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementsTab() {
    // Apply filters to announcements data
    final filteredAnnouncements = _announcements.where((announcement) {
      bool matchesSearch = _searchQuery.isEmpty ||
          announcement['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          announcement['message'].toLowerCase().contains(_searchQuery.toLowerCase());
          
      bool matchesStatus = _filterStatus == 'All' ||
          announcement['status'] == _filterStatus;
          
      bool matchesRecipient = _filterRecipient == 'All Groups' ||
          announcement['recipients'].contains(_filterRecipient);
          
      return matchesSearch && matchesStatus && matchesRecipient;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnnouncementFilters(),
        const SizedBox(height: 16),
        Expanded(
          child: filteredAnnouncements.isEmpty
              ? _buildEmptyState()
              : _buildAnnouncementsList(filteredAnnouncements),
        ),
      ],
    );
  }

  Widget _buildAnnouncementFilters() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search announcements',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildDropdownFilter(
                  label: 'Status',
                  value: _filterStatus,
                  items: ['All', 'Active', 'Draft', 'Scheduled', 'Archived'],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _filterStatus = value;
                      });
                    }
                  },
                ),
                _buildDropdownFilter(
                  label: 'Recipients',
                  value: _filterRecipient,
                  items: ['All Groups', 'Teachers', 'Students', 'Parents', 'Admin Staff'],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _filterRecipient = value;
                      });
                    }
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                      _filterStatus = 'All';
                      _filterRecipient = 'All Groups';
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownFilter({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      constraints: const BoxConstraints(minWidth: 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: Container(),
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontFamily: 'Nunito'),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.announcement_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No announcements found',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Adjust your filters or create a new announcement',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Create Announcement'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A55A2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              setState(() {
                _selectedTabIndex = 1; // Switch to create tab
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsList(List<Map<String, dynamic>> announcements) {
    return ListView.separated(
      itemCount: announcements.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        return _buildAnnouncementCard(announcement);
      },
    );
  }

  Widget _buildAnnouncementCard(Map<String, dynamic> announcement) {
    // Determine card border color based on priority
    Color borderColor;
    switch (announcement['priority']) {
      case 'High':
        borderColor = Colors.orange;
        break;
      case 'Urgent':
        borderColor = Colors.red;
        break;
      case 'Low':
        borderColor = Colors.green;
        break;
      default:
        borderColor = Colors.blue;
    }

    // Determine status chip color
    Color statusColor;
    switch (announcement['status']) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Draft':
        statusColor = Colors.grey;
        break;
      case 'Scheduled':
        statusColor = Colors.blue;
        break;
      case 'Archived':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.blue;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: borderColor.withOpacity(0.1),
          child: Icon(
            Icons.announcement,
            color: borderColor,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                announcement['title'],
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor),
              ),
              child: Text(
                announcement['status'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Icon(Icons.person, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                announcement['sender'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.people, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                announcement['recipients'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                announcement['sentDate'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'duplicate',
              child: Row(
                children: [
                  Icon(Icons.copy),
                  SizedBox(width: 8),
                  Text('Duplicate'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'archive',
              child: Row(
                children: [
                  Icon(Icons.archive),
                  SizedBox(width: 8),
                  Text('Archive'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$value announcement - coming soon')),
            );
          },
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Message:',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                child: Text(
                  announcement['message'],
                  style: const TextStyle(fontFamily: 'Nunito'),
                ),
              ),
              if ((announcement['attachments'] as List).isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Attachments:',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (announcement['attachments'] as List).map<Widget>((attachment) {
                    return Chip(
                      avatar: const Icon(Icons.attach_file, size: 16),
                      label: Text(
                        attachment,
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: Colors.grey[100],
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.visibility),
                    label: const Text('View Stats'),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('View stats feature coming soon')),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text('Resend'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A55A2),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Resend feature coming soon')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateAnnouncementTab() {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create New Announcement',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildAnnouncementForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title field
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Announcement Title',
            hintText: 'Enter a clear and concise title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Message field
        TextFormField(
          controller: _messageController,
          decoration: InputDecoration(
            labelText: 'Message',
            hintText: 'Enter the announcement message',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            alignLabelWithHint: true,
          ),
          maxLines: 5,
        ),
        const SizedBox(height: 16),
        
        // Row for recipient and priority
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recipients',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<String>(
                      value: _selectedRecipientGroup,
                      isExpanded: true,
                      underline: Container(),
                      items: _recipientGroups.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontFamily: 'Nunito'),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedRecipientGroup = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Priority',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<String>(
                      value: _selectedPriority,
                      isExpanded: true,
                      underline: Container(),
                      items: _priorityLevels.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontFamily: 'Nunito'),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedPriority = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Schedule row
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Schedule Date',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            style: const TextStyle(fontFamily: 'Nunito'),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attachments',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.attach_file),
                    label: const Text('Add Attachments'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Attachment feature coming soon')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        
        // Action buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: const Text('Save as Draft'),
              onPressed: () {
                if (_titleController.text.isEmpty || _messageController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all required fields')),
                  );
                  return;
                }
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Announcement saved as draft')),
                );
                
                // Clear form
                _titleController.clear();
                _messageController.clear();
                setState(() {
                  _selectedRecipientGroup = 'All';
                  _selectedPriority = 'Normal';
                  _selectedDate = DateTime.now();
                  _selectedTabIndex = 0; // Switch back to announcements tab
                });
              },
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              child: const Text('Preview'),
              onPressed: () {
                if (_titleController.text.isEmpty || _messageController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all required fields')),
                  );
                  return;
                }
                
                // Show preview dialog
                _showAnnouncementPreview(context);
              },
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Send Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A55A2),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_titleController.text.isEmpty || _messageController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all required fields')),
                  );
                  return;
                }
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Announcement sent successfully')),
                );
                
                // Clear form
                _titleController.clear();
                _messageController.clear();
                setState(() {
                  _selectedRecipientGroup = 'All';
                  _selectedPriority = 'Normal';
                  _selectedDate = DateTime.now();
                  _selectedTabIndex = 0; // Switch back to announcements tab
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showAnnouncementPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.visibility),
                    const SizedBox(width: 8),
                    const Text(
                      'Announcement Preview',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(_selectedPriority).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _getPriorityColor(_selectedPriority)),
                      ),
                      child: Text(
                        _selectedPriority,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: _getPriorityColor(_selectedPriority),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  _titleController.text,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'To: $_selectedRecipientGroup',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: Text(
                    _messageController.text,
                    style: const TextStyle(fontFamily: 'Nunito'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Scheduled for: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('Edit'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      child: const Text('Send'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A55A2),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Announcement sent successfully')),
                        );
                        
                        // Clear form
                        _titleController.clear();
                        _messageController.clear();
                        setState(() {
                          _selectedRecipientGroup = 'All';
                          _selectedPriority = 'Normal';
                          _selectedDate = DateTime.now();
                          _selectedTabIndex = 0; // Switch back to announcements tab
                        });
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

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.orange;
      case 'Urgent':
        return Colors.red;
      case 'Low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Widget _buildTemplatesTab() {
    // Mock template data
    final List<Map<String, dynamic>> templates = [
      {
        'id': 'T1001',
        'name': 'Exam Schedule Announcement',
        'description': 'Template for announcing examination schedules',
        'category': 'Academic',
      },
      {
        'id': 'T1002',
        'name': 'School Event Invitation',
        'description': 'Template for inviting parents and students to school events',
        'category': 'Events',
      },
      {
        'id': 'T1003',
        'name': 'Fee Payment Reminder',
        'description': 'Template for reminding parents about fee payment deadlines',
        'category': 'Finance',
      },
      {
        'id': 'T1004',
        'name': 'Holiday Announcement',
        'description': 'Template for announcing school holidays',
        'category': 'Administrative',
      },
      {
        'id': 'T1005',
        'name': 'Staff Meeting Notice',
        'description': 'Template for notifying staff about meetings',
        'category': 'Staff',
      },
      {
        'id': 'T1006',
        'name': 'Parent-Teacher Meeting',
        'description': 'Template for announcing parent-teacher meetings',
        'category': 'Communication',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Announcement Templates',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('New Template'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A55A2),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New template feature coming soon')),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              return _buildTemplateCard(template);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    // Determine card color based on category
    Color categoryColor;
    switch (template['category']) {
      case 'Academic':
        categoryColor = Colors.blue;
        break;
      case 'Events':
        categoryColor = Colors.purple;
        break;
      case 'Finance':
        categoryColor = Colors.green;
        break;
      case 'Administrative':
        categoryColor = Colors.orange;
        break;
      case 'Staff':
        categoryColor = Colors.teal;
        break;
      case 'Communication':
        categoryColor = Colors.indigo;
        break;
      default:
        categoryColor = Colors.blueGrey;
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: categoryColor,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          // Load template into form
          setState(() {
            _titleController.text = 'New ${template['name']}';
            _messageController.text = 'Template content for ${template['name']} will appear here.';
            _selectedTabIndex = 1; // Switch to create announcement tab
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${template['name']} loaded')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description,
                    color: categoryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      template['name'],
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert, size: 20),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit Template'),
                      ),
                      const PopupMenuItem(
                        value: 'duplicate',
                        child: Text('Duplicate'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    onSelected: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$value template - coming soon')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                template['description'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  template['category'],
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: categoryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.edit_note, size: 16),
                    label: const Text('Use'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A55A2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      // Load template into form
                      setState(() {
                        _titleController.text = 'New ${template['name']}';
                        _messageController.text = 'Template content for ${template['name']} will appear here.';
                        _selectedTabIndex = 1; // Switch to create announcement tab
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${template['name']} loaded')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
