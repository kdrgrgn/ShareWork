import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController;
  Color themeColor = Get.theme.accentColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendar"),
        ),
        body: SfCalendar(
          showDatePickerButton: true,
          showNavigationArrow: true,
          allowedViews: [CalendarView.month,CalendarView.week,CalendarView.day],
          controller: _calendarController,
          view: CalendarView.month,
        ));
  }
}
