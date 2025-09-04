import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class MonthlyChart extends StatelessWidget {
  final List<double> data;
  final List<String> months;

  const MonthlyChart({
    super.key,
    required this.data,
    required this.months,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(
          data.length,
          (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: data[index],
                color: Colors.blue.shade600,
                width: 20,
              ),
            ],
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  months[value.toInt()],
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '\$${(value / 1000000).toStringAsFixed(0)}M',
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }
}
