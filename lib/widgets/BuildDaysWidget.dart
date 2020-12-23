import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'MyCircularProgress.dart';

class BuildWidgetDays extends StatefulWidget {

   ValueChanged onSelectedDate;

   BuildWidgetDays({this.onSelectedDate});

  @override
  _BuildWidgetDaysState createState() => _BuildWidgetDaysState();
}

class _BuildWidgetDaysState extends State<BuildWidgetDays> {
  Color themeColor = Get.theme.accentColor;

  List<String> dayName = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<String> monthName = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];


  List<DateTime> dateList = [];

  DateTime _selectedDay;
  DateTime afterDate;
  DateTime beforeDate;
  bool isLoading = true;
  final scrollDirection = Axis.horizontal;

  AutoScrollController _scrollController;
  ControllerChange _controllerChange = Get.put(ControllerChange());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = _controllerChange.selectedDay.value;
    beforeDate =
        DateTime(_selectedDay.year, _selectedDay.month - 6, _selectedDay.day);
    afterDate =
        DateTime(_selectedDay.year, _selectedDay.month + 6, _selectedDay.day);
    int indexDate = _selectedDay.difference(beforeDate).inDays;

    _scrollController = AutoScrollController(
        initialScrollOffset: (indexDate * 85).toDouble(),
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      buildDays();
      await _scrollController.scrollToIndex(indexDate,
          preferPosition: AutoScrollPosition.middle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MyCircular()
        : Container(
            height: 70,
            child: ListView(
              scrollDirection: scrollDirection,
              controller: _scrollController,
              children: [
                ...List.generate(dateList.length, (index) {
                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: _scrollController,
                    index: index,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          int indexDate =
                              dateList[index].difference(dateList[0]).inDays;
                          await _scrollController.scrollToIndex(indexDate,
                              preferPosition: AutoScrollPosition.middle);
                          _controllerChange.updateSelectedDate(dateList[index]);
                          setState(() {
                            _selectedDay = dateList[index];
                          });
                        },
                        child: isSameDate(dateList[index], _selectedDay)
                            ? Container(
width: 60,
                          padding: EdgeInsets.only(left: 5, right: 5),

                              decoration: BoxDecoration(
                                color: themeColor,
                                border: Border.all(

                                    width: 1, color: themeColor),
                                borderRadius: BorderRadius.circular(12),

                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dayName[dateList[index].weekday - 1],
                                    style: TextStyle(fontSize: 16,color: Colors.white),
                                  ), Text(
                                    dateList[index].day.toString(),
                                    style: TextStyle(fontSize: 16,color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                            : Container(
                          width: 60,

                          padding: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(

                                    width: 1, color: themeColor),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    dayName[dateList[index].weekday - 1],
                                    style: TextStyle(fontSize: 16),
                                  ), Text(
                                    dateList[index].day.toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),

                            ),
                      ),
                    ),
                    highlightColor: Colors.black.withOpacity(0.1),
                  );
                })
              ],
            ),
          );
  }

  void buildDays() {
    while (beforeDate.isBefore(afterDate)) {
      dateList.add(beforeDate);
      beforeDate =
          DateTime(beforeDate.year, beforeDate.month, beforeDate.day + 1);
    }

    setState(() {
      isLoading = false;
    });
  }

  String buildStringDate(DateTime date) {
    return date.year.toString() +
        "." +
        date.month.toString() +
        "." +
        date.day.toString();
  }

  bool isSameDate(DateTime other, DateTime date) {
    return date.year == other.year &&
        date.month == other.month &&
        date.day == other.day;
  }
}
