import 'package:flutter/material.dart';

/// AcademicsSubjectsPage - Manages all academic subjects, their curriculum, and grading criteria
class AcademicsSubjectsPage extends StatefulWidget {
  const AcademicsSubjectsPage({super.key});

  @override
  State<AcademicsSubjectsPage> createState() => _AcademicsSubjectsPageState();
}

class _AcademicsSubjectsPageState extends State<AcademicsSubjectsPage> {
  // Controllers
  final TextEditingController _searchController = TextEditingController();
  
  // Filter variables
  String _searchQuery = '';
  String _selectedGrade = 'All Grades';
  String _selectedSubjectType = 'All Types';
  
  // Selected view mode
  String _viewMode = 'grid';
  
  // Mock data for subjects
  final List<Map<String, dynamic>> _subjectsData = [
    {
      'id': 'SUB001',
      'name': 'Mathematics',
      'code': 'MATH101',
      'grade': 'Grade 9',
      'type': 'Core',
      'description': 'Fundamental mathematics concepts including algebra, geometry, and basic trigonometry designed for 9th grade students.',
      'headTeacher': 'Robert Johnson',
      'teachers': ['Robert Johnson', 'Sarah Williams', 'David Brown'],
      'lessons': 5,
      'totalHours': 180,
      'classesAssigned': ['9A', '9B', '9C', '9D'],
      'assessmentMethods': [
        'Written Tests (40%)',
        'Assignments (30%)',
        'Class Participation (10%)',
        'Final Examination (20%)',
      ],
      'curriculum': [
        'Unit 1: Numbers and Operations',
        'Unit 2: Algebraic Expressions',
        'Unit 3: Equations and Inequalities',
        'Unit 4: Coordinate Geometry',
        'Unit 5: Triangles and Quadrilaterals',
        'Unit 6: Circles and Areas',
        'Unit 7: Statistics and Probability',
      ],
      'resources': [
        'Mathematics for Grade 9 (Textbook)',
        'Mathematics Workbook (Exercises)',
        'Online Math Portal Access',
      ],
      'status': 'Active',
      'color': Colors.blue,
    },
    {
      'id': 'SUB002',
      'name': 'Physics',
      'code': 'PHY101',
      'grade': 'Grade 10',
      'type': 'Core',
      'description': 'Introduction to physics concepts including mechanics, energy, electricity, and magnetism tailored for 10th grade students.',
      'headTeacher': 'Sarah Davis',
      'teachers': ['Sarah Davis', 'Michael Wilson'],
      'lessons': 4,
      'totalHours': 144,
      'classesAssigned': ['10A', '10B', '10C'],
      'assessmentMethods': [
        'Written Tests (35%)',
        'Laboratory Work (25%)',
        'Assignments (20%)',
        'Final Examination (20%)',
      ],
      'curriculum': [
        'Unit 1: Measurements and Units',
        'Unit 2: Kinematics',
        'Unit 3: Dynamics',
        'Unit 4: Work, Energy and Power',
        'Unit 5: Heat and Thermodynamics',
        'Unit 6: Electricity',
        'Unit 7: Magnetism',
      ],
      'resources': [
        'Physics for Grade 10 (Textbook)',
        'Laboratory Manual',
        'Physics Simulation Software',
      ],
      'status': 'Active',
      'color': Colors.green,
    },
    {
      'id': 'SUB003',
      'name': 'English Literature',
      'code': 'ENG102',
      'grade': 'Grade 8',
      'type': 'Core',
      'description': 'Study of literary texts, creative writing, and critical analysis for 8th grade students.',
      'headTeacher': 'Michael Wilson',
      'teachers': ['Michael Wilson', 'Emma Thompson'],
      'lessons': 5,
      'totalHours': 180,
      'classesAssigned': ['8A', '8B', '8C', '8D'],
      'assessmentMethods': [
        'Essays (40%)',
        'Comprehension Tests (20%)',
        'Class Discussions (15%)',
        'Final Examination (25%)',
      ],
      'curriculum': [
        'Unit 1: Short Stories and Analysis',
        'Unit 2: Poetry and Literary Devices',
        'Unit 3: Novel Study',
        'Unit 4: Drama and Shakespeare Introduction',
        'Unit 5: Creative Writing',
        'Unit 6: Critical Analysis',
      ],
      'resources': [
        'English Literature Anthology',
        'Novel: "To Kill a Mockingbird"',
        'Shakespeare: Selections from "A Midsummer Night\'s Dream"',
        'Creative Writing Handbook',
      ],
      'status': 'Active',
      'color': Colors.orange,
    },
    {
      'id': 'SUB004',
      'name': 'Chemistry',
      'code': 'CHM101',
      'grade': 'Grade 11',
      'type': 'Core',
      'description': 'Advanced chemistry concepts including organic chemistry, chemical bonding, and chemical reactions for 11th grade students.',
      'headTeacher': 'Jennifer Adams',
      'teachers': ['Jennifer Adams', 'Daniel Miller'],
      'lessons': 4,
      'totalHours': 144,
      'classesAssigned': ['11A', '11B'],
      'assessmentMethods': [
        'Written Tests (30%)',
        'Laboratory Work (30%)',
        'Assignments (20%)',
        'Final Examination (20%)',
      ],
      'curriculum': [
        'Unit 1: Atomic Structure',
        'Unit 2: Periodic Table and Periodicity',
        'Unit 3: Chemical Bonding',
        'Unit 4: States of Matter',
        'Unit 5: Chemical Reactions',
        'Unit 6: Organic Chemistry Basics',
        'Unit 7: Environmental Chemistry',
      ],
      'resources': [
        'Chemistry for Grade 11 (Textbook)',
        'Laboratory Manual',
        'Molecular Model Kit',
        'Online Chemistry Simulation Access',
      ],
      'status': 'Active',
      'color': Colors.purple,
    },
    {
      'id': 'SUB005',
      'name': 'History',
      'code': 'HIS101',
      'grade': 'Grade 7',
      'type': 'Core',
      'description': 'Introduction to world history covering ancient civilizations to medieval times for 7th grade students.',
      'headTeacher': 'Jessica Brown',
      'teachers': ['Jessica Brown'],
      'lessons': 3,
      'totalHours': 108,
      'classesAssigned': ['7A', '7B', '7C', '7D'],
      'assessmentMethods': [
        'Written Tests (30%)',
        'Projects (25%)',
        'Class Participation (15%)',
        'Assignments (10%)',
        'Final Examination (20%)',
      ],
      'curriculum': [
        'Unit 1: Prehistoric Times',
        'Unit 2: Ancient Civilizations (Egypt, Mesopotamia)',
        'Unit 3: Ancient Greece',
        'Unit 4: Ancient Rome',
        'Unit 5: Medieval Europe',
        'Unit 6: Asian Civilizations',
      ],
      'resources': [
        'World History: Ancient to Medieval (Textbook)',
        'Historical Atlas',
        'Primary Source Documents Collection',
      ],
      'status': 'Active',
      'color': Colors.brown,
    },
    {
      'id': 'SUB006',
      'name': 'Computer Science',
      'code': 'CS101',
      'grade': 'Grade 10',
      'type': 'Elective',
      'description': 'Introduction to programming, algorithms, and computing concepts for 10th grade students.',
      'headTeacher': 'Carlos Martinez',
      'teachers': ['Carlos Martinez'],
      'lessons': 3,
      'totalHours': 108,
      'classesAssigned': ['10A', '10B', '10C'],
      'assessmentMethods': [
        'Programming Projects (40%)',
        'Theory Tests (25%)',
        'Assignments (15%)',
        'Final Project (20%)',
      ],
      'curriculum': [
        'Unit 1: Introduction to Computing',
        'Unit 2: Programming Basics (Python)',
        'Unit 3: Data Types and Variables',
        'Unit 4: Control Structures',
        'Unit 5: Functions and Modules',
        'Unit 6: Basic Data Structures',
        'Unit 7: Introduction to Algorithms',
      ],
      'resources': [
        'Introduction to Computer Science (Textbook)',
        'Python Programming Guide',
        'Online IDE Access',
        'Programming Exercises Handbook',
      ],
      'status': 'Active',
      'color': Colors.teal,
    },
    {
      'id': 'SUB007',
      'name': 'Art & Design',
      'code': 'ART101',
      'grade': 'Grade 8',
      'type': 'Elective',
      'description': 'Exploration of various art forms, techniques, and art history for 8th grade students.',
      'headTeacher': 'Emily Chen',
      'teachers': ['Emily Chen'],
      'lessons': 2,
      'totalHours': 72,
      'classesAssigned': ['8A', '8B', '8C', '8D'],
      'assessmentMethods': [
        'Art Portfolio (50%)',
        'Art History Tests (20%)',
        'Classroom Projects (20%)',
        'Participation (10%)',
      ],
      'curriculum': [
        'Unit 1: Elements of Art',
        'Unit 2: Drawing Techniques',
        'Unit 3: Color Theory',
        'Unit 4: Painting Styles',
        'Unit 5: Introduction to 3D Art',
        'Unit 6: Art History Overview',
      ],
      'resources': [
        'Art and Design Handbook',
        'Art Supplies Kit',
        'Digital Art Tools Introduction',
      ],
      'status': 'Active',
      'color': Colors.pink,
    },
    {
      'id': 'SUB008',
      'name': 'Physical Education',
      'code': 'PE101',
      'grade': 'All Grades',
      'type': 'Core',
      'description': 'Physical fitness, sports skills, and health education for all grade levels.',
      'headTeacher': 'Jason Morgan',
      'teachers': ['Jason Morgan', 'Michelle Parker'],
      'lessons': 2,
      'totalHours': 72,
      'classesAssigned': ['All Classes'],
      'assessmentMethods': [
        'Physical Performance (40%)',
        'Skill Tests (30%)',
        'Participation (20%)',
        'Theory Tests (10%)',
      ],
      'curriculum': [
        'Unit 1: Physical Fitness and Health',
        'Unit 2: Team Sports (Basketball, Soccer, Volleyball)',
        'Unit 3: Individual Sports (Athletics, Gymnastics)',
        'Unit 4: Swimming and Water Safety',
        'Unit 5: Outdoor Activities',
      ],
      'resources': [
        'Physical Education Guide',
        'Sports Equipment',
        'First Aid Knowledge Base',
      ],
      'status': 'Active',
      'color': Colors.red,
    },
    {
      'id': 'SUB009',
      'name': 'Biology',
      'code': 'BIO101',
      'grade': 'Grade 9',
      'type': 'Core',
      'description': 'Study of living organisms, their structure, function, growth, and evolution for 9th grade students.',
      'headTeacher': 'Rachel Green',
      'teachers': ['Rachel Green', 'Thomas Edwards'],
      'lessons': 4,
      'totalHours': 144,
      'classesAssigned': ['9A', '9B', '9C', '9D'],
      'assessmentMethods': [
        'Written Tests (30%)',
        'Laboratory Work (30%)',
        'Assignments (20%)',
        'Final Examination (20%)',
      ],
      'curriculum': [
        'Unit 1: Cells and Cell Structure',
        'Unit 2: Human Body Systems',
        'Unit 3: Plant Biology',
        'Unit 4: Genetics and Inheritance',
        'Unit 5: Ecology and Ecosystems',
        'Unit 6: Evolution and Natural Selection',
      ],
      'resources': [
        'Biology for Grade 9 (Textbook)',
        'Laboratory Manual',
        'Microscope and Slides Kit',
        'Biological Models',
      ],
      'status': 'Active',
      'color': Colors.lightGreen,
    },
    {
      'id': 'SUB010',
      'name': 'Music',
      'code': 'MUS101',
      'grade': 'Grade 7',
      'type': 'Elective',
      'description': 'Introduction to music theory, performance, and music history for 7th grade students.',
      'headTeacher': 'Alexander Lee',
      'teachers': ['Alexander Lee'],
      'lessons': 2,
      'totalHours': 72,
      'classesAssigned': ['7A', '7B', '7C', '7D'],
      'assessmentMethods': [
        'Performance (40%)',
        'Music Theory Tests (25%)',
        'Music History Assignments (15%)',
        'Participation (20%)',
      ],
      'curriculum': [
        'Unit 1: Basic Music Theory',
        'Unit 2: Instrumental Introduction',
        'Unit 3: Vocal Training',
        'Unit 4: Music History Overview',
        'Unit 5: Ensemble Performance',
      ],
      'resources': [
        'Music Theory Workbook',
        'Instruments for Practice',
        'Music History Recordings',
      ],
      'status': 'Active',
      'color': Colors.indigo,
    },
  ];
  
