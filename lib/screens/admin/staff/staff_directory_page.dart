import 'package:flutter/material.dart';

/// StaffDirectoryPage - Comprehensive list of all school staff with search and filtering capabilities
class StaffDirectoryPage extends StatefulWidget {
  const StaffDirectoryPage({super.key});

  @override
  State<StaffDirectoryPage> createState() => _StaffDirectoryPageState();
}

class _StaffDirectoryPageState extends State<StaffDirectoryPage> {
  // Mock data for staff directory
  final List<Map<String, dynamic>> _staffData = [
    {
      'id': 'T1001',
      'name': 'Robert Johnson',
      'role': 'Mathematics Teacher',
      'department': 'Mathematics',
      'joinDate': '15 Aug 2020',
      'gender': 'Male',
      'photo': 'assets/teacher1.jpg',
      'contactNumber': '+1 234-567-8901',
      'email': 'robert.johnson@school.edu',
      'address': '123 Faculty Ave, Anytown, USA',
      'education': 'M.Sc. Mathematics, University of Education',
      'experience': '8 years',
      'status': 'Active',
      'classes': ['Grade 9', 'Grade 10', 'Grade 11'],
      'subjects': ['Mathematics', 'Advanced Mathematics'],
    },
    {
      'id': 'T1002',
      'name': 'Sarah Davis',
      'role': 'Science Teacher',
      'department': 'Science',
      'joinDate': '10 Sep 2019',
      'gender': 'Female',
      'photo': 'assets/teacher2.jpg',
      'contactNumber': '+1 234-567-8902',
      'email': 'sarah.davis@school.edu',
      'address': '456 Teacher Ln, Anytown, USA',
      'education': 'Ph.D. Physics, Science University',
      'experience': '12 years',
      'status': 'Active',
      'classes': ['Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'],
      'subjects': ['Physics', 'General Science'],
    },
    {
      'id': 'T1003',
      'name': 'Michael Wilson',
      'role': 'English Teacher',
      'department': 'Languages',
      'joinDate': '05 Jul 2021',
      'gender': 'Male',
      'photo': 'assets/teacher3.jpg',
      'contactNumber': '+1 234-567-8903',
      'email': 'michael.wilson@school.edu',
      'address': '789 Education Rd, Anytown, USA',
      'education': 'M.A. English Literature, Liberal Arts College',
      'experience': '6 years',
      'status': 'Active',
      'classes': ['Grade 6', 'Grade 7', 'Grade 8'],
      'subjects': ['English Literature', 'Grammar'],
    },
    {
      'id': 'T1004',
      'name': 'Jessica Brown',
      'role': 'History Teacher',
      'department': 'Humanities',
      'joinDate': '20 Aug 2022',
      'gender': 'Female',
      'photo': 'assets/teacher4.jpg',
      'contactNumber': '+1 234-567-8904',
      'email': 'jessica.brown@school.edu',
      'address': '101 Historian Blvd, Anytown, USA',
      'education': 'M.A. History, National University',
      'experience': '4 years',
      'status': 'Active',
      'classes': ['Grade 8', 'Grade 9', 'Grade 10'],
      'subjects': ['World History', 'Local History'],
    },
    {
      'id': 'T1005',
      'name': 'Carlos Martinez',
      'role': 'Computer Science Teacher',
      'department': 'Technology',
      'joinDate': '12 Jan 2023',
      'gender': 'Male',
      'photo': 'assets/teacher5.jpg',
      'contactNumber': '+1 234-567-8905',
      'email': 'carlos.martinez@school.edu',
      'address': '202 Tech Park, Anytown, USA',
      'education': 'M.S. Computer Science, Tech University',
      'experience': '10 years',
      'status': 'Active',
      'classes': ['Grade 7', 'Grade 8', 'Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'],
      'subjects': ['Programming', 'Computer Science', 'Robotics'],
    },
    {
      'id': 'A1001',
      'name': 'Patricia Garcia',
      'role': 'Principal',
      'department': 'Administration',
      'joinDate': '01 Jun 2018',
      'gender': 'Female',
      'photo': 'assets/admin1.jpg',
      'contactNumber': '+1 234-567-8906',
      'email': 'principal@school.edu',
      'address': '303 Admin Way, Anytown, USA',
      'education': 'Ph.D. Education Administration, Leadership University',
      'experience': '15 years',
      'status': 'Active',
      'classes': [],
      'subjects': [],
    },
    {
      'id': 'A1002',
      'name': 'David Thompson',
      'role': 'Vice Principal',
      'department': 'Administration',
      'joinDate': '15 Jul 2019',
      'gender': 'Male',
      'photo': 'assets/admin2.jpg',
      'contactNumber': '+1 234-567-8907',
      'email': 'viceprincipal@school.edu',
      'address': '404 Admin Circle, Anytown, USA',
      'education': 'M.Ed. Education Management, Admin College',
      'experience': '12 years',
      'status': 'Active',
      'classes': [],
      'subjects': [],
    },
    {
      'id': 'S1001',
      'name': 'Jennifer Williams',
      'role': 'School Counselor',
      'department': 'Student Services',
      'joinDate': '10 Aug 2020',
      'gender': 'Female',
      'photo': 'assets/staff1.jpg',
      'contactNumber': '+1 234-567-8908',
      'email': 'jennifer.williams@school.edu',
      'address': '505 Counselor St, Anytown, USA',
      'education': 'M.S. Counseling Psychology, State University',
      'experience': '9 years',
      'status': 'Active',
      'classes': [],
      'subjects': [],
    },
    {
      'id': 'S1002',
      'name': 'Thomas Miller',
      'role': 'Librarian',
      'department': 'Library',
      'joinDate': '05 Sep 2021',
      'gender': 'Male',
      'photo': 'assets/staff2.jpg',
      'contactNumber': '+1 234-567-8909',
      'email': 'thomas.miller@school.edu',
      'address': '606 Book Lane, Anytown, USA',
      'education': 'M.L.S. Library Science, City University',
      'experience': '7 years',
      'status': 'Active',
      'classes': [],
      'subjects': [],
    },
    {
      'id': 'S1003',
      'name': 'Lisa Rodriguez',
      'role': 'School Nurse',
      'department': 'Health Services',
      'joinDate': '20 Jan 2022',
      'gender': 'Female',
      'photo': 'assets/staff3.jpg',
      'contactNumber': '+1 234-567-8910',
      'email': 'lisa.rodriguez@school.edu',
      'address': '707 Health Blvd, Anytown, USA',
      'education': 'B.S.N. Nursing, Medical University',
      'experience': '11 years',
      'status': 'Active',
      'classes': [],
      'subjects': [],
    },
  ];

