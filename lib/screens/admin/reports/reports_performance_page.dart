import 'package:flutter/material.dart';

/// ReportsPerformancePage - Allows admin to view and analyze school-wide performance metrics and trends
class ReportsPerformancePage extends StatefulWidget {
  const ReportsPerformancePage({super.key});

  @override
  State<ReportsPerformancePage> createState() => _ReportsPerformancePageState();
}

class _ReportsPerformancePageState extends State<ReportsPerformancePage> {
  // Filter variables
  String _selectedAcademicYear = '2023-2024';
  String _selectedGrade = 'All Grades';
  String _selectedTerm = 'All Terms';
  String _selectedSubject = 'All Subjects';
  String _selectedViewMode = 'summary'; // 'summary', 'detailed'

  // Mock data for academic years, grades, terms, and subjects
  final List<String> _academicYears = ['2023-2024', '2022-2023', '2021-2022'];
  final List<String> _grades = [
    'All Grades', 'Grade 7', 'Grade 8', 'Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'
  ];
  final List<String> _terms = ['All Terms', 'Term 1', 'Term 2', 'Term 3'];
  final List<String> _subjects = [
    'All Subjects', 'Mathematics', 'Physics', 'Chemistry', 'Biology', 'English Literature',
    'History', 'Computer Science', 'Physical Education', 'Art & Design', 'Music'
  ];

  // Mock performance data by grade
  final List<Map<String, dynamic>> _gradePerformanceData = [
    {
      'grade': 'Grade 7',
      'averageScore': 78.5,
      'passingRate': 92.3,
      'attendanceRate': 94.8,
      'topSubject': 'Music',
      'topSubjectAvg': 86.2,
      'challengingSubject': 'Mathematics',
      'challengingSubjectAvg': 72.1,
      'studentCount': 112,
      'highAchievers': 28,
      'needsSupport': 12,
    },
    {
      'grade': 'Grade 8',
      'averageScore': 76.8,
      'passingRate': 90.5,
      'attendanceRate': 93.2,
      'topSubject': 'Art & Design',
      'topSubjectAvg': 84.6,
      'challengingSubject': 'Physics',
      'challengingSubjectAvg': 70.4,
      'studentCount': 124,
      'highAchievers': 25,
      'needsSupport': 15,
    },
    {
      'grade': 'Grade 9',
      'averageScore': 75.2,
      'passingRate': 88.7,
      'attendanceRate': 91.5,
      'topSubject': 'Physical Education',
      'topSubjectAvg': 85.8,
      'challengingSubject': 'Chemistry',
      'challengingSubjectAvg': 68.9,
      'studentCount': 118,
      'highAchievers': 22,
      'needsSupport': 18,
    },
    {
      'grade': 'Grade 10',
      'averageScore': 74.6,
      'passingRate': 87.2,
      'attendanceRate': 90.3,
      'topSubject': 'Computer Science',
      'topSubjectAvg': 83.4,
      'challengingSubject': 'English Literature',
      'challengingSubjectAvg': 68.5,
      'studentCount': 106,
      'highAchievers': 20,
      'needsSupport': 17,
    },
    {
      'grade': 'Grade 11',
      'averageScore': 77.8,
      'passingRate': 91.8,
      'attendanceRate': 92.7,
      'topSubject': 'Biology',
      'topSubjectAvg': 85.2,
      'challengingSubject': 'History',
      'challengingSubjectAvg': 71.3,
      'studentCount': 98,
      'highAchievers': 24,
      'needsSupport': 10,
    },
    {
      'grade': 'Grade 12',
      'averageScore': 80.4,
      'passingRate': 94.6,
      'attendanceRate': 95.2,
      'topSubject': 'Mathematics',
      'topSubjectAvg': 87.5,
      'challengingSubject': 'Physics',
      'challengingSubjectAvg': 74.8,
      'studentCount': 92,
      'highAchievers': 30,
      'needsSupport': 8,
    },
  ];

