import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_organizer/config/theme.dart';
import 'package:study_organizer/widgets/bottom_nav_bar.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  int _selectedIndex = 1;

  final List<Map<String, dynamic>> subjects = [
    {
      'id': '1',
      'name': 'الرياضيات',
      'color': Colors.blue,
      'notes': 12,
      'tasks': 5,
      'files': 8,
    },
    {
      'id': '2',
      'name': 'الفيزياء',
      'color': Colors.purple,
      'notes': 8,
      'tasks': 3,
      'files': 6,
    },
    {
      'id': '3',
      'name': 'الكيمياء',
      'color': Colors.green,
      'notes': 10,
      'tasks': 4,
      'files': 7,
    },
    {
      'id': '4',
      'name': 'الأدب',
      'color': Colors.orange,
      'notes': 15,
      'tasks': 6,
      'files': 5,
    },
    {
      'id': '5',
      'name': 'التاريخ',
      'color': Colors.red,
      'notes': 9,
      'tasks': 2,
      'files': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المواد الدراسية'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddSubjectDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن مادة...',
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),

            // Subjects Grid
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: subjects.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return GestureDetector(
                  onTap: () => context.go('/subject/${subject['id']}'),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          subject['color'],
                          subject['color'].withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: subject['color'].withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  subject['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    child: Text('تعديل'),
                                  ),
                                  const PopupMenuItem(
                                    child: Text('حذف'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatBadge('${subject['notes']}', 'ملاحظات'),
                              _buildStatBadge('${subject['tasks']}', 'مهام'),
                              _buildStatBadge('${subject['files']}', 'ملفات'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _navigateToPage(index);
        },
      ),
    );
  }

  Widget _buildStatBadge(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  void _showAddSubjectDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة مادة جديدة'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'اسم المادة',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إضافة المادة بنجاح')),
              );
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/subjects');
        break;
      case 2:
        context.go('/tasks');
        break;
      case 3:
        context.go('/stats');
        break;
      case 4:
        context.go('/support');
        break;
    }
  }
}
