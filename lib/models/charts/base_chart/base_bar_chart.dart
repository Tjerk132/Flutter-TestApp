import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

class BaseBarChart with BaseChart {
  BarTouchData touchData(
    List<String> barTouchTooltipData, {
    TextStyle toolTipStyle,
    Color tooltipBgColor,
  }) {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: tooltipBgColor,
        fitInsideVertically: true,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          // int x = group.x.toInt();
          // String tooltip = barTouchTooltipData[x];
          return BarTooltipItem(
            //'$tooltip\n${rod.y}'
            rod.y.toString(),
            toolTipStyle,
          );
        },
      ),
    );
  }

  List<BarChartGroupData> barGroups(
    List<double> barValues,
    double barWidth,
    int rodCount,
    int singularSize, {
    Color rodColor = Colors.yellowAccent,
    Color backgroundColor,
    BorderRadius rodBorderRadius,
    bool showBackGround = true,
  }) {
    double width = singularSize + (barWidth / rodCount);
    List<BarChartGroupData> bars = new List<BarChartGroupData>();
    for (int i = 0; i < barValues.length; ++i) {
      int x = i;
      double y = barValues.getOrElse(i, null);
      bars.add(
        new BarChartGroupData(
          x: x,
          barRods: List<BarChartRodData>.generate(
            rodCount,
            (i) => createRod(
              y,
              barValues.highest.roundToFactor(10).toDouble(),
              width: width,
              color: rodColor,
              backgroundColor: backgroundColor,
              borderRadius: rodBorderRadius,
              showBackGround: showBackGround,
            ),
          ),
        ),
      );
    }
    return bars;
  }

  BarChartRodData createRod(
    double y,
    double backDrawRodDataY, {
    double width,
    Color color,
    Color backgroundColor = const Color(0xff72d8bf),
    BorderRadius borderRadius = BorderRadius.zero,
    bool showBackGround,
  }) {
    return BarChartRodData(
      y: y,
      color: color,
      width: width,
      borderRadius: borderRadius,
      backDrawRodData: showBackGround
          ? BackgroundBarChartRodData(
              show: true,
              y: backDrawRodDataY,
              color: backgroundColor,
            )
          : BackgroundBarChartRodData(),
    );
  }
}