  // Mock performance data by subject
  final List<Map<String, dynamic>> _subjectPerformanceData = [
    {
      'subject': 'Mathematics',
      'averageScore': 75.8,
      'passingRate': 88.2,
      'highestGrade': 'Grade 12',
      'highestGradeAvg': 87.5,
      'lowestGrade': 'Grade 7',
      'lowestGradeAvg': 72.1,
      'malePerfAvg': 77.2,
      'femalePerfAvg': 74.5,
    },
    {
      'subject': 'Physics',
      'averageScore': 73.2,
      'passingRate': 85.1,
      'highestGrade': 'Grade 11',
      'highestGradeAvg': 82.4,
      'lowestGrade': 'Grade 8',
      'lowestGradeAvg': 70.4,
      'malePerfAvg': 75.8,
      'femalePerfAvg': 70.6,
    },
    {
      'subject': 'Chemistry',
      'averageScore': 74.6,
      'passingRate': 86.4,
      'highestGrade': 'Grade 12',
      'highestGradeAvg': 83.7,
      'lowestGrade': 'Grade 9',
      'lowestGradeAvg': 68.9,
      'malePerfAvg': 73.9,
      'femalePerfAvg': 75.3,
    },
    {
      'subject': 'Biology',
      'averageScore': 78.2,
      'passingRate': 91.5,
      'highestGrade': 'Grade 11',
      'highestGradeAvg': 85.2,
      'lowestGrade': 'Grade 9',
      'lowestGradeAvg': 73.8,
      'malePerfAvg': 76.4,
      'femalePerfAvg': 79.9,
    },
    {
      'subject': 'English Literature',
      'averageScore': 76.4,
      'passingRate': 90.2,
      'highestGrade': 'Grade 12',
      'highestGradeAvg': 84.1,
      'lowestGrade': 'Grade 10',
      'lowestGradeAvg': 68.5,
      'malePerfAvg': 74.2,
      'femalePerfAvg': 78.6,
    },
    {
      'subject': 'History',
      'averageScore': 74.8,
      'passingRate': 87.6,
      'highestGrade': 'Grade 12',
      'highestGradeAvg': 82.9,
      'lowestGrade': 'Grade 11',
      'lowestGradeAvg': 71.3,
      'malePerfAvg': 73.5,
      'femalePerfAvg': 76.1,
    },
    {
      'subject': 'Computer Science',
      'averageScore': 79.5,
      'passingRate': 92.8,
      'highestGrade': 'Grade 10',
      'highestGradeAvg': 83.4,
      'lowestGrade': 'Grade 7',
      'lowestGradeAvg': 75.2,
      'malePerfAvg': 81.3,
      'femalePerfAvg': 77.7,
    },
    {
      'subject': 'Physical Education',
      'averageScore': 82.4,
      'passingRate': 95.6,
      'highestGrade': 'Grade 9',
      'highestGradeAvg': 85.8,
      'lowestGrade': 'Grade 12',
      'lowestGradeAvg': 79.1,
      'malePerfAvg': 84.2,
      'femalePerfAvg': 80.6,
    },
    {
      'subject': 'Art & Design',
      'averageScore': 83.7,
      'passingRate': 96.4,
      'highestGrade': 'Grade 8',
      'highestGradeAvg': 84.6,
      'lowestGrade': 'Grade 10',
      'lowestGradeAvg': 80.2,
      'malePerfAvg': 81.5,
      'femalePerfAvg': 85.9,
    },
    {
      'subject': 'Music',
      'averageScore': 84.2,
      'passingRate': 97.1,
      'highestGrade': 'Grade 7',
      'highestGradeAvg': 86.2,
      'lowestGrade': 'Grade 11',
      'lowestGradeAvg': 81.8,
      'malePerfAvg': 82.7,
      'femalePerfAvg': 85.6,
    },
  ];

  // Mock data for term-wise performance
  final List<Map<String, dynamic>> _termWisePerformanceData = [
    {
      'term': 'Term 1',
      'averageScore': 76.2,
      'passingRate': 89.5,
      'attendanceRate': 94.7,
      'improvementFromPrevious': null,
    },
    {
      'term': 'Term 2',
      'averageScore': 77.8,
      'passingRate': 91.2,
      'attendanceRate': 93.1,
      'improvementFromPrevious': '+1.6',
    },
    {
      'term': 'Term 3',
      'averageScore': 79.4,
      'passingRate': 92.8,
      'attendanceRate': 91.5,
      'improvementFromPrevious': '+1.6',
    },
  ];