  // Lists for filter dropdowns
  final List<String> _grades = [
    'All Grades', 'Grade 7', 'Grade 8', 'Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'
  ];
  
  final List<String> _subjectTypes = [
    'All Types', 'Core', 'Elective', 'Extra-Curricular'
  ];
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Apply filters to subjects data
    final filteredSubjects = _subjectsData.where((subject) {
      bool matchesSearch = _searchQuery.isEmpty ||
          subject['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          subject['code'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          subject['description'].toLowerCase().contains(_searchQuery.toLowerCase());
          
      bool matchesGrade = _selectedGrade == 'All Grades' ||
          subject['grade'] == _selectedGrade;
          
      bool matchesType = _selectedSubjectType == 'All Types' ||
          subject['type'] == _selectedSubjectType;
          
      return matchesSearch && matchesGrade && matchesType;
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
          _buildSubjectsList(filteredSubjects),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Academic Subjects',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add New Subject'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A55A2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add subject feature coming soon')),
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
                      hintText: 'Search by name, code or description',
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
                  label: 'Subject Type',
                  value: _selectedSubjectType,
                  items: _subjectTypes,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedSubjectType = value;
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
                      _selectedSubjectType = 'All Types';
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

  Widget _buildSubjectsList(List<Map<String, dynamic>> subjects) {
    if (subjects.isEmpty) {
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
                'No subjects found',
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
              'Showing ${subjects.length} subjects',
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: _viewMode == 'grid'
                ? _buildGridView(subjects)
                : _buildListView(subjects),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> subjects) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return _buildSubjectCard(subject);
      },
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> subjects) {
    return ListView.separated(
      itemCount: subjects.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return _buildSubjectListItem(subject);
      },
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    final Color subjectColor = subject['color'];

    return InkWell(
      onTap: () => _showSubjectDetails(subject),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: subjectColor,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: subjectColor.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: subjectColor.withOpacity(0.2),
                    child: Icon(
                      _getSubjectIcon(subject['name']),
                      color: subjectColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject['name'],
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subject['code'],
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: subjectColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          subject['grade'],
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: subjectColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          subject['type'],
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subject['description'],
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Head: ${subject['headTeacher']}',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${subject['lessons']} lessons/week (${subject['totalHours']} hrs/year)',
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
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: subjectColor.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('View Details'),
                    style: TextButton.styleFrom(
                      foregroundColor: subjectColor,
                    ),
                    onPressed: () => _showSubjectDetails(subject),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectListItem(Map<String, dynamic> subject) {
    final Color subjectColor = subject['color'];

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      onTap: () => _showSubjectDetails(subject),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: subjectColor.withOpacity(0.2),
        child: Icon(
          _getSubjectIcon(subject['name']),
          color: subjectColor,
        ),
      ),
      title: Row(
        children: [
          Text(
            subject['name'],
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            subject['code'],
            style: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            subject['description'],
            style: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.grey[700],
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: subjectColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  subject['grade'],
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: subjectColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  subject['type'],
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.person, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                subject['headTeacher'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${subject['lessons']} lessons/week',
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
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          _showSubjectOptions(context, subject);
        },
      ),
    );
  }

  void _showSubjectOptions(BuildContext context, Map<String, dynamic> subject) {
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
                title: const Text('View Details', style: TextStyle(fontFamily: 'Nunito')),
                onTap: () {
                  Navigator.pop(context);
                  _showSubjectDetails(subject);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Subject', style: TextStyle(fontFamily: 'Nunito')),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit subject feature coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment),
                title: const Text('Manage Curriculum', style: TextStyle(fontFamily: 'Nunito')),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Manage curriculum feature coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Assign Teachers', style: TextStyle(fontFamily: 'Nunito')),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Assign teachers feature coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete Subject', style: TextStyle(fontFamily: 'Nunito', color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context, subject);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Map<String, dynamic> subject) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Subject', style: TextStyle(fontFamily: 'Nunito')),
          content: Text(
            'Are you sure you want to delete ${subject['name']}? This action cannot be undone.',
            style: const TextStyle(fontFamily: 'Nunito'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${subject['name']} deleted')),
                );
                // In a real app, remove from database
              },
            ),
          ],
        );
      },
    );
  }

