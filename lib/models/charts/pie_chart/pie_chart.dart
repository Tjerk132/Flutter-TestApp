import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/pie_chart_appearance_data.dart';
import 'package:flutter_test_project/models/charts/pie_chart/center_progress_indicator.dart';
import 'package:flutter_test_project/models/charts/pie_chart/indicators.dart';
import 'package:flutter_test_project/models/theme_scheme.dart';
import 'package:flutter_test_project/utility/utility.dart';
import '../chart.dart';
import '../chart_components/chart_data.dart';
import '../base_chart_data/basic_pie_chart_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pie_chart.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class PieChartGraph extends Chart {
  final List<double> values;
  final List<String> indicatorText;
  @JsonKey(fromJson: _colorsFromJson, toJson: _colorsToJson)
  final List<Color> sectionColors;

  @JsonKey(ignore: true)
  PieChartAppearanceData data;

  static _colorsFromJson(List<dynamic> colors) {
    return colors?.castTo<Color>(
      getValue: (value) => HexColor.fromHex(value),
    );
  }

  static _colorsToJson(List<Color> colors) {
    return colors?.map((c) => c.toHex())?.toList();
  }

  PieChartGraph({
    String title,
    this.values = const [],
    this.indicatorText = const [],
    List<Color> sectionColors,
  })  : sectionColors =
            sectionColors.isEmpty ? ThemeScheme.chartPalette : sectionColors,
        super(
          type: ChartType.PieChart,
          title: title,
        );

  void init(PieChartType type, int singularSize) {
    this.data = PieChartAppearanceData(
      type: type,
      singularSize: singularSize,
    );
  }

  factory PieChartGraph.fromJson(
    Map<String, dynamic> json, {
    PieChartType type = PieChartType.divided,
    int singularSize,
  }) {
    PieChartGraph graph = _$PieChartGraphFromJson(json);
    graph.init(type, singularSize);
    return graph;
  }

  String toJson() => jsonEncode(_$PieChartGraphToJson(this));

  @override
  State<PieChartGraph> createState() => PieChartGraphState();
}

class PieChartGraphState extends State<PieChartGraph> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Flex(
        direction: widget.data.axis,
        children: <Widget>[
          Indicators(
            indicatorSize: widget.data.indicatorSize,
            fontSize: widget.data.fontSize,
            type: widget.data.type,
            indicatorText: widget.indicatorText,
            sectionColors: widget.sectionColors,
            title: widget.title,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ChartData(
                    PieChart(
                      BasicPieChartData(
                        sectionColors: widget.sectionColors,
                        values: widget.values,
                        pieRadius: widget.data.pieRadius,
                        fontSize: widget.data.fontSize,
                        showPieTitle: widget.data.showPieTitle,
                        sectionsSpace: widget.data.sectionSpace,
                        centerSpaceRadius: widget.data.centerSpaceRadius,
                        startDegreeOffset: 180,
                        borderData: FlBorderData(
                          show: false,
                        ),
                      ),
                    ),
                    showTitle: false,
                  ),
                  widget.data.centerProgressIndicator
                      ? CenterProgressIndicator(
                          value: widget.values[0],
                          style: TextStyle(
                            fontSize: widget.data.fontSize * 2,
                            color: widget.sectionColors[0],
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
