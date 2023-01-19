import 'package:flutter/material.dart';
import 'package:reflect_application/datetime/date_time.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;
  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(122, 228, 213, 230),
          2: Color.fromARGB(121, 173, 122, 177),
          3: Color.fromARGB(122, 171, 108, 177),
          4: Color.fromARGB(121, 154, 86, 160),
          5: Color.fromARGB(122, 148, 60, 156),
          6: Color.fromARGB(122, 101, 26, 107),
          7: Color.fromARGB(122, 81, 13, 87),
          8: Color.fromARGB(123, 77, 6, 84),
          9: Color.fromARGB(123, 122, 19, 131),
          10: Color.fromARGB(117, 77, 6, 84),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
