import 'package:flutter/material.dart';

/// StudentsDirectoryPage - Comprehensive list of all students with search and filtering capabilities
class StudentsDirectoryPage extends StatefulWidget {
  const StudentsDirectoryPage({super.key});

  @override
  State<StudentsDirectoryPage> createState() => _StudentsDirectoryPageState();
}

class _StudentsDirectoryPageState extends State<StudentsDirectoryPage> {
  // Mock data for student directory
  final List<Map<String, dynamic>> _studentsData = [
    {
      'id': 'S1001',
      'name': 'Emma Johnson',
      'grade': 'Grade 9',
      'section': 'A',
      'admissionDate': '01 Aug 2023',
      'gender': 'Female',
      'photo': 'assets/student1.jpg',
      'contactNumber': '+1 234-567-8901',
      'parentName': 'Robert & Sarah Johnson',
      'address': '123 Main St, Anytown, USA',
      'status': 'Active',
    },
    {
      'id': 'S1002',
      'name': 'James Wilson',
      'grade': 'Grade 8',
      'section': 'B',
      'admissionDate': '05 Aug 2023',
      'gender': 'Male',
      'photo': 'assets/student2.jpg',
      'contactNumber': '+1 234-567-8902',
      'parentName': 'Michael & Emily Wilson',
      'address': '456 Oak Ave, Anytown, USA',
      'status': 'Active',
    },
    {
      'id': 'S1003',
      'name': 'Sophia Martinez',
      'grade': 'Grade 11',
      'section': 'A',
      'admissionDate': '10 Aug 2023',
      'gender': 'Female',
      'photo': 'assets/student3.jpg',
      'contactNumber': '+1 234-567-8903',
      'parentName': 'Carlos & Elena Martinez',
      'address': '789 Pine Rd, Anytown, USA',
      'status': 'Active',
    },
    {
      'id': 'S1004',
      'name': 'David Thompson',
      'grade': 'Grade 10',
      'section': 'C',
      'admissionDate': '15 Aug 2023',
      'gender': 'Male',
      'photo': 'assets/student4.jpg',
      'contactNumber': '+1 234-567-8904',
      'parentName': 'Daniel & Jessica Thompson',
      'address': '101 Cedar Ln, Anytown, USA',
      'status': 'Active',
    },
    {
      'id': 'S1005',
      'name': 'Olivia Brown',
      'grade': 'Grade 12',
      'section': 'A',
      'admissionDate': '20 Aug 2023',
      'gender': 'Female',
      'photo': 'assets/student5.jpg',
      'contactNumber': '+1 234-567-8905',
      'parentName': 'William & Jennifer Brown',
      'address': '202 Maple Dr, Anytown, USA',
      'status': 'Active',
    },
    {
      'id': 'S1006',
      'name': 'Ethan Davis',
      'grade': 'Grade 7',
      'section': 'B',
      'admissionDate': '25 Aug 2023',
      'gender': 'Male',
      'photo': 'assets/student6.jpg',
      'contactNumber': '+1 234-567-8906',
      'parentName': 'Thomas & Lisa Davis',
      'address': '303 Birch Blvd, Anytown, USA',
      'status': 'Inactive',
    },
    {
      'id': 'S1007',
      'name': 'Ava Miller',
      'grade': 'Grade 6',
      'section': 'A',
      'admissionDate': '01 Sep 2023',
      'gender': 'Female',
      'photo': 'assets/student7.jpg',
      'contactNumber': '+1 234-567-8907',
      'parentName': 'Joseph & Laura Miller',
      'address': '404 Spruce Ct, Anytown, USA',
      'status': 'Active',
    },
    {
      'id': 'S1008',
      'name': 'Noah Wilson',
      'grade': 'Grade 9',
      'section': 'B',
      'admissionDate': '05 Sep 2023',
      'gender': 'Male',
      'photo': 'assets/student8.jpg',
      'contactNumber': '+1 234-567-8908',
      'parentName': 'Christopher & Rachel Wilson',
      'address': '505 Elm Way, Anytown, USA',
      'status': 'Active',
    },
    {
      'id': 'S1009',
      'name': 'Isabella Garcia',
      'grade': 'Grade 10',
      'section': 'A',
      'admissionDate': '10 Sep 2023',
      'gender': 'Female',
      'photo': 'assets/student9.jpg',
      'contactNumber': '+1 234-567-8909',
      'parentName': 'Ricardo & Maria Garcia',
      'address': '606 Walnut Pl, Anytown, USA',
      'status': 'Transfer',
    },
    {
      'id': 'S1010',
      'name': 'Mason Rodriguez',
      'grade': 'Grade 8',
      'section': 'C',
      'admissionDate': '15 Sep 2023',
      'gender': 'Male',
      'photo': 'assets/student10.jpg',
      'contactNumber': '+1 234-567-8910',
      'parentName': 'Juan & Sofia Rodriguez',
      'address': '707 Aspen Ave, Anytown, USA',
      'status': 'Active',
    },
  ];

