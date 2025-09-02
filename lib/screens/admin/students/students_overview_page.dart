import 'package:flutter/material.dart';

/// StudentsOverviewPage - Dashboard overview of student information and statistics
class StudentsOverviewPage extends StatefulWidget {
  const StudentsOverviewPage({super.key});

  @override
  State<StudentsOverviewPage> createState() => _StudentsOverviewPageState();
}

class _StudentsOverviewPageState extends State<StudentsOverviewPage> {
  // Mock data for demonstration
  final Map<String, dynamic> _statsData = {
    'totalStudents': 1250,
    'activeStudents': 1230,
    'inactiveStudents': 20,
    'maleStudents': 640,
    'femaleStudents': 610,
    'newAdmissions': 145,
    'graduatingStudents': 120,
    'averageAttendance': 94.5,
    'classList': [
      {'grade': 'Grade 1', 'count': 95, 'capacity': 100, 'fillPercentage': 95},
      {'grade': 'Grade 2', 'count': 98, 'capacity': 100, 'fillPercentage': 98},
      {'grade': 'Grade 3', 'count': 97, 'capacity': 100, 'fillPercentage': 97},
      {'grade': 'Grade 4', 'count': 102, 'capacity': 100, 'fillPercentage': 102},
      {'grade': 'Grade 5', 'count': 89, 'capacity': 100, 'fillPercentage': 89},
      {'grade': 'Grade 6', 'count': 94, 'capacity': 100, 'fillPercentage': 94},
      {'grade': 'Grade 7', 'count': 92, 'capacity': 100, 'fillPercentage': 92},
      {'grade': 'Grade 8', 'count': 101, 'capacity': 100, 'fillPercentage': 101},
      {'grade': 'Grade 9', 'count': 105, 'capacity': 100, 'fillPercentage': 105},
      {'grade': 'Grade 10', 'count': 99, 'capacity': 100, 'fillPercentage': 99},
      {'grade': 'Grade 11', 'count': 91, 'capacity': 100, 'fillPercentage': 91},
      {'grade': 'Grade 12', 'count': 87, 'capacity': 100, 'fillPercentage': 87},
    ],
    'attendanceData': [
      {'month': 'Jan', 'percentage': 96.2},
      {'month': 'Feb', 'percentage': 95.8},
      {'month': 'Mar', 'percentage': 94.5},
      {'month': 'Apr', 'percentage': 93.7},
      {'month': 'May', 'percentage': 95.1},
      {'month': 'Jun', 'percentage': 96.8},
      {'month': 'Jul', 'percentage': 92.3},
      {'month': 'Aug', 'percentage': 93.5},
      {'month': 'Sep', 'percentage': 94.7},
      {'month': 'Oct', 'percentage': 95.2},
      {'month': 'Nov', 'percentage': 94.8},
      {'month': 'Dec', 'percentage': 93.9},
    ],
    'recentAdmissions': [
      {'id': 'S1275', 'name': 'Sarah Johnson', 'grade': 'Grade 3', 'date': '15 Aug 2025', 'photo': 'assets/student1.jpg'},
      {'id': 'S1274', 'name': 'Michael Lee', 'grade': 'Grade 5', 'date': '14 Aug 2025', 'photo': 'assets/student2.jpg'},
      {'id': 'S1273', 'name': 'Emma Wilson', 'grade': 'Grade 1', 'date': '14 Aug 2025', 'photo': 'assets/student3.jpg'},
      {'id': 'S1272', 'name': 'David Thompson', 'grade': 'Grade 9', 'date': '13 Aug 2025', 'photo': 'assets/student4.jpg'},
      {'id': 'S1271', 'name': 'Sophia Martinez', 'grade': 'Grade 7', 'date': '13 Aug 2025', 'photo': 'assets/student5.jpg'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 1100;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPageHeader(),
            const SizedBox(height: 24),
            _buildStatCards(),
            const SizedBox(height: 24),
            if (isWideScreen)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildEnrollmentByGrade(),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: _buildRecentAdmissions(),
                  ),
                ],
              )
            else
              Column(
                children: [
                  _buildEnrollmentByGrade(),
                  const SizedBox(height: 24),
                  _buildRecentAdmissions(),
                ],
              ),
            const SizedBox(height: 24),
            _buildAttendanceChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Students Overview',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Academic Year 2025-2026',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.person_add),
              label: const Text('New Admission'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A55A2),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New admission feature coming soon')),
                );
              },
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Export'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF4A55A2),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Export feature coming soon')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCards() {
    return GridView.count(
      crossAxisCount: _getStatCardCrossAxisCount(MediaQuery.of(context).size.width),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          title: 'Total Students',
          value: _statsData['totalStudents'].toString(),
          iconData: Icons.people,
          color: const Color(0xFF4A55A2),
          description: '+5% from last semester',
        ),
        _buildStatCard(
          title: 'New Admissions',
          value: _statsData['newAdmissions'].toString(),
          iconData: Icons.person_add,
          color: Colors.green,
          description: 'This academic year',
        ),
        _buildStatCard(
          title: 'Average Attendance',
          value: '${_statsData['averageAttendance']}%',
          iconData: Icons.check_circle,
          color: Colors.blue,
          description: 'Last 30 days',
        ),
        _buildStatCard(
          title: 'Graduating Students',
          value: _statsData['graduatingStudents'].toString(),
          iconData: Icons.school,
          color: Colors.orange,
          description: 'This academic year',
        ),
      ],
    );
  }

  int _getStatCardCrossAxisCount(double width) {
    if (width > 1400) return 4;
    if (width > 1000) return 4;
    if (width > 600) return 2;
    return 1;
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData iconData,
    required Color color,
    required String description,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                Icon(
                  iconData,
                  color: color,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnrollmentByGrade() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enrollment by Grade',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _statsData['classList'].length,
              itemBuilder: (context, index) {
                final classData = _statsData['classList'][index];
                final fillPercentage = classData['fillPercentage'];
                
                // Determine color based on capacity
                Color barColor;
                if (fillPercentage > 100) {
                  barColor = Colors.red;
                } else if (fillPercentage > 90) {
                  barColor = Colors.orange;
                } else {
                  barColor = const Color(0xFF4A55A2);
                }
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            classData['grade'],
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${classData['count']}/${classData['capacity']}',
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Stack(
                        children: [
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: fillPercentage / 100 > 1 ? 1 : fillPercentage / 100,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.visibility),
                  label: const Text('View All Classes'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('View all classes feature coming soon')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAdmissions() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Admissions',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _statsData['recentAdmissions'].length,
              itemBuilder: (context, index) {
                final student = _statsData['recentAdmissions'][index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student['name'],
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${student['id']} | ${student['grade']}',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        student['date'],
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton.icon(
                icon: const Icon(Icons.people),
                label: const Text('View All Students'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('View all students feature coming soon')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceChart() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Attendance Trend',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: 'Year',
                  underline: Container(),
                  items: <String>['Year', 'Semester', 'Month']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontFamily: 'Nunito')),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              child: _buildBarChart(_statsData['attendanceData']),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(List<dynamic> data) {
    final maxPercentage = 100.0;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            final value = maxPercentage - (index * 20);
            return Text(
              '$value%',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                color: Colors.grey[600],
              ),
            );
          }),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: data.map<Widget>((item) {
              final percentage = item['percentage'] as double;
              final barHeight = (percentage / maxPercentage) * 180;
              
              return Column(
                children: [
                  Container(
                    width: 20,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: _getBarColor(percentage),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['month'],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Color _getBarColor(double value) {
    if (value >= 95) return const Color(0xFF4A55A2);
    if (value >= 90) return Colors.blue;
    if (value >= 85) return Colors.orange;
    return Colors.red;
  }
}
