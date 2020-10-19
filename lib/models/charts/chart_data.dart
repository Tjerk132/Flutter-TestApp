import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartData extends StatefulWidget {
  final AxisChartData data;
  final String title;
  final String subTitle;
  final Duration animDuration;

  ChartData({
    Key key,
    @required this.data,
    this.title = 'Title',
    this.subTitle = 'subTitle',
    this.animDuration = const Duration(milliseconds: 250),
  }) : super(key: key);

  @override
  State<ChartData> createState() => _ChartDataState();
}

class _ChartDataState extends State<ChartData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.zero,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.subTitle,
              style: TextStyle(
                color: Color(0xff827daa),
                // fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Padding(
          //todo only set padding to 15 if small group else to zero
          padding: EdgeInsets.zero,
          // padding: EdgeInsets.only(left: 15.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                // fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(2.0),
            //todo make usable for all types of charts
            child: widget.data is LineChartData
                ? LineChart(
                    widget.data,
                    swapAnimationDuration: widget.animDuration,
                  )
                : BarChart(
                    widget.data,
                    swapAnimationDuration: widget.animDuration,
                  ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }
}