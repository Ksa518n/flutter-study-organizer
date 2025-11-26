import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:study_organizer/config/theme.dart';
import 'package:study_organizer/widgets/bottom_nav_bar.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _selectedIndex = 3;
  String _timeRange = 'week'; // week, month, year

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإحصائيات'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Range Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeRangeButton('أسبوع', 'week'),
                _buildTimeRangeButton('شهر', 'month'),
                _buildTimeRangeButton('سنة', 'year'),
              ],
            ),
            const SizedBox(height: 24),

            // Overall Stats
            const Text(
              'الإحصائيات العامة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGray,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildStatCard('ساعات الدراسة', '24.5', Icons.timer, AppTheme.primaryColor),
                _buildStatCard('المهام المكتملة', '18', Icons.check_circle, AppTheme.successColor),
                _buildStatCard('المهام المتبقية', '5', Icons.pending_actions, AppTheme.warningColor),
                _buildStatCard('معدل الإنجاز', '78%', Icons.trending_up, AppTheme.accentColor),
              ],
            ),
            const SizedBox(height: 24),

            // Study Hours Chart
            const Text(
              'ساعات الدراسة اليومية',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGray,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 250,
              padding: const EdgeInsets.all(16),
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
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 2, color: AppTheme.primaryColor)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 3, color: AppTheme.primaryColor)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 2.5, color: AppTheme.primaryColor)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 4, color: AppTheme.primaryColor)]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 3.5, color: AppTheme.primaryColor)]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 5, color: AppTheme.primaryColor)]),
                    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 3, color: AppTheme.primaryColor)]),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'];
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Subjects Performance
            const Text(
              'أداء المواد',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGray,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 250,
              padding: const EdgeInsets.all(16),
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
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 30,
                      color: Colors.blue,
                      title: 'الرياضيات',
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 25,
                      color: Colors.purple,
                      title: 'الفيزياء',
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: Colors.green,
                      title: 'الكيمياء',
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 15,
                      color: Colors.orange,
                      title: 'الأدب',
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 10,
                      color: Colors.red,
                      title: 'التاريخ',
                      radius: 80,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Top Performing Subjects
            const Text(
              'أفضل المواد',
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
                final subjects = ['الرياضيات', 'الفيزياء', 'الكيمياء'];
                final scores = [95, 88, 82];

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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subjects[index],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkGray,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: scores[index] / 100,
                                minHeight: 6,
                                backgroundColor: AppTheme.lightGray,
                                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.successColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${scores[index]}%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
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

  Widget _buildTimeRangeButton(String label, String value) {
    final isSelected = _timeRange == value;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _timeRange = value;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppTheme.primaryColor : AppTheme.lightGray,
        foregroundColor: isSelected ? Colors.white : AppTheme.blueGray,
        elevation: 0,
      ),
      child: Text(label),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.blueGray,
            ),
            textAlign: TextAlign.center,
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
