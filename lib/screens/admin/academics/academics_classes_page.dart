import 'package:flutter/material.dart';

/// AcademicsClassesPage - Manages classes, subjects, and schedules for the school
class AcademicsClassesPage extends StatefulWidget {
  const AcademicsClassesPage({super.key});

  @override
  State<AcademicsClassesPage> createState() => _AcademicsClassesPageState();
}

class _AcademicsClassesPageState extends State<AcademicsClassesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
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
          const SizedBox(height: 24),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ClassesTab(),
                _SubjectsTab(),
                _ScheduleTab(),
              ],
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Academic Management',
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
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add New'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A55A2),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            _showAddMenu(context);
          },
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFF4A55A2),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black87,
        labelStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'Classes & Sections'),
          Tab(text: 'Subjects'),
          Tab(text: 'Schedules'),
        ],
      ),
    );
  }

  void _showAddMenu(BuildContext context) {
    final items = <String>[
      'Add New Class',
      'Add New Section',
      'Add New Subject',
      'Create Schedule',
    ];

    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: items.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(fontFamily: 'Nunito')),
        );
      }).toList(),
    ).then((String? value) {
      if (value != null) {
        switch (value) {
          case 'Add New Class':
            _tabController.animateTo(0);
            _showAddClassDialog(context);
            break;
          case 'Add New Section':
            _tabController.animateTo(0);
            _showAddSectionDialog(context);
            break;
          case 'Add New Subject':
            _tabController.animateTo(1);
            _showAddSubjectDialog(context);
            break;
          case 'Create Schedule':
            _tabController.animateTo(2);
            _showAddScheduleDialog(context);
            break;
        }
      }
    });
  }

  void _showAddClassDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        String className = '';
        
        return AlertDialog(
          title: const Text(
            'Add New Class',
            style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formKey,
            child: TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Class Name',
                hintText: 'e.g. Grade 10',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a class name';
                }
                return null;
              },
              onSaved: (value) {
                className = value ?? '';
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A55A2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New class "$className" added')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddSectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        String sectionName = '';
        String selectedClass = 'Grade 10';
        
        final classList = [
          'Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 
          'Grade 10', 'Grade 11', 'Grade 12'
        ];
        
        return AlertDialog(
          title: const Text(
            'Add New Section',
            style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedClass,
                  decoration: const InputDecoration(
                    labelText: 'Select Class',
                  ),
                  items: classList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    selectedClass = newValue ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a class';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Section Name',
                    hintText: 'e.g. A, B, C',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a section name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    sectionName = value ?? '';
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A55A2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New section "$sectionName" added to $selectedClass')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddSubjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        String subjectName = '';
        String subjectCode = '';
        String selectedClass = 'Grade 10';
        
        final classList = [
          'All Classes', 'Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 
          'Grade 10', 'Grade 11', 'Grade 12'
        ];
        
        return AlertDialog(
          title: const Text(
            'Add New Subject',
            style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Subject Name',
                    hintText: 'e.g. Mathematics',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    subjectName = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Subject Code',
                    hintText: 'e.g. MATH101',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject code';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    subjectCode = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedClass,
                  decoration: const InputDecoration(
                    labelText: 'Applicable to Class',
                  ),
                  items: classList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    selectedClass = newValue ?? '';
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A55A2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New subject "$subjectName ($subjectCode)" added')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        String selectedClass = 'Grade 10';
        String selectedSection = 'A';
        String selectedSubject = 'Mathematics';
        String selectedDay = 'Monday';
        String startTime = '8:00 AM';
        String endTime = '9:00 AM';
        
        final classList = [
          'Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 
          'Grade 10', 'Grade 11', 'Grade 12'
        ];
        
        final sectionList = ['A', 'B', 'C'];
        
        final subjectList = [
          'Mathematics', 'Science', 'English', 'History', 
          'Computer Science', 'Physical Education'
        ];
        
        final dayList = [
          'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'
        ];
        
        return AlertDialog(
          title: const Text(
            'Create Schedule',
            style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedClass,
                    decoration: const InputDecoration(
                      labelText: 'Class',
                    ),
                    items: classList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedClass = newValue ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a class';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedSection,
                    decoration: const InputDecoration(
                      labelText: 'Section',
                    ),
                    items: sectionList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedSection = newValue ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a section';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedSubject,
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                    ),
                    items: subjectList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedSubject = newValue ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a subject';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedDay,
                    decoration: const InputDecoration(
                      labelText: 'Day',
                    ),
                    items: dayList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedDay = newValue ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a day';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: startTime,
                          decoration: const InputDecoration(
                            labelText: 'Start Time',
                          ),
                          items: [
                            '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM',
                            '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            startTime = newValue ?? '';
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: endTime,
                          decoration: const InputDecoration(
                            labelText: 'End Time',
                          ),
                          items: [
                            '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM',
                            '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            endTime = newValue ?? '';
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A55A2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Create'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New schedule created for $selectedSubject ($selectedClass-$selectedSection)')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

// Classes Tab Content
class _ClassesTab extends StatelessWidget {
  final List<Map<String, dynamic>> _classData = [
    {
      'grade': 'Grade 6',
      'sections': ['A', 'B', 'C'],
      'classTeacher': 'Mr. Johnson',
      'totalStudents': 95,
      'capacity': 100,
    },
    {
      'grade': 'Grade 7',
      'sections': ['A', 'B', 'C'],
      'classTeacher': 'Mrs. Davis',
      'totalStudents': 92,
      'capacity': 100,
    },
    {
      'grade': 'Grade 8',
      'sections': ['A', 'B', 'C'],
      'classTeacher': 'Mr. Wilson',
      'totalStudents': 101,
      'capacity': 100,
    },
    {
      'grade': 'Grade 9',
      'sections': ['A', 'B', 'C', 'D'],
      'classTeacher': 'Ms. Brown',
      'totalStudents': 105,
      'capacity': 120,
    },
    {
      'grade': 'Grade 10',
      'sections': ['A', 'B', 'C'],
      'classTeacher': 'Mrs. Thompson',
      'totalStudents': 99,
      'capacity': 100,
    },
    {
      'grade': 'Grade 11',
      'sections': ['A', 'B', 'C'],
      'classTeacher': 'Mr. Garcia',
      'totalStudents': 91,
      'capacity': 100,
    },
    {
      'grade': 'Grade 12',
      'sections': ['A', 'B', 'C'],
      'classTeacher': 'Mrs. Martinez',
      'totalStudents': 87,
      'capacity': 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search classes...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    hint: const Text('Filter by'),
                    underline: Container(),
                    items: <String>['All Grades', 'Primary', 'Secondary', 'Higher Secondary']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Grade',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Sections',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Class Teacher',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Total Students',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Capacity',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Actions',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _classData.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final classInfo = _classData[index];
                        final fillPercentage = (classInfo['totalStudents'] as int) / (classInfo['capacity'] as int) * 100;
                        
                        Color statusColor;
                        if (fillPercentage >= 100) {
                          statusColor = Colors.red;
                        } else if (fillPercentage >= 90) {
                          statusColor = Colors.orange;
                        } else {
                          statusColor = Colors.green;
                        }
                        
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  classInfo['grade'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Wrap(
                                  spacing: 4,
                                  children: (classInfo['sections'] as List<String>).map((section) {
                                    return Chip(
                                      label: Text(
                                        section,
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 12,
                                        ),
                                      ),
                                      padding: EdgeInsets.zero,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    );
                                  }).toList(),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  classInfo['classTeacher'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${classInfo['totalStudents']}',
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Stack(
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
                                                color: statusColor,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${classInfo['totalStudents']}/${classInfo['capacity']}',
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 12,
                                        color: statusColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 20),
                                      onPressed: () {},
                                      tooltip: 'Edit',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.visibility, size: 20),
                                      onPressed: () {},
                                      tooltip: 'View Details',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}

// Subjects Tab Content
class _SubjectsTab extends StatelessWidget {
  final List<Map<String, dynamic>> _subjectData = [
    {
      'code': 'MATH101',
      'name': 'Mathematics',
      'applicableClasses': ['Grade 6', 'Grade 7', 'Grade 8'],
      'teachers': ['Mr. Johnson', 'Mrs. Wilson'],
    },
    {
      'code': 'SCI101',
      'name': 'Science',
      'applicableClasses': ['Grade 6', 'Grade 7', 'Grade 8'],
      'teachers': ['Ms. Brown', 'Mr. Davis'],
    },
    {
      'code': 'ENG101',
      'name': 'English',
      'applicableClasses': ['Grade 6', 'Grade 7', 'Grade 8'],
      'teachers': ['Mrs. Martinez', 'Ms. Thompson'],
    },
    {
      'code': 'HIST101',
      'name': 'History',
      'applicableClasses': ['Grade 6', 'Grade 7', 'Grade 8'],
      'teachers': ['Mr. Garcia'],
    },
    {
      'code': 'CS101',
      'name': 'Computer Science',
      'applicableClasses': ['Grade 6', 'Grade 7', 'Grade 8'],
      'teachers': ['Ms. Rodriguez', 'Mr. Lee'],
    },
    {
      'code': 'MATH201',
      'name': 'Advanced Mathematics',
      'applicableClasses': ['Grade 9', 'Grade 10'],
      'teachers': ['Mr. Wilson', 'Mrs. Davis'],
    },
    {
      'code': 'SCI201',
      'name': 'Physics',
      'applicableClasses': ['Grade 9', 'Grade 10'],
      'teachers': ['Mrs. Johnson'],
    },
    {
      'code': 'SCI202',
      'name': 'Chemistry',
      'applicableClasses': ['Grade 9', 'Grade 10'],
      'teachers': ['Mr. Brown'],
    },
    {
      'code': 'SCI203',
      'name': 'Biology',
      'applicableClasses': ['Grade 9', 'Grade 10'],
      'teachers': ['Ms. Garcia'],
    },
    {
      'code': 'MATH301',
      'name': 'Calculus',
      'applicableClasses': ['Grade 11', 'Grade 12'],
      'teachers': ['Mrs. Wilson'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search subjects...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    hint: const Text('Filter by Grade'),
                    underline: Container(),
                    items: <String>['All Grades', 'Grade 6-8', 'Grade 9-10', 'Grade 11-12']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _subjectData.length,
              itemBuilder: (context, index) {
                final subject = _subjectData[index];
                return _buildSubjectCard(context, subject);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
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
                Text(
                  subject['code'] as String,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      tooltip: 'Edit',
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      tooltip: 'Delete',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subject['name'] as String,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Applicable to:',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: (subject['applicableClasses'] as List<String>).map((className) {
                      return Chip(
                        label: Text(
                          className,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 10,
                          ),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.grey[100],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.people, size: 14, color: Color(0xFF4A55A2)),
                const SizedBox(width: 4),
                Text(
                  'Teachers: ${(subject['teachers'] as List<String>).join(", ")}',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Schedule Tab Content
class _ScheduleTab extends StatefulWidget {
  @override
  State<_ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<_ScheduleTab> {
  String _selectedClass = 'Grade 10';
  String _selectedSection = 'A';

  final Map<String, List<Map<String, dynamic>>> _scheduleData = {
    'Monday': [
      {
        'subject': 'Mathematics',
        'time': '8:00 AM - 9:00 AM',
        'teacher': 'Mr. Johnson',
        'room': 'Room 101',
      },
      {
        'subject': 'Physics',
        'time': '9:00 AM - 10:00 AM',
        'teacher': 'Mrs. Johnson',
        'room': 'Room 102',
      },
      {
        'subject': 'English',
        'time': '10:15 AM - 11:15 AM',
        'teacher': 'Mrs. Martinez',
        'room': 'Room 103',
      },
      {
        'subject': 'Computer Science',
        'time': '11:15 AM - 12:15 PM',
        'teacher': 'Ms. Rodriguez',
        'room': 'Computer Lab',
      },
      {
        'subject': 'BREAK',
        'time': '12:15 PM - 1:00 PM',
        'teacher': '',
        'room': 'Cafeteria',
      },
      {
        'subject': 'History',
        'time': '1:00 PM - 2:00 PM',
        'teacher': 'Mr. Garcia',
        'room': 'Room 104',
      },
      {
        'subject': 'Physical Education',
        'time': '2:00 PM - 3:00 PM',
        'teacher': 'Coach Williams',
        'room': 'Gym',
      },
    ],
    'Tuesday': [
      {
        'subject': 'Chemistry',
        'time': '8:00 AM - 9:00 AM',
        'teacher': 'Mr. Brown',
        'room': 'Science Lab',
      },
      {
        'subject': 'Mathematics',
        'time': '9:00 AM - 10:00 AM',
        'teacher': 'Mr. Johnson',
        'room': 'Room 101',
      },
      {
        'subject': 'English',
        'time': '10:15 AM - 11:15 AM',
        'teacher': 'Mrs. Martinez',
        'room': 'Room 103',
      },
      {
        'subject': 'Biology',
        'time': '11:15 AM - 12:15 PM',
        'teacher': 'Ms. Garcia',
        'room': 'Science Lab',
      },
      {
        'subject': 'BREAK',
        'time': '12:15 PM - 1:00 PM',
        'teacher': '',
        'room': 'Cafeteria',
      },
      {
        'subject': 'Art',
        'time': '1:00 PM - 2:00 PM',
        'teacher': 'Ms. Lee',
        'room': 'Art Studio',
      },
      {
        'subject': 'Computer Science',
        'time': '2:00 PM - 3:00 PM',
        'teacher': 'Ms. Rodriguez',
        'room': 'Computer Lab',
      },
    ],
    'Wednesday': [
      {
        'subject': 'Physics',
        'time': '8:00 AM - 9:00 AM',
        'teacher': 'Mrs. Johnson',
        'room': 'Room 102',
      },
      {
        'subject': 'Mathematics',
        'time': '9:00 AM - 10:00 AM',
        'teacher': 'Mr. Johnson',
        'room': 'Room 101',
      },
      {
        'subject': 'History',
        'time': '10:15 AM - 11:15 AM',
        'teacher': 'Mr. Garcia',
        'room': 'Room 104',
      },
      {
        'subject': 'English',
        'time': '11:15 AM - 12:15 PM',
        'teacher': 'Mrs. Martinez',
        'room': 'Room 103',
      },
      {
        'subject': 'BREAK',
        'time': '12:15 PM - 1:00 PM',
        'teacher': '',
        'room': 'Cafeteria',
      },
      {
        'subject': 'Chemistry',
        'time': '1:00 PM - 2:00 PM',
        'teacher': 'Mr. Brown',
        'room': 'Science Lab',
      },
      {
        'subject': 'Music',
        'time': '2:00 PM - 3:00 PM',
        'teacher': 'Mr. Wilson',
        'room': 'Music Room',
      },
    ],
    'Thursday': [
      {
        'subject': 'Biology',
        'time': '8:00 AM - 9:00 AM',
        'teacher': 'Ms. Garcia',
        'room': 'Science Lab',
      },
      {
        'subject': 'Mathematics',
        'time': '9:00 AM - 10:00 AM',
        'teacher': 'Mr. Johnson',
        'room': 'Room 101',
      },
      {
        'subject': 'Computer Science',
        'time': '10:15 AM - 11:15 AM',
        'teacher': 'Ms. Rodriguez',
        'room': 'Computer Lab',
      },
      {
        'subject': 'English',
        'time': '11:15 AM - 12:15 PM',
        'teacher': 'Mrs. Martinez',
        'room': 'Room 103',
      },
      {
        'subject': 'BREAK',
        'time': '12:15 PM - 1:00 PM',
        'teacher': '',
        'room': 'Cafeteria',
      },
      {
        'subject': 'Physics',
        'time': '1:00 PM - 2:00 PM',
        'teacher': 'Mrs. Johnson',
        'room': 'Room 102',
      },
      {
        'subject': 'Library',
        'time': '2:00 PM - 3:00 PM',
        'teacher': 'Mrs. Davis',
        'room': 'Library',
      },
    ],
    'Friday': [
      {
        'subject': 'English',
        'time': '8:00 AM - 9:00 AM',
        'teacher': 'Mrs. Martinez',
        'room': 'Room 103',
      },
      {
        'subject': 'Mathematics',
        'time': '9:00 AM - 10:00 AM',
        'teacher': 'Mr. Johnson',
        'room': 'Room 101',
      },
      {
        'subject': 'Chemistry',
        'time': '10:15 AM - 11:15 AM',
        'teacher': 'Mr. Brown',
        'room': 'Science Lab',
      },
      {
        'subject': 'History',
        'time': '11:15 AM - 12:15 PM',
        'teacher': 'Mr. Garcia',
        'room': 'Room 104',
      },
      {
        'subject': 'BREAK',
        'time': '12:15 PM - 1:00 PM',
        'teacher': '',
        'room': 'Cafeteria',
      },
      {
        'subject': 'Physical Education',
        'time': '1:00 PM - 2:00 PM',
        'teacher': 'Coach Williams',
        'room': 'Gym',
      },
      {
        'subject': 'Club Activities',
        'time': '2:00 PM - 3:00 PM',
        'teacher': 'Various',
        'room': 'Various',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Text(
                          'Class:',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedClass,
                          underline: Container(),
                          items: <String>[
                            'Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 
                            'Grade 10', 'Grade 11', 'Grade 12'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedClass = newValue;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Text(
                          'Section:',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedSection,
                          underline: Container(),
                          items: <String>['A', 'B', 'C']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedSection = newValue;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.print),
                    label: const Text('Print Schedule'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Print schedule feature coming soon')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF4A55A2),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black87,
                      labelStyle: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      tabs: const [
                        Tab(text: 'Monday'),
                        Tab(text: 'Tuesday'),
                        Tab(text: 'Wednesday'),
                        Tab(text: 'Thursday'),
                        Tab(text: 'Friday'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildDaySchedule('Monday'),
                        _buildDaySchedule('Tuesday'),
                        _buildDaySchedule('Wednesday'),
                        _buildDaySchedule('Thursday'),
                        _buildDaySchedule('Friday'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySchedule(String day) {
    final schedule = _scheduleData[day] ?? [];
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$day Schedule',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: schedule.length,
                itemBuilder: (context, index) {
                  final item = schedule[index];
                  final isBreak = item['subject'] == 'BREAK';
                  
                  return Card(
                    elevation: 1,
                    color: isBreak ? Colors.grey[100] : Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isBreak ? Colors.grey : const Color(0xFF4A55A2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['time'] as String,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    color: isBreak ? Colors.grey[600] : Colors.black87,
                                  ),
                                ),
                                if (!isBreak) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    item['room'] as String,
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              item['subject'] as String,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: isBreak ? FontWeight.normal : FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (!isBreak)
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['teacher'] as String,
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (!isBreak)
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                              tooltip: 'Edit',
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
