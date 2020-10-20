import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/painting.dart';

class Pie extends PieChartSectionData {
  Pie({
    int index,
    bool isTouched,
    Color color,
    double value,
    String title = '',
    double pieRadius,
  }) : super(
          color: color.withOpacity(isTouched ? 1 : 0.6),
          value: value,
          title: title,
          radius: isTouched ? pieRadius * 1.2 : pieRadius,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          titlePositionPercentageOffset: 0.55,
        );
}