  void _showSubjectDetails(Map<String, dynamic> subject) {
    final Color subjectColor = subject['color'];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subject header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: subjectColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: subjectColor.withOpacity(0.2),
                        child: Icon(
                          _getSubjectIcon(subject['name']),
                          color: subjectColor,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subject['name'],
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  subject['code'],
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: subjectColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    subject['grade'],
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: subjectColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    subject['type'],
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Edit subject feature coming soon')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                
                // Subject content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subject['description'],
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Teaching information row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Teaching Staff',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Card(
                                    elevation: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: subjectColor.withOpacity(0.1),
                                                child: const Icon(Icons.person),
                                              ),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    subject['headTeacher'],
                                                    style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Head Teacher',
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
                                          if ((subject['teachers'] as List).length > 1) ...[
                                            const Divider(height: 24),
                                            const Text(
                                              'Other Teachers',
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            ...(subject['teachers'] as List)
                                                .where((t) => t != subject['headTeacher'])
                                                .map((teacher) => Padding(
                                                      padding: const EdgeInsets.only(bottom: 8.0),
                                                      child: Row(
                                                        children: [
                                                          const Icon(Icons.person_outline, size: 16),
                                                          const SizedBox(width: 8),
                                                          Text(
                                                            teacher,
                                                            style: const TextStyle(fontFamily: 'Nunito'),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    'Classes Assigned',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: (subject['classesAssigned'] as List).map<Widget>((className) {
                                      return Chip(
                                        label: Text(
                                          className,
                                          style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 12,
                                          ),
                                        ),
                                        backgroundColor: subjectColor.withOpacity(0.1),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 24),
                            // Right column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Teaching Schedule',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Card(
                                    elevation: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _buildInfoRow(
                                            icon: Icons.event,
                                            label: 'Weekly Lessons',
                                            value: '${subject['lessons']} lessons per week',
                                          ),
                                          const SizedBox(height: 12),
                                          _buildInfoRow(
                                            icon: Icons.access_time,
                                            label: 'Total Hours',
                                            value: '${subject['totalHours']} hours per academic year',
                                          ),
                                          const SizedBox(height: 12),
                                          _buildInfoRow(
                                            icon: Icons.calendar_today,
                                            label: 'Schedule',
                                            value: 'View detailed schedule',
                                            isButton: true,
                                            onTap: () {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('View schedule feature coming soon')),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    'Assessment Methods',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Card(
                                    elevation: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ...(subject['assessmentMethods'] as List).map((method) => Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.check_circle, size: 16, color: subjectColor),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      method,
                                                      style: const TextStyle(fontFamily: 'Nunito'),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Curriculum
                        const Text(
                          'Curriculum',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...(subject['curriculum'] as List).map((unit) => Padding(
                                      padding: const EdgeInsets.only(bottom: 12.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: subjectColor.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              (subject['curriculum'].indexOf(unit) + 1).toString(),
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.bold,
                                                color: subjectColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  unit,
                                                  style: const TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                // In a real app, you would show more details about each unit
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 8),
                                Center(
                                  child: TextButton.icon(
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add/Edit Curriculum'),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Curriculum management feature coming soon')),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Resources
                        const Text(
                          'Learning Resources',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...(subject['resources'] as List).map((resource) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            _getResourceIcon(resource),
                                            size: 20,
                                            color: subjectColor,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              resource,
                                              style: const TextStyle(fontFamily: 'Nunito'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 8),
                                Center(
                                  child: TextButton.icon(
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add/Edit Resources'),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Resources management feature coming soon')),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Footer actions
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.print),
                        label: const Text('Print Syllabus'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Print feature coming soon')),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Subject'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A55A2),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Edit subject feature coming soon')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isButton = false,
    VoidCallback? onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              isButton
                  ? InkWell(
                      onTap: onTap,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          color: const Color(0xFF4A55A2),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getSubjectIcon(String subjectName) {
    switch (subjectName.toLowerCase()) {
      case 'mathematics':
        return Icons.calculate;
      case 'physics':
        return Icons.science;
      case 'english literature':
        return Icons.menu_book;
      case 'chemistry':
        return Icons.biotech;
      case 'history':
        return Icons.history_edu;
      case 'computer science':
        return Icons.computer;
      case 'art & design':
        return Icons.palette;
      case 'physical education':
        return Icons.sports_basketball;
      case 'biology':
        return Icons.local_florist;
      case 'music':
        return Icons.music_note;
      default:
        return Icons.school;
    }
  }

  IconData _getResourceIcon(String resource) {
    if (resource.toLowerCase().contains('book') || resource.toLowerCase().contains('textbook')) {
      return Icons.book;
    } else if (resource.toLowerCase().contains('manual')) {
      return Icons.menu_book;
    } else if (resource.toLowerCase().contains('online') || resource.toLowerCase().contains('software') || 
               resource.toLowerCase().contains('digital') || resource.toLowerCase().contains('simulation')) {
      return Icons.computer;
    } else if (resource.toLowerCase().contains('kit') || resource.toLowerCase().contains('supplies')) {
      return Icons.science;
    } else {
      return Icons.description;
    }
  }
}
