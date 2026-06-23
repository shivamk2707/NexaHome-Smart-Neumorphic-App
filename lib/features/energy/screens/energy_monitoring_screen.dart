import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';

class EnergyMonitoringScreen extends StatelessWidget {
  const EnergyMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Energy Usage', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeumorphicContainer(
                borderRadius: 24.r,
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    Text('Total Usage this month', style: AppTextStyles.labelMedium(AppColors.lightTextSecondary)),
                    SizedBox(height: 8.h),
                    Text('345 kWh', style: AppTextStyles.display(AppColors.primary)),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              Text('Weekly Overview', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),

              NeumorphicContainer(
                borderRadius: 24.r,
                padding: EdgeInsets.all(16.w),
                height: 250.h,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                            if (value.toInt() >= 0 && value.toInt() < days.length) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Text(days[value.toInt()], style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      _makeBarData(0, 15),
                      _makeBarData(1, 10),
                      _makeBarData(2, 18),
                      _makeBarData(3, 14),
                      _makeBarData(4, 12),
                      _makeBarData(5, 8),
                      _makeBarData(6, 19),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _makeBarData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.primary,
          width: 16.w,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ],
    );
  }
}