  // Filter variables
  String _searchQuery = '';
  String _selectedDepartment = 'All Departments';
  String _selectedRole = 'All Roles';
  String _selectedStatus = 'All Status';
  String _selectedGender = 'All';
  
  // Create lists for filter dropdowns
  final List<String> _departments = [
    'All Departments', 'Mathematics', 'Science', 'Languages', 'Humanities', 
    'Technology', 'Administration', 'Student Services', 'Library', 'Health Services'
  ];
  final List<String> _roles = [
    'All Roles', 'Mathematics Teacher', 'Science Teacher', 'English Teacher', 
    'History Teacher', 'Computer Science Teacher', 'Principal', 'Vice Principal',
    'School Counselor', 'Librarian', 'School Nurse'
  ];
  final List<String> _statuses = ['All Status', 'Active', 'On Leave', 'Inactive'];
  final List<String> _genders = ['All', 'Male', 'Female'];
  
  // Search controller
  final TextEditingController _searchController = TextEditingController();
  
  // Selected view mode
  String _viewMode = 'grid';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Apply filters to staff data
    final filteredStaff = _staffData.where((staff) {
      bool matchesSearch = _searchQuery.isEmpty ||
          staff['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          staff['id'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          staff['role'].toLowerCase().contains(_searchQuery.toLowerCase());
          
      bool matchesDepartment = _selectedDepartment == 'All Departments' ||
          staff['department'] == _selectedDepartment;
          
      bool matchesRole = _selectedRole == 'All Roles' ||
          staff['role'] == _selectedRole;
          
      bool matchesStatus = _selectedStatus == 'All Status' ||
          staff['status'] == _selectedStatus;
          
      bool matchesGender = _selectedGender == 'All' ||
          staff['gender'] == _selectedGender;
          
      return matchesSearch && matchesDepartment && matchesRole && matchesStatus && matchesGender;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(),
          const SizedBox(height: 24),
          _buildFilters(),
          const SizedBox(height: 16),
          _buildStaffList(filteredStaff),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Staff Directory',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.person_add),
          label: const Text('Add New Staff'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A55A2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add staff feature coming soon')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilters() {
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
                      hintText: 'Search by name, ID or role',
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
                const SizedBox(width: 16),
                _buildViewToggle(),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildDropdownFilter(
                  label: 'Department',
                  value: _selectedDepartment,
                  items: _departments,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedDepartment = value;
                      });
                    }
                  },
                ),
                _buildDropdownFilter(
                  label: 'Role',
                  value: _selectedRole,
                  items: _roles,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedRole = value;
                      });
                    }
                  },
                ),
                _buildDropdownFilter(
                  label: 'Status',
                  value: _selectedStatus,
                  items: _statuses,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }
                  },
                ),
                _buildDropdownFilter(
                  label: 'Gender',
                  value: _selectedGender,
                  items: _genders,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedGender = value;
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
                      _selectedDepartment = 'All Departments';
                      _selectedRole = 'All Roles';
                      _selectedStatus = 'All Status';
                      _selectedGender = 'All';
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

  Widget _buildViewToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildViewToggleButton(
            icon: Icons.grid_view,
            isSelected: _viewMode == 'grid',
            onTap: () {
              setState(() {
                _viewMode = 'grid';
              });
            },
          ),
          _buildViewToggleButton(
            icon: Icons.view_list,
            isSelected: _viewMode == 'list',
            onTap: () {
              setState(() {
                _viewMode = 'list';
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggleButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A55A2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildStaffList(List<Map<String, dynamic>> staff) {
    if (staff.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No staff members found',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Try adjusting your search or filters',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Showing ${staff.length} staff members',
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: _viewMode == 'grid'
                ? _buildGridView(staff)
                : _buildListView(staff),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> staff) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: staff.length,
      itemBuilder: (context, index) {
        final staffMember = staff[index];
        return _buildStaffCard(staffMember);
      },
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> staff) {
    return ListView.separated(
      itemCount: staff.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final staffMember = staff[index];
        return _buildStaffListItem(staffMember);
      },
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> staffMember) {
    // Determine card border color based on department
    Color borderColor;
    switch (staffMember['department']) {
      case 'Administration':
        borderColor = Colors.purple;
        break;
      case 'Mathematics':
        borderColor = Colors.blue;
        break;
      case 'Science':
        borderColor = Colors.green;
        break;
      case 'Languages':
        borderColor = Colors.orange;
        break;
      case 'Humanities':
        borderColor = Colors.brown;
        break;
      case 'Technology':
        borderColor = Colors.teal;
        break;
      case 'Student Services':
        borderColor = Colors.indigo;
        break;
      case 'Library':
        borderColor = Colors.amber;
        break;
      case 'Health Services':
        borderColor = Colors.red;
        break;
      default:
        borderColor = const Color(0xFF4A55A2);
    }

    return InkWell(
      onTap: () => _showStaffDetails(staffMember),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: borderColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: borderColor.withOpacity(0.2),
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: borderColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    staffMember['name'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    staffMember['id'],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    staffMember['role'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: borderColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      staffMember['department'],
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: borderColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffListItem(Map<String, dynamic> staffMember) {
    // Determine avatar background color based on department
    Color avatarColor;
    switch (staffMember['department']) {
      case 'Administration':
        avatarColor = Colors.purple;
        break;
      case 'Mathematics':
        avatarColor = Colors.blue;
        break;
      case 'Science':
        avatarColor = Colors.green;
        break;
      case 'Languages':
        avatarColor = Colors.orange;
        break;
      case 'Humanities':
        avatarColor = Colors.brown;
        break;
      case 'Technology':
        avatarColor = Colors.teal;
        break;
      case 'Student Services':
        avatarColor = Colors.indigo;
        break;
      case 'Library':
        avatarColor = Colors.amber;
        break;
      case 'Health Services':
        avatarColor = Colors.red;
        break;
      default:
        avatarColor = const Color(0xFF4A55A2);
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      onTap: () => _showStaffDetails(staffMember),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: avatarColor.withOpacity(0.2),
        child: Icon(
          Icons.person,
          size: 24,
          color: avatarColor,
        ),
      ),
      title: Text(
        staffMember['name'],
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            '${staffMember['id']} • ${staffMember['role']}',
            style: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: avatarColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  staffMember['department'],
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: avatarColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Experience: ${staffMember['experience']}',
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
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Since ${staffMember['joinDate']}',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showStaffOptions(context, staffMember);
            },
          ),
        ],
      ),
    );
  }

  void _showStaffOptions(BuildContext context, Map<String, dynamic> staffMember) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text('View Profile', style: TextStyle(fontFamily: 'Nunito')),
                onTap: () {
                  Navigator.pop(context);
                  _showStaffDetails(staffMember);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Profile', style: TextStyle(fontFamily: 'Nunito')),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit profile feature coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('View Schedule', style: TextStyle(fontFamily: 'Nunito')),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('View schedule feature coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.mail),
                title: const Text('Send Email', style: TextStyle(fontFamily: 'Nunito')),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Send email feature coming soon')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStaffDetails(Map<String, dynamic> staffMember) {
    // Determine color based on department
    Color departmentColor;
    switch (staffMember['department']) {
      case 'Administration':
        departmentColor = Colors.purple;
        break;
      case 'Mathematics':
        departmentColor = Colors.blue;
        break;
      case 'Science':
        departmentColor = Colors.green;
        break;
      case 'Languages':
        departmentColor = Colors.orange;
        break;
      case 'Humanities':
        departmentColor = Colors.brown;
        break;
      case 'Technology':
        departmentColor = Colors.teal;
        break;
      case 'Student Services':
        departmentColor = Colors.indigo;
        break;
      case 'Library':
        departmentColor = Colors.amber;
        break;
      case 'Health Services':
        departmentColor = Colors.red;
        break;
      default:
        departmentColor = const Color(0xFF4A55A2);
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: departmentColor.withOpacity(0.2),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: departmentColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  staffMember['name'],
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: departmentColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    staffMember['department'],
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: departmentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              staffMember['id'],
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              staffMember['role'],
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              title: 'Personal Information',
                              items: [
                                {'label': 'Gender', 'value': staffMember['gender']},
                                {'label': 'Join Date', 'value': staffMember['joinDate']},
                                {'label': 'Experience', 'value': staffMember['experience']},
                                {'label': 'Education', 'value': staffMember['education']},
                              ],
                            ),
                            const SizedBox(height: 16),
                            if ((staffMember['classes'] as List).isNotEmpty) ...[
                              _buildInfoSection(
                                title: 'Classes',
                                items: [
                                  {'label': 'Classes Taught', 'value': (staffMember['classes'] as List).join(', ')},
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              title: 'Contact Information',
                              items: [
                                {'label': 'Email', 'value': staffMember['email']},
                                {'label': 'Phone', 'value': staffMember['contactNumber']},
                                {'label': 'Address', 'value': staffMember['address']},
                              ],
                            ),
                            const SizedBox(height: 16),
                            if ((staffMember['subjects'] as List).isNotEmpty) ...[
                              _buildInfoSection(
                                title: 'Subjects',
                                items: [
                                  {'label': 'Subjects Taught', 'value': (staffMember['subjects'] as List).join(', ')},
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Edit profile feature coming soon')),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.schedule),
                        label: const Text('View Schedule'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A55A2),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('View schedule feature coming soon')),
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
      },
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Map<String, String>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    '${item['label']}:',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item['value'] ?? '',
                    style: const TextStyle(fontFamily: 'Nunito'),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
