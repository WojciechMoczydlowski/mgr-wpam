import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TrackingPieChartWidget extends StatelessWidget {
  final List<charts.Series<PieChartItem, String>> _seriesPieData =
      <charts.Series<PieChartItem, String>>[];

  final List<PieChartItem> data;

  TrackingPieChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text("Brak danych"));
    }

    _seriesPieData.add(
      charts.Series(
          data: data,
          domainFn: (PieChartItem item, _) => item.label,
          measureFn: (PieChartItem item, _) => (item.period / 60),
          colorFn: (PieChartItem item, _) =>
              charts.ColorUtil.fromDartColor(item.color),
          id: "Your daily activity",
          labelAccessorFn: (PieChartItem item, _) => '${item.period}'),
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(children: <Widget>[
          Expanded(
              child: charts.PieChart<String>(
            _seriesPieData,
            animate: true,
            animationDuration: const Duration(seconds: 2),
            behaviors: [
              charts.DatumLegend(
                outsideJustification: charts.OutsideJustification.startDrawArea,
                horizontalFirst: true,
                desiredMaxRows: 4,
                cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
              )
            ],
            defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 100,
                arcRendererDecorators: [
                  charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.inside)
                ]),
          ))
        ]),
      ),
    );
  }
}

class PieChartItem {
  String id;
  String label;
  int period;
  String categoryId;
  Color color;

  PieChartItem(this.id, this.label, this.period, this.color, this.categoryId);
}
