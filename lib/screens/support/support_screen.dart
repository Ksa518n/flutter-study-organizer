import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_organizer/config/theme.dart';
import 'package:study_organizer/widgets/bottom_nav_bar.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int _selectedIndex = 4;
  String _filterStatus = 'all'; // all, open, closed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم الفني'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateTicketDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('الكل', 'all'),
                  const SizedBox(width: 8),
                  _buildFilterChip('مفتوحة', 'open'),
                  const SizedBox(width: 8),
                  _buildFilterChip('مغلقة', 'closed'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // FAQ Section
            const Text(
              'الأسئلة الشائعة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGray,
              ),
            ),
            const SizedBox(height: 12),
            _buildFAQItem('كيفية إضافة مادة جديدة؟', 'يمكنك إضافة مادة جديدة من خلال الضغط على زر الإضافة في صفحة المواد.'),
            _buildFAQItem('كيفية تحميل الملفات؟', 'اضغط على أيقونة التحميل في صفحة الملفات واختر الملف المراد تحميله.'),
            _buildFAQItem('كيفية إنشاء مهمة جديدة؟', 'توجه إلى صفحة المهام واضغط على زر الإضافة.'),
            const SizedBox(height: 24),

            // Support Tickets
            const Text(
              'تذاكر الدعم الخاصة بك',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGray,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final statuses = ['مفتوحة', 'قيد المراجعة', 'مغلقة'];
                final statusColors = [AppTheme.warningColor, AppTheme.accentColor, AppTheme.successColor];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تذكرة #${1000 + index}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkGray,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'مشكلة في تحميل الملفات',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.blueGray.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: statusColors[index].withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              statuses[index],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColors[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: AppTheme.blueGray,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'تم الإنشاء: ${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.blueGray.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
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

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filterStatus == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filterStatus = value;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppTheme.blueGray,
        fontWeight: FontWeight.w500,
      ),
      side: BorderSide(
        color: isSelected ? AppTheme.primaryColor : AppTheme.lightGray,
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkGray,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.blueGray.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateTicketDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إنشاء تذكرة دعم جديدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'الموضوع',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'الوصف',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(value: 'bug', child: Text('خطأ')),
                DropdownMenuItem(value: 'feature', child: Text('طلب ميزة')),
                DropdownMenuItem(value: 'other', child: Text('أخرى')),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'نوع المشكلة',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
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
                const SnackBar(content: Text('تم إنشاء التذكرة بنجاح')),
              );
            },
            child: const Text('إنشاء'),
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