  // Mock data for overall school performance summary
  final Map<String, dynamic> _schoolPerformanceSummary = {
    'academicYear': '2023-2024',
    'overallAverage': 77.8,
    'overallPassingRate': 90.5,
    'overallAttendanceRate': 92.9,
    'totalStudents': 650,
    'highAchievers': 149,
    'needsSupport': 80,
    'highestPerformingGrade': 'Grade 12',
    'lowestPerformingGrade': 'Grade 10',
    'highestPerformingSubject': 'Music',
    'lowestPerformingSubject': 'Physics',
    'improvementFromPreviousYear': '+1.2',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(),
          const SizedBox(height: 24),
          _buildFilters(),
          const SizedBox(height: 24),
          Expanded(
            child: _selectedViewMode == 'summary'
                ? _buildSummaryView()
                : _buildDetailedView(),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Performance Reports',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            _buildViewModeToggle(),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Export Report'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A55A2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Export report feature coming soon')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildViewModeToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildViewModeButton(
            title: 'Summary',
            icon: Icons.dashboard,
            mode: 'summary',
          ),
          _buildViewModeButton(
            title: 'Detailed',
            icon: Icons.analytics,
            mode: 'detailed',
          ),
        ],
      ),
    );
  }

  Widget _buildViewModeButton({
    required String title,
    required IconData icon,
    required String mode,
  }) {
    final bool isSelected = _selectedViewMode == mode;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedViewMode = mode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A55A2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[700],
              size: 16,
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
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildDropdownFilter(
                  label: 'Academic Year',
                  value: _selectedAcademicYear,
                  items: _academicYears,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedAcademicYear = value;
                      });
                    }
                  },
                ),
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
                  label: 'Term',
                  value: _selectedTerm,
                  items: _terms,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedTerm = value;
                      });
                    }
                  },
                ),
                _buildDropdownFilter(
                  label: 'Subject',
                  value: _selectedSubject,
                  items: _subjects,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedSubject = value;
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
                      _selectedAcademicYear = '2023-2024';
                      _selectedGrade = 'All Grades';
                      _selectedTerm = 'All Terms';
                      _selectedSubject = 'All Subjects';
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

  Widget _buildSummaryView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverallPerformanceCard(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildGradePerformanceCard(),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: _buildTermPerformanceCard(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSubjectPerformanceCard(),
        ],
      ),
    );
  }

  Widget _buildOverallPerformanceCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.school, color: Color(0xFF4A55A2)),
                const SizedBox(width: 8),
                Text(
                  'Overall School Performance: ${_schoolPerformanceSummary['academicYear']}',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'Compared to last year: ${_schoolPerformanceSummary['improvementFromPreviousYear']}%',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.bar_chart,
                    iconColor: Colors.blue,
                    title: 'Average Score',
                    value: '${_schoolPerformanceSummary['overallAverage']}%',
                  ),
                ),
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    title: 'Passing Rate',
                    value: '${_schoolPerformanceSummary['overallPassingRate']}%',
                  ),
                ),
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.people,
                    iconColor: Colors.orange,
                    title: 'Attendance Rate',
                    value: '${_schoolPerformanceSummary['overallAttendanceRate']}%',
                  ),
                ),
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.groups,
                    iconColor: Colors.purple,
                    title: 'Total Students',
                    value: '${_schoolPerformanceSummary['totalStudents']}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.emoji_events,
                    iconColor: Colors.amber,
                    title: 'High Achievers',
                    value: '${_schoolPerformanceSummary['highAchievers']} students',
                  ),
                ),
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.support,
                    iconColor: Colors.red,
                    title: 'Needs Support',
                    value: '${_schoolPerformanceSummary['needsSupport']} students',
                  ),
                ),
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.trending_up,
                    iconColor: Colors.teal,
                    title: 'Top Grade',
                    value: _schoolPerformanceSummary['highestPerformingGrade'],
                  ),
                ),
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.trending_down,
                    iconColor: Colors.deepOrange,
                    title: 'Lowest Grade',
                    value: _schoolPerformanceSummary['lowestPerformingGrade'],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.star,
                    iconColor: Colors.amber,
                    title: 'Top Subject',
                    value: _schoolPerformanceSummary['highestPerformingSubject'],
                  ),
                ),
                Expanded(
                  child: _buildOverallStatsItem(
                    icon: Icons.warning,
                    iconColor: Colors.red,
                    title: 'Challenging Subject',
                    value: _schoolPerformanceSummary['lowestPerformingSubject'],
                  ),
                ),
                const Expanded(child: SizedBox()),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallStatsItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 0,
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: iconColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradePerformanceCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.class_, color: Color(0xFF4A55A2)),
                const SizedBox(width: 8),
                const Text(
                  'Grade-wise Performance',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.stacked_bar_chart, size: 16),
                  label: const Text('View Charts'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Charts view coming soon')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Grade',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Avg. Score',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Pass Rate',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Students',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Top Subject',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ..._gradePerformanceData.map((grade) => _buildGradeRow(grade)),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeRow(Map<String, dynamic> grade) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              grade['grade'],
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${grade['averageScore']}%',
              style: const TextStyle(
                fontFamily: 'Nunito',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              '${grade['passingRate']}%',
              style: const TextStyle(
                fontFamily: 'Nunito',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              '${grade['studentCount']}',
              style: const TextStyle(
                fontFamily: 'Nunito',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    grade['topSubject'],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${grade['topSubjectAvg']}%)',
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
    );
  }

  Widget _buildTermPerformanceCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.event_note, color: Color(0xFF4A55A2)),
                const SizedBox(width: 8),
                const Text(
                  'Term-wise Performance',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.info_outline, size: 20),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Term information')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._termWisePerformanceData.map((term) => _buildTermCard(term)),
          ],
        ),
      ),
    );
  }

  Widget _buildTermCard(Map<String, dynamic> term) {
    final hasImprovement = term['improvementFromPrevious'] != null;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              term['term'],
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _buildTermStat('Average Score', '${term['averageScore']}%'),
            const SizedBox(height: 4),
            _buildTermStat('Passing Rate', '${term['passingRate']}%'),
            const SizedBox(height: 4),
            _buildTermStat('Attendance', '${term['attendanceRate']}%'),
            
            if (hasImprovement) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.trending_up, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    'Improvement: ${term['improvementFromPrevious']}%',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTermStat(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectPerformanceCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.book, color: Color(0xFF4A55A2)),
                const SizedBox(width: 8),
                const Text(
                  'Subject-wise Performance',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.stacked_bar_chart, size: 16),
                  label: const Text('View Charts'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Charts view coming soon')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                dataRowHeight: 56,
                columns: const [
                  DataColumn(
                    label: Text(
                      'Subject',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Avg. Score',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      'Pass Rate',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      'Highest Grade',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Lowest Grade',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Gender Gap',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: _subjectPerformanceData.map<DataRow>((subject) {
                  final double maleAvg = subject['malePerfAvg'];
                  final double femaleAvg = subject['femalePerfAvg'];
                  final double genderGap = (maleAvg - femaleAvg).abs();
                  final String genderPerformance = maleAvg > femaleAvg
                      ? 'M +${genderGap.toStringAsFixed(1)}%'
                      : 'F +${genderGap.toStringAsFixed(1)}%';

                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          subject['subject'],
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${subject['averageScore']}%',
                          style: const TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${subject['passingRate']}%',
                          style: const TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Text(
                              subject['highestGrade'],
                              style: const TextStyle(fontFamily: 'Nunito'),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${subject['highestGradeAvg']}%)',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Text(
                              subject['lowestGrade'],
                              style: const TextStyle(fontFamily: 'Nunito'),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${subject['lowestGradeAvg']}%)',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            genderPerformance,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedView() {
    // For demonstration, we'll just show a placeholder
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const Text(
            'Detailed Performance Analytics',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Advanced charts and detailed metrics coming soon',
            style: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.dashboard),
            label: const Text('Back to Summary'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A55A2),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _selectedViewMode = 'summary';
              });
            },
          ),
        ],
      ),
    );
  }
}
