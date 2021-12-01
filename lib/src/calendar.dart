import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scs_project/users/custom_user.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:scs_project/src/globals.dart';

class Calendar extends StatefulWidget {
  final CustomUser user;

  const Calendar({Key? key, required this.user}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime now = DateTime.now();
  final CalendarController _controller = CalendarController();

  int _viewIndex = 0;
  late CustomUser _currentUser;
  String _value = "";

  @override
  void initState() {
    _currentUser = widget.user;
    _value = _currentUser.getGroup.toString();
    super.initState();
  }

  final List<CalendarView> _views = [
    CalendarView.day,
    CalendarView.workWeek,
    CalendarView.month
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.change_history_sharp),
          onPressed: () {
            setState(() {
              if (_viewIndex == 2) {
                _viewIndex = 0;
              } else {
                _viewIndex++;
              }
              _controller.view = _views[_viewIndex];
            });
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SfCalendar(
              controller: _controller,
              view: CalendarView.day,
              dataSource: getCalendarDataSource(int.parse(_value)),
              todayHighlightColor: Colors.cyan,
              cellBorderColor: Colors.black,
              showWeekNumber: true,
              firstDayOfWeek: 1,
              showNavigationArrow: true,
              initialDisplayDate: DateTime(now.year, now.month, now.day, 7, 30),
              showCurrentTimeIndicator: true,
              timeSlotViewSettings: const TimeSlotViewSettings(
                  startHour: 7,
                  endHour: 22,
                  nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday]),
            ),
          ),
          DropdownButton(
            value: _value,
            onChanged: (String? newValue) {
              setState(() {
                _value = newValue!;
              });
            },
            items: <String>[
              1.toString(),
              2.toString(),
              3.toString(),
              4.toString()
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
