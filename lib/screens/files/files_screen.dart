import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_organizer/config/theme.dart';
import 'package:study_organizer/widgets/bottom_nav_bar.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({Key? key}) : super(key: key);

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  int _selectedIndex = 0;
  String _sortBy = 'recent'; // recent, name, size

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملفات'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: _showUploadDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Storage Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.lavender,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'مساحة التخزين',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.65,
                      minHeight: 8,
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '6.5 GB من 10 GB',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.blueGray,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Sort Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'جميع الملفات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkGray,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () => setState(() => _sortBy = 'recent'),
                      child: const Text('الأحدث'),
                    ),
                    PopupMenuItem(
                      onTap: () => setState(() => _sortBy = 'name'),
                      child: const Text('الاسم'),
                    ),
                    PopupMenuItem(
                      onTap: () => setState(() => _sortBy = 'size'),
                      child: const Text('الحجم'),
                    ),
                  ],
                  child: const Icon(Icons.sort),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Files List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                final fileTypes = ['PDF', 'DOCX', 'XLSX', 'PPTX', 'JPG', 'PNG'];
                final fileType = fileTypes[index % fileTypes.length];
                final fileIcons = {
                  'PDF': Icons.picture_as_pdf,
                  'DOCX': Icons.description,
                  'XLSX': Icons.table_chart,
                  'PPTX': Icons.slideshow,
                  'JPG': Icons.image,
                  'PNG': Icons.image,
                };
                final fileColors = {
                  'PDF': Colors.red,
                  'DOCX': Colors.blue,
                  'XLSX': Colors.green,
                  'PPTX': Colors.orange,
                  'JPG': Colors.purple,
                  'PNG': Colors.purple,
                };

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
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: fileColors[fileType]!.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          fileIcons[fileType],
                          color: fileColors[fileType],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ملف_${index + 1}.$fileType',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkGray,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '${(index + 1) * 0.5} MB',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.blueGray.withOpacity(0.7),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'الرياضيات',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.blueGray.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            child: Text('تحميل'),
                          ),
                          const PopupMenuItem(
                            child: Text('مشاركة'),
                          ),
                          const PopupMenuItem(
                            child: Text('حذف'),
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

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('رفع ملف'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: const Text('من الهاتف'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم اختيار الملف')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('التقاط صورة'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم التقاط الصورة')),
                );
              },
            ),
          ],
        ),
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