  // Filter variables
  String _searchQuery = '';
  String _selectedGrade = 'All Grades';
  String _selectedSection = 'All Sections';
  String _selectedStatus = 'All Status';
  String _selectedGender = 'All';
  
  // Create lists for filter dropdowns
  final List<String> _grades = ['All Grades', 'Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'];
  final List<String> _sections = ['All Sections', 'A', 'B', 'C'];
  final List<String> _statuses = ['All Status', 'Active', 'Inactive', 'Transfer'];
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
    // Apply filters to student data
    final filteredStudents = _studentsData.where((student) {
      bool matchesSearch = _searchQuery.isEmpty ||
          student['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          student['id'].toLowerCase().contains(_searchQuery.toLowerCase());
          
      bool matchesGrade = _selectedGrade == 'All Grades' ||
          student['grade'] == _selectedGrade;
          
      bool matchesSection = _selectedSection == 'All Sections' ||
          student['section'] == _selectedSection;
          
      bool matchesStatus = _selectedStatus == 'All Status' ||
          student['status'] == _selectedStatus;
          
      bool matchesGender = _selectedGender == 'All' ||
          student['gender'] == _selectedGender;
          
      return matchesSearch && matchesGrade && matchesSection && matchesStatus && matchesGender;
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
          _buildStudentList(filteredStudents),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Students Directory',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.person_add),
          label: const Text('Add New Student'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A55A2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add student feature coming soon')),
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
                      hintText: 'Search by name or ID',
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
                  label: 'Grade',
                  value: _selectedGrade,
                  items: _grades,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedGrade = value;
                      });
                    }
                  },
                ),
                _buildDropdownFilter(
                  label: 'Section',
                  value: _selectedSection,
                  items: _sections,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedSection = value;
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
                      _selectedGrade = 'All Grades';
                      _selectedSection = 'All Sections';
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

  Widget _buildStudentList(List<Map<String, dynamic>> students) {
    if (students.isEmpty) {
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
                'No students found',
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
              'Showing ${students.length} students',
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: _viewMode == 'grid'
                ? _buildGridView(students)
                : _buildListView(students),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> students) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return _buildStudentCard(student);
      },
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> students) {
    return ListView.separated(
      itemCount: students.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final student = students[index];
        return _buildStudentListItem(student);
      },
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    Color statusColor;
    switch (student['status']) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Inactive':
        statusColor = Colors.red;
        break;
      case 'Transfer':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return InkWell(
      onTap: () => _showStudentDetails(student),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F7FF),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.white,
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
                    student['name'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    student['id'],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${student['grade']} - ${student['section']}',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      student['status'],
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
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

  Widget _buildStudentListItem(Map<String, dynamic> student) {
    Color statusColor;
    switch (student['status']) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Inactive':
        statusColor = Colors.red;
        break;
      case 'Transfer':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      onTap: () => _showStudentDetails(student),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[300],
        child: const Icon(
          Icons.person,
          size: 24,
          color: Colors.white,
        ),
      ),
      title: Text(
        student['name'],
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
            '${student['id']} • ${student['grade']} ${student['section']}',
            style: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Parent: ${student['parentName']}',
            style: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              student['status'],
              style: TextStyle(
                fontFamily: 'Nunito',
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Since ${student['admissionDate']}',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _showStudentDetails(Map<String, dynamic> student) {
    Color statusColor;
    switch (student['status']) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Inactive':
        statusColor = Colors.red;
        break;
      case 'Transfer':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
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
                        backgroundColor: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
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
                                  student['name'],
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    student['status'],
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              student['id'],
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${student['grade']} ${student['section']} | Admission: ${student['admissionDate']}',
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
                                {'label': 'Gender', 'value': student['gender']},
                                {'label': 'Contact Number', 'value': student['contactNumber']},
                                {'label': 'Address', 'value': student['address']},
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              title: 'Parent/Guardian',
                              items: [
                                {'label': 'Name', 'value': student['parentName']},
                                {'label': 'Contact', 'value': student['contactNumber']},
                                {'label': 'Relationship', 'value': 'Parents'},
                              ],
                            ),
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
                        icon: const Icon(Icons.assignment),
                        label: const Text('View Academic Record'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A55A2),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Academic record feature coming soon')),
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
