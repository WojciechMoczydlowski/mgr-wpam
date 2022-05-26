import 'package:flutter/material.dart';

class TrackingDatePickerWidget extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onChange;

  const TrackingDatePickerWidget(
      {Key? key, required this.date, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2050));

              if (newDate == null) return;

              onChange(newDate);
            },
            child: Text('Wybrana data: ${date.year}-${date.month}-${date.day}'))
      ],
    );
  }
}
