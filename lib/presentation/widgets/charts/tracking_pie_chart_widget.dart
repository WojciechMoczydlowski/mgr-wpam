import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/tracker/tracker_cubit.dart';
import 'package:wpam_app/utils/get_color_from_hex.dart';

var pieData = [
  PieChartItem("youtube", "Youtube", 2, getColorFromHex("#123321")),
  PieChartItem("Facebook", "Facebook", 4, getColorFromHex("#432142")),
  PieChartItem("Work", "Praca", 8, getColorFromHex("#FFFaab")),
  PieChartItem("Rest", "Odpoczynek", 2, getColorFromHex("#889432")),
];

class TrackingPieChartWidget extends StatefulWidget {
  const TrackingPieChartWidget({Key? key}) : super(key: key);

  @override
  State<TrackingPieChartWidget> createState() => _TrackingPieChartWidgetState();
}

class _TrackingPieChartWidgetState extends State<TrackingPieChartWidget> {
  final List<charts.Series<PieChartItem, String>> _seriesPieData =
      <charts.Series<PieChartItem, String>>[];

  @override
  void initState() {
    super.initState();

    _seriesPieData.add(
      charts.Series(
          data: pieData,
          domainFn: (PieChartItem item, _) => item.label,
          measureFn: (PieChartItem item, _) => item.period,
          colorFn: (PieChartItem item, _) =>
              charts.ColorUtil.fromDartColor(item.color),
          id: "Your daily activity",
          labelAccessorFn: (PieChartItem item, _) => '${item.period}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerCubit, TrackerState>(
      builder: (context, state) {
        // const pieData = mkPieData();

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(children: <Widget>[
              const Text("Czas spędzony na dziennych czynnościach"),
              Expanded(
                  child: charts.PieChart<String>(
                _seriesPieData,
                animate: true,
                animationDuration: const Duration(seconds: 2),
                behaviors: [
                  charts.DatumLegend(
                      outsideJustification:
                          charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 2,
                      cellPadding:
                          const EdgeInsets.only(right: 4.0, bottom: 4.0),
                      entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.purple.shadeDefault,
                        fontSize: 11,
                      ))
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
      },
    );
  }
}

class PieChartItem {
  String id;
  String label;
  double period;
  Color color;

  PieChartItem(this.id, this.label, this.period, this.color);
}
