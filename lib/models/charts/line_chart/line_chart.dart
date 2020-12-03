import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/models/charts/base_chart_data/basic_line_chart_data.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/line_chart_appearance_data.dart';
import 'file:///C:/Users/Tjerk_2/Desktop/Flutter-TestApp/lib/models/charts/chart_components/chart_data.dart';
import 'package:flutter_test_project/models/theme_scheme.dart';
import '../chart.dart';
import 'package:flutter_test_project/utility/utility.dart';
import 'line_spots.dart';
import 'package:json_annotation/json_annotation.dart';

part 'line_chart.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class LineChartGraph extends Chart {
  final double lineWidth;

  final Map<int, String> topTitles;
  final Map<int, String> bottomTitles;
  final Map<int, String> leftTitles;
  final Map<int, String> rightTitles;

  @JsonKey(fromJson: _spotsFromJson, toJson: _spotsToJson)
  final Map<int, List<FlSpot>> spots;
  @JsonKey(fromJson: _colorsFromJson, toJson: _colorsToJson)
  final Map<int, Color> colors;

  @JsonKey(ignore: true)
  LineChartAppearanceData data;

  static _spotsFromJson(Map<String, dynamic> spots) {
    return spots?.castTo<int, List<FlSpot>>(
      getValue: (value) => LineSpots.fromJson(value)?.spots,
    );
  }

  static _spotsToJson(Map<int, List<FlSpot>> spots) {
    return spots?.map(
      (k, e) => MapEntry(
        k.toString(),
        e.map((e) => [e.x, e.y]).toList(),
      ),
    );
  }

  static _colorsFromJson(Map<String, dynamic> colors) {
    return colors?.castTo<int, Color>(
      getValue: (value) => HexColor.fromHex(value),
    );
  }

  static _colorsToJson(Map<int, Color> colors) {
    return colors?.map(
      (k, e) => MapEntry(
        k.toString(),
        e.toHex(),
      ),
    );
  }

  LineChartGraph({
    String title,
    String subTitle,
    DateTime date,
    this.lineWidth = 8,
    this.topTitles = const {},
    this.bottomTitles = const {},
    this.leftTitles = const {},
    this.rightTitles = const {},
    this.spots = const {},
    Map<int, Color> colors,
  })  : colors = colors.isEmpty ? ThemeScheme.chartPalette.asMap() : colors,
        super(
          type: TileGroupType.LineChart,
          title: title,
          subTitle: subTitle,
          date: date,
        );

  void init(int singularSize) {
    this.data = LineChartAppearanceData(
      singularSize: singularSize,
    );
  }

  factory LineChartGraph.fromJson(
    Map<String, dynamic> json, {
    int singularSize,
  }) {
    LineChartGraph graph = _$LineChartGraphFromJson(json);
    graph.init(singularSize);
    return graph;
  }

  String toJson() => jsonEncode(_$LineChartGraphToJson(this));

  @override
  State<LineChartGraph> createState() => LineChartGraphState();
}

class LineChartGraphState extends State<LineChartGraph> {
  // bool isShowingMainData = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return AspectRatio(
      aspectRatio: 1.13,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //for stocks only
            AspectRatio(
              aspectRatio: widget.data.aspectRatio,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: ChartData(
                  data: LineChart(
                    BasicLineChartData(
                      gridData: FlGridData(
                        show: false,
                      ),
                      reservedSize: 22,
                      margin: 8,
                      topTitles: widget.topTitles,
                      bottomTitles: widget.bottomTitles,
                      leftTitles: widget.leftTitles,
                      rightTitles: widget.rightTitles,
                      minX: 0,
                      maxX: 14,
                      minY: 0,
                      maxY: 4,
                      spots: widget.spots,
                      colors: widget.colors,
                      lineWidth: widget.lineWidth,
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 2),
                          left: BorderSide(color: Colors.black, width: 2),
                          right: BorderSide(color: Colors.transparent),
                          top: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  title: widget.title,
                  subTitle: widget.subTitle,
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: IconButton(
            //     alignment: Alignment.topLeft,
            //     icon: Icon(
            //       Icons.refresh,
            //       color:
            //           Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
            //     ),
            //     onPressed: () {
            //       setState(() {
            //         isShowingMainData = !isShowingMainData;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
