import 'package:flutter/material.dart';

/// ReportsAttendancePage - Allows admin to view and analyze attendance data across grades and classes
class ReportsAttendancePage extends StatefulWidget {
  const ReportsAttendancePage({super.key});

  @override
  State<ReportsAttendancePage> createState() => _ReportsAttendancePageState();
}

class _ReportsAttendancePageState extends State<ReportsAttendancePage> {
  // Filter variables
  String _selectedAcademicYear = '2023-2024';
  String _selectedGrade = 'All Grades';
  String _selectedClass = 'All Classes';
  String _selectedMonth = 'All Months';
  String _selectedChartType = 'bar'; // 'bar', 'line', 'pie'

  // Mock data for academic years, grades, classes, and months
  final List<String> _academicYears = ['2023-2024', '2022-2023', '2021-2022'];
  final List<String> _grades = [
    'All Grades', 'Grade 7', 'Grade 8', 'Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'
  ];
  final List<String> _classes = [
    'All Classes', '7A', '7B', '8A', '8B', '9A', '9B', '10A', '10B', '11A', '11B', '12A', '12B'
  ];
  final List<String> _months = [
    'All Months', 'January', 'February', 'March', 'April', 'May', 'June', 
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  // Mock data for class attendance records
  final List<Map<String, dynamic>> _classAttendanceData = [
    {
      'class': '7A',
      'grade': 'Grade 7',
      'attendanceRate': 96.2,
      'totalStudents': 32,
      'presentAvg': 30.8,
      'absentAvg': 1.2,
      'lateAvg': 1.3,
      'mostAbsentDay': 'Monday',
      'bestAttendanceDay': 'Wednesday',
      'teacherName': 'Ms. Johnson',
      'monthlyTrend': [97.1, 96.5, 95.8, 96.2, 96.9, 97.3, 95.6, 96.0, 96.2, 96.7, 97.0, 95.8],
    },
    {
      'class': '7B',
      'grade': 'Grade 7',
      'attendanceRate': 95.8,
      'totalStudents': 30,
      'presentAvg': 28.7,
      'absentAvg': 1.3,
      'lateAvg': 1.8,
      'mostAbsentDay': 'Friday',
      'bestAttendanceDay': 'Tuesday',
      'teacherName': 'Mr. Smith',
      'monthlyTrend': [96.2, 95.5, 94.8, 95.2, 95.9, 96.3, 95.0, 95.4, 95.8, 96.2, 96.5, 94.7],
    },
    {
      'class': '8A',
      'grade': 'Grade 8',
      'attendanceRate': 94.5,
      'totalStudents': 35,
      'presentAvg': 33.1,
      'absentAvg': 1.9,
      'lateAvg': 1.5,
      'mostAbsentDay': 'Monday',
      'bestAttendanceDay': 'Thursday',
      'teacherName': 'Ms. Williams',
      'monthlyTrend': [95.0, 94.3, 93.6, 94.0, 94.7, 95.1, 93.8, 94.2, 94.6, 95.0, 95.3, 93.5],
    },
    {
      'class': '8B',
      'grade': 'Grade 8',
      'attendanceRate': 93.9,
      'totalStudents': 33,
      'presentAvg': 31.0,
      'absentAvg': 2.0,
      'lateAvg': 1.7,
      'mostAbsentDay': 'Friday',
      'bestAttendanceDay': 'Wednesday',
      'teacherName': 'Mr. Davis',
      'monthlyTrend': [94.4, 93.7, 93.0, 93.4, 94.1, 94.5, 93.2, 93.6, 94.0, 94.4, 94.7, 92.9],
    },
    {
      'class': '9A',
      'grade': 'Grade 9',
      'attendanceRate': 92.7,
      'totalStudents': 36,
      'presentAvg': 33.4,
      'absentAvg': 2.6,
      'lateAvg': 1.6,
      'mostAbsentDay': 'Monday',
      'bestAttendanceDay': 'Tuesday',
      'teacherName': 'Ms. Brown',
      'monthlyTrend': [93.2, 92.5, 91.8, 92.2, 92.9, 93.3, 92.0, 92.4, 92.8, 93.2, 93.5, 91.7],
    },
    {
      'class': '9B',
      'grade': 'Grade 9',
      'attendanceRate': 91.8,
      'totalStudents': 34,
      'presentAvg': 31.2,
      'absentAvg': 2.8,
      'lateAvg': 2.1,
      'mostAbsentDay': 'Friday',
      'bestAttendanceDay': 'Wednesday',
      'teacherName': 'Mr. Wilson',
      'monthlyTrend': [92.3, 91.6, 90.9, 91.3, 92.0, 92.4, 91.1, 91.5, 91.9, 92.3, 92.6, 90.8],
    },
    {
      'class': '10A',
      'grade': 'Grade 10',
      'attendanceRate': 90.5,
      'totalStudents': 38,
      'presentAvg': 34.4,
      'absentAvg': 3.6,
      'lateAvg': 1.8,
      'mostAbsentDay': 'Monday',
      'bestAttendanceDay': 'Thursday',
      'teacherName': 'Ms. Miller',
      'monthlyTrend': [91.0, 90.3, 89.6, 90.0, 90.7, 91.1, 89.8, 90.2, 90.6, 91.0, 91.3, 89.5],
    },
    {
      'class': '10B',
      'grade': 'Grade 10',
      'attendanceRate': 89.7,
      'totalStudents': 37,
      'presentAvg': 33.2,
      'absentAvg': 3.8,
      'lateAvg': 2.5,
      'mostAbsentDay': 'Friday',
      'bestAttendanceDay': 'Tuesday',
      'teacherName': 'Mr. Moore',
      'monthlyTrend': [90.2, 89.5, 88.8, 89.2, 89.9, 90.3, 89.0, 89.4, 89.8, 90.2, 90.5, 88.7],
    },
    {
      'class': '11A',
      'grade': 'Grade 11',
      'attendanceRate': 91.2,
      'totalStudents': 32,
      'presentAvg': 29.2,
      'absentAvg': 2.8,
      'lateAvg': 1.9,
      'mostAbsentDay': 'Monday',
      'bestAttendanceDay': 'Wednesday',
      'teacherName': 'Ms. Taylor',
      'monthlyTrend': [91.7, 91.0, 90.3, 90.7, 91.4, 91.8, 90.5, 90.9, 91.3, 91.7, 92.0, 90.2],
    },
    {
      'class': '11B',
      'grade': 'Grade 11',
      'attendanceRate': 90.8,
      'totalStudents': 30,
      'presentAvg': 27.2,
      'absentAvg': 2.8,
      'lateAvg': 2.0,
      'mostAbsentDay': 'Friday',
      'bestAttendanceDay': 'Thursday',
      'teacherName': 'Mr. Anderson',
      'monthlyTrend': [91.3, 90.6, 89.9, 90.3, 91.0, 91.4, 90.1, 90.5, 90.9, 91.3, 91.6, 89.8],
    },
    {
      'class': '12A',
      'grade': 'Grade 12',
      'attendanceRate': 93.8,
      'totalStudents': 28,
      'presentAvg': 26.3,
      'absentAvg': 1.7,
      'lateAvg': 1.5,
      'mostAbsentDay': 'Monday',
      'bestAttendanceDay': 'Tuesday',
      'teacherName': 'Ms. Thomas',
      'monthlyTrend': [94.3, 93.6, 92.9, 93.3, 94.0, 94.4, 93.1, 93.5, 93.9, 94.3, 94.6, 92.8],
    },
    {
      'class': '12B',
      'grade': 'Grade 12',
      'attendanceRate': 93.2,
      'totalStudents': 26,
      'presentAvg': 24.2,
      'absentAvg': 1.8,
      'lateAvg': 1.3,
      'mostAbsentDay': 'Friday',
      'bestAttendanceDay': 'Wednesday',
      'teacherName': 'Mr. Jackson',
      'monthlyTrend': [93.7, 93.0, 92.3, 92.7, 93.4, 93.8, 92.5, 92.9, 93.3, 93.7, 94.0, 92.2],
    },
  ];

  // Mock data for top attendance issues
  final List<Map<String, dynamic>> _topAttendanceIssues = [
    {
      'student': 'Alex Johnson',
      'class': '9A',
      'absenceDays': 12,
      'reason': 'Medical',
      'status': 'Excused',
    },
    {
      'student': 'Emily Williams',
      'class': '10B',
      'absenceDays': 10,
      'reason': 'Family Emergency',
      'status': 'Excused',
    },
    {
      'student': 'Daniel Brown',
      'class': '8B',
      'absenceDays': 9,
      'reason': 'Unknown',
      'status': 'Unexcused',
    },
    {
      'student': 'Sophia Davis',
      'class': '11A',
      'absenceDays': 8,
      'reason': 'Sports Competition',
      'status': 'Excused',
    },
    {
      'student': 'Michael Wilson',
      'class': '7A',
      'absenceDays': 7,
      'reason': 'Unknown',
      'status': 'Unexcused',
    },
  ];

  // Mock data for recent attendance notifications
  final List<Map<String, dynamic>> _recentAttendanceNotifications = [
    {
      'date': 'Today, 9:15 AM',
      'message': '3 students marked absent in Grade 10B',
      'type': 'absence',
    },
    {
      'date': 'Today, 8:45 AM',
      'message': '2 students marked late in Grade 11A',
      'type': 'late',
    },
    {
      'date': 'Yesterday, 10:30 AM',
      'message': 'Monthly attendance report for Grade 9 is ready',
      'type': 'report',
    },
    {
      'date': 'Yesterday, 9:05 AM',
      'message': '4 students marked absent in Grade 8A',
      'type': 'absence',
    },
    {
      'date': '2 days ago, 11:20 AM',
      'message': 'Grade 7 has the highest attendance this week',
      'type': 'achievement',
    },
  ];

  // Mock data for overall attendance summary
  final Map<String, dynamic> _overallAttendanceSummary = {
    'overallAttendanceRate': 92.6,
    'totalStudents': 390,
    'presentAvgDaily': 361,
    'absentAvgDaily': 29,
    'lateAvgDaily': 22,
    'mostAbsentGrade': 'Grade 10',
    'bestAttendanceGrade': 'Grade 7',
    'currentMonthTrend': '+0.8%',
  };

  // Mock monthly trend data (percentage for each month)
  final List<double> _monthlyAttendanceTrend = [
    93.5, 92.8, 92.1, 91.5, 92.2, 93.0, 91.7, 92.4, 93.1, 93.8, 93.2, 92.6
  ];
  final List<String> _monthLabels = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildOverallAttendanceCard(),
                  const SizedBox(height: 24),
                  _buildAttendanceChartCard(),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildClassAttendanceTable(),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildAttendanceIssuesCard(),
                            const SizedBox(height: 16),
                            _buildRecentNotificationsCard(),
                          ],
                        ),
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

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Attendance Reports',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            _buildChartTypeToggle(),
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

  Widget _buildChartTypeToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildChartTypeButton(
            title: 'Bar',
            icon: Icons.bar_chart,
            type: 'bar',
          ),
          _buildChartTypeButton(
            title: 'Line',
            icon: Icons.show_chart,
            type: 'line',
          ),
          _buildChartTypeButton(
            title: 'Pie',
            icon: Icons.pie_chart,
            type: 'pie',
          ),
        ],
      ),
    );
  }

  Widget _buildChartTypeButton({
    required String title,
    required IconData icon,
    required String type,
  }) {
    final bool isSelected = _selectedChartType == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedChartType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
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
                  label: 'Class',
                  value: _selectedClass,
                  items: _classes,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedClass = value;
                      });
                    }
                  },
                ),
                _buildDropdownFilter(
                  label: 'Month',
                  value: _selectedMonth,
                  items: _months,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedMonth = value;
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
                      _selectedClass = 'All Classes';
                      _selectedMonth = 'All Months';
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

  Widget _buildOverallAttendanceCard() {
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
                const Icon(Icons.people, color: Color(0xFF4A55A2)),
                const SizedBox(width: 8),
                const Text(
                  'Overall Attendance Summary',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.green[700], size: 16),
                      const SizedBox(width: 4),
                      Text(
                        _overallAttendanceSummary['currentMonthTrend'],
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildAttendanceStatsItem(
                    title: 'Overall Rate',
                    value: '${_overallAttendanceSummary['overallAttendanceRate']}%',
                    icon: Icons.insert_chart,
                    iconColor: const Color(0xFF4A55A2),
                  ),
                ),
                Expanded(
                  child: _buildAttendanceStatsItem(
                    title: 'Total Students',
                    value: '${_overallAttendanceSummary['totalStudents']}',
                    icon: Icons.group,
                    iconColor: Colors.teal,
                  ),
                ),
                Expanded(
                  child: _buildAttendanceStatsItem(
                    title: 'Avg. Present',
                    value: '${_overallAttendanceSummary['presentAvgDaily']}',
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildAttendanceStatsItem(
                    title: 'Avg. Absent',
                    value: '${_overallAttendanceSummary['absentAvgDaily']}',
                    icon: Icons.cancel,
                    iconColor: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildAttendanceStatsItem(
                    title: 'Avg. Late',
                    value: '${_overallAttendanceSummary['lateAvgDaily']}',
                    icon: Icons.watch_later,
                    iconColor: Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildAttendanceStatsItem(
                    title: 'Best Grade',
                    value: _overallAttendanceSummary['bestAttendanceGrade'],
                    icon: Icons.emoji_events,
                    iconColor: Colors.amber,
                  ),
                ),
                Expanded(
                  child: _buildAttendanceStatsItem(
                    title: 'Most Absent',
                    value: _overallAttendanceSummary['mostAbsentGrade'],
                    icon: Icons.warning,
                    iconColor: Colors.deepOrange,
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceStatsItem({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 18),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceChartCard() {
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
                Icon(
                  _selectedChartType == 'bar' 
                      ? Icons.bar_chart 
                      : _selectedChartType == 'line' 
                          ? Icons.show_chart 
                          : Icons.pie_chart,
                  color: const Color(0xFF4A55A2),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Attendance Trends',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: _selectedGrade == 'All Grades' ? 'All Grades' : _selectedGrade,
                  underline: Container(),
                  items: _grades.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontFamily: 'Nunito', fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedGrade = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: _buildMockChart(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Present', Colors.green),
                const SizedBox(width: 24),
                _buildLegendItem('Absent', Colors.red),
                const SizedBox(width: 24),
                _buildLegendItem('Late', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildMockChart() {
    // For demonstration purposes, we'll show a placeholder chart
    // In a real app, use a charting library like fl_chart or charts_flutter
    
    if (_selectedChartType == 'bar') {
      return _buildBarChartPlaceholder();
    } else if (_selectedChartType == 'line') {
      return _buildLineChartPlaceholder();
    } else {
      return _buildPieChartPlaceholder();
    }
  }

  Widget _buildBarChartPlaceholder() {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              _monthLabels.length,
              (index) {
                final double value = _monthlyAttendanceTrend[index];
                final double normalizedHeight = (value - 85) / 15; // Normalize to 0-1 for better visualization
                
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 200 * normalizedHeight,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.7),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: _monthLabels.map((month) {
            return Expanded(
              child: Text(
                month,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLineChartPlaceholder() {
    return Column(
      children: [
        Expanded(
          child: ClipRect(
            child: CustomPaint(
              size: const Size(double.infinity, 200),
              painter: LineChartPainter(_monthlyAttendanceTrend),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: _monthLabels.map((month) {
            return Expanded(
              child: Text(
                month,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPieChartPlaceholder() {
    // A simple pie chart placeholder showing present, absent, late
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 180,
          width: 180,
          child: CustomPaint(
            painter: PieChartPainter(),
          ),
        ),
      ],
    );
  }

  Widget _buildClassAttendanceTable() {
    List<Map<String, dynamic>> filteredData = _classAttendanceData;
    
    // Apply filters
    if (_selectedGrade != 'All Grades') {
      filteredData = filteredData.where((data) => data['grade'] == _selectedGrade).toList();
    }
    if (_selectedClass != 'All Classes') {
      filteredData = filteredData.where((data) => data['class'] == _selectedClass).toList();
    }
    
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
                  'Class Attendance',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.print, size: 16),
                  label: const Text('Print'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Print feature coming soon')),
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
                      'Class',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Grade',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Attendance',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      'Present',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      'Absent',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      'Late',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      'Class Teacher',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: filteredData.map<DataRow>((classData) {
                  final attendanceRate = classData['attendanceRate'];
                  final Color attendanceColor = attendanceRate >= 95
                      ? Colors.green
                      : attendanceRate >= 90 
                          ? Colors.amber
                          : Colors.red;
                
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          classData['class'],
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          classData['grade'],
                          style: const TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: attendanceColor,
                              ),
                              margin: const EdgeInsets.only(right: 8),
                            ),
                            Text(
                              '${classData['attendanceRate']}%',
                              style: const TextStyle(fontFamily: 'Nunito'),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Text(
                          '${classData['presentAvg']}',
                          style: const TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${classData['absentAvg']}',
                          style: const TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${classData['lateAvg']}',
                          style: const TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                      DataCell(
                        Text(
                          classData['teacherName'],
                          style: const TextStyle(fontFamily: 'Nunito'),
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

  Widget _buildAttendanceIssuesCard() {
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
                const Icon(Icons.warning, color: Colors.deepOrange),
                const SizedBox(width: 8),
                const Text(
                  'Top Attendance Issues',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 20),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._topAttendanceIssues.map((issue) => _buildIssueItem(issue)),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueItem(Map<String, dynamic> issue) {
    final bool isExcused = issue['status'] == 'Excused';
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isExcused ? Colors.orange[100] : Colors.red[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                isExcused ? Icons.notification_important : Icons.cancel,
                color: isExcused ? Colors.orange[700] : Colors.red[700],
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issue['student'],
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${issue['class']} - ${issue['absenceDays']} days absent',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isExcused ? Colors.green[100] : Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        issue['status'],
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isExcused ? Colors.green[700] : Colors.red[700],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Reason: ${issue['reason']}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentNotificationsCard() {
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
                const Icon(Icons.notifications, color: Color(0xFF4A55A2)),
                const SizedBox(width: 8),
                const Text(
                  'Recent Notifications',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  child: const Text('View All'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('View all notifications coming soon')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._recentAttendanceNotifications.map((notification) => _buildNotificationItem(notification)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    IconData iconData;
    Color iconColor;
    
    switch (notification['type']) {
      case 'absence':
        iconData = Icons.person_off;
        iconColor = Colors.red;
        break;
      case 'late':
        iconData = Icons.watch_later;
        iconColor = Colors.orange;
        break;
      case 'report':
        iconData = Icons.description;
        iconColor = Colors.blue;
        break;
      case 'achievement':
        iconData = Icons.emoji_events;
        iconColor = Colors.amber;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = Colors.grey;
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['message'],
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['date'],
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
}

// Simple line chart painter
class LineChartPainter extends CustomPainter {
  final List<double> dataPoints;
  
  LineChartPainter(this.dataPoints);
  
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
      
    final Paint dotPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
      
    final Path path = Path();
    
    // Normalize data to fit within the chart area
    // We assume the minimum attendance is 85% and maximum is 100%
    const double minValue = 85;
    const double maxValue = 100;
    
    for (int i = 0; i < dataPoints.length; i++) {
      final double x = i * size.width / (dataPoints.length - 1);
      final double normalizedY = (dataPoints[i] - minValue) / (maxValue - minValue);
      // Flip Y coordinates because canvas Y increases downward
      final double y = size.height - normalizedY * size.height;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      
      // Draw dots at each data point
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }
    
    canvas.drawPath(path, linePaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Simple pie chart painter
class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;
    
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    
    // Present - 92%
    paint.color = Colors.green;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * 3.14 * 0.92,
      true,
      paint,
    );
    
    // Absent - 5%
    paint.color = Colors.red;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      2 * 3.14 * 0.92,
      2 * 3.14 * 0.05,
      true,
      paint,
    );
    
    // Late - 3%
    paint.color = Colors.orange;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      2 * 3.14 * 0.97,
      2 * 3.14 * 0.03,
      true,
      paint,
    );
    
    // Draw a white circle in the middle for a donut chart effect
    paint.color = Colors.white;
    canvas.drawCircle(center, radius * 0.5, paint);
    
    // Add labels
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    textPainter.text = const TextSpan(
      text: '92%',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Nunito',
      ),
    );
    
    textPainter.layout();
    textPainter.paint(
      canvas, 
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
