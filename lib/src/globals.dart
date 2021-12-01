import 'package:flutter/material.dart';
import 'package:scs_project/src/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

MaterialColor materialColor = Colors.blue;
Color secondaryColor = Colors.white;
Color textColor = Colors.blue;
const Text title = Text('WebSynu v2.76');
int NULL_ERROR = -10;

//Calendar vars
Color _courseColor = Colors.grey;
Color _labColorS1 = Colors.teal;
Color _labColorS2 = Colors.red;
Duration _normalCourse = const Duration(hours: 2);

void computeDates(List<dynamic> _monDates, Duration _normalCourse) {
  for (int i = 27; i < 31; i++) {
    List<dynamic> _dates = <dynamic>[];
    for (int j = 8; j < 20; j += 2) {
      _dates.add(DateTime(DateTime.now().year, DateTime.september, i, j));
    }
    _monDates.add(_dates);
  }

  List<dynamic> _dates = <dynamic>[];
  for (int i = 8; i < 20; i += 2) {
    _dates.add(DateTime(DateTime.now().year, DateTime.october, 1, i));
  }
  _monDates.add(_dates);

  List<dynamic> _datesOdd = <dynamic>[];
  _datesOdd.add(DateTime(DateTime.now().year, DateTime.october, 5, 10));
  _datesOdd.add(DateTime(DateTime.now().year, DateTime.october, 8, 10));
  _datesOdd.add(DateTime(DateTime.now().year, DateTime.october, 6, 10));
  _monDates.add(_datesOdd);
}

DataSource getCalendarDataSource(int group) {
  List<dynamic> _monDates = <dynamic>[];
  List<dynamic> _appList = <dynamic>[];

  computeDates(_monDates, _normalCourse);

  _appList.add(computeGroup1(_monDates, _appList));
  _appList.add(computeGroup2(_monDates, _appList));
  _appList.add(computeGroup3(_monDates, _appList));
  _appList.add(computeGroup4(_monDates, _appList));

  return DataSource(_appList[group - 1]);
}

List<Appointment> computeGroup1(
    List<dynamic> _monDates, List<dynamic> _appList) {
  List<Appointment> _group1 = <Appointment>[];

  addAppointment("SE Course", 0, 1, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);
  addAppointment("DMP Course", 0, 2, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);

  addAppointment("SCS Lab", 1, 0, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);
  addAppointment("None", 1, 0, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);

  addAppointment("SCS Project Lab", 1, 1, _labColorS1,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group1, _normalCourse);
  addAppointment("None", 1, 1, Colors.transparent,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group1, _normalCourse);
  addAppointment("None", 5, 0, Colors.transparent,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group1, _normalCourse);
  addAppointment("SCS Project Lab", 5, 0, _labColorS2,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group1, _normalCourse);

  addAppointment("FP Course", 1, 3, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);

  addAppointment("GP Lab", 2, 2, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);
  addAppointment("DMP Lab", 2, 2, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);

  addAppointment("DMP Lab", 2, 3, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);
  addAppointment("GP Lab", 2, 3, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);

  addAppointment("AI Course", 3, 0, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);
  addAppointment("GP Course", 3, 1, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);
  addAppointment("SCS Course", 3, 2, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);

  addAppointment("None", 3, 4, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);
  addAppointment("SCS Lab", 3, 4, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);

  addAppointment("AI Lab", 4, 2, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);
  addAppointment("None", 4, 2, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);

  addAppointment("SE Lab", 4, 3, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);
  addAppointment("AI Lab", 4, 3, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);

  addAppointment("FP Lab", 4, 4, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);
  addAppointment("SE Lab", 4, 4, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);

  addAppointment("None", 4, 5, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group1, _normalCourse);
  addAppointment("FP Lab", 4, 5, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group1, _normalCourse);

  return _group1;
}

List<Appointment> computeGroup2(
    List<dynamic> _monDates, List<dynamic> _appList) {
  List<Appointment> _group2 = <Appointment>[];
  addAppointment("None", 0, 0, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);
  addAppointment("SE Lab", 0, 0, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);

  addAppointment("SE Course", 0, 1, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);
  addAppointment("DMP Course", 0, 2, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);

  addAppointment("AI Lab", 1, 0, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);
  addAppointment("None", 1, 0, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);

  addAppointment("SE Lab", 1, 1, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);
  addAppointment("FP Lab", 1, 1, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);

  addAppointment("FP Lab", 1, 2, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);
  addAppointment("AI Lab", 1, 2, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);

  addAppointment("FP Course", 1, 3, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);

  addAppointment("GP Lab", 2, 4, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);
  addAppointment("DMP Lab", 2, 4, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);

  addAppointment("DMP Lab", 2, 5, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);
  addAppointment("GP Lab", 2, 5, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);

  addAppointment("AI Course", 3, 0, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);
  addAppointment("GP Course", 3, 1, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);
  addAppointment("SCS Course", 3, 2, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);

  addAppointment("SCS Lab", 4, 0, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);
  addAppointment("None", 4, 0, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);

  addAppointment("SCS Project Lab", 4, 1, _labColorS1,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group2, _normalCourse);
  addAppointment("None", 4, 1, Colors.transparent,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group2, _normalCourse);
  addAppointment("None", 5, 1, Colors.transparent,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group2, _normalCourse);
  addAppointment("SCS Project Lab", 5, 1, _labColorS2,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group2, _normalCourse);

  addAppointment("None", 4, 2, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group2, _normalCourse);
  addAppointment("SCS Lab", 4, 2, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group2, _normalCourse);

  return _group2;
}

List<Appointment> computeGroup3(
    List<dynamic> _monDates, List<dynamic> _appList) {
  List<Appointment> _group3 = <Appointment>[];

  addAppointment("SE Course", 0, 1, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);
  addAppointment("DMP Course", 0, 2, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);

  addAppointment("SE Lab", 0, 3, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);
  addAppointment("None", 0, 3, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);

  addAppointment("AI Lab", 1, 1, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);
  addAppointment("None", 1, 1, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);

  addAppointment("None", 1, 2, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);
  addAppointment("SE Lab", 1, 2, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);

  addAppointment("FP Course", 1, 3, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);

  addAppointment("SCS Lab", 2, 0, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);
  addAppointment("None", 2, 0, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);

  addAppointment("SCS Project Lab", 2, 1, _labColorS1,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group3, _normalCourse);
  addAppointment("None", 2, 1, Colors.transparent,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group3, _normalCourse);
  addAppointment("None", 5, 2, Colors.transparent,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group3, _normalCourse);
  addAppointment("SCS Project Lab", 5, 2, _labColorS2,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group3, _normalCourse);

  addAppointment("None", 2, 2, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);
  addAppointment("SCS Lab", 2, 2, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);

  addAppointment("None", 2, 3, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);
  addAppointment("AI Lab", 2, 3, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);

  addAppointment("GP Lab", 2, 4, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);
  addAppointment("DMP Lab", 2, 4, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);

  addAppointment("AI Course", 3, 0, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);
  addAppointment("GP Course", 3, 1, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);
  addAppointment("SCS Course", 3, 2, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);

  addAppointment("DMP Lab", 4, 1, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);
  addAppointment("None", 4, 1, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group3, _normalCourse);

  addAppointment("GP Lab", 4, 2, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);
  addAppointment("DMP Lab", 4, 2, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);

  addAppointment("FP Lab", 4, 3, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);
  addAppointment("GP Lab", 4, 3, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group3, _normalCourse);

  return _group3;
}

List<Appointment> computeGroup4(
    List<dynamic> _monDates, List<dynamic> _appList) {
  List<Appointment> _group4 = <Appointment>[];

  addAppointment("SE Course", 0, 1, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);
  addAppointment("DMP Course", 0, 2, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);

  addAppointment("FP Course", 1, 3, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);

  addAppointment("SCS Lab", 2, 0, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);
  addAppointment("None", 2, 0, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);

  addAppointment("SCS Project Lab", 2, 1, _labColorS1,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group4, _normalCourse);
  addAppointment("None", 2, 1, Colors.transparent,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group4, _normalCourse);
  addAppointment("None", 5, 2, Colors.transparent,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group4, _normalCourse);
  addAppointment("SCS Project Lab", 5, 2, _labColorS2,
      'FREQ=DAILY;INTERVAL=14;COUNT=7', _monDates, _group4, _normalCourse);

  addAppointment("SE Lab", 2, 5, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);
  addAppointment("AI Lab", 2, 5, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);

  addAppointment("AI Course", 3, 0, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);
  addAppointment("GP Course", 3, 1, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);
  addAppointment("SCS Course", 3, 2, _courseColor,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);

  addAppointment("None", 3, 5, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);
  addAppointment("SCS Lab", 3, 5, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);

  addAppointment("FP Lab", 3, 3, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);
  addAppointment("None", 3, 3, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);

  addAppointment("AI Lab", 4, 0, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);
  addAppointment("None", 4, 0, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);

  addAppointment("None", 4, 1, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);
  addAppointment("FP Lab", 4, 1, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);

  addAppointment("None", 4, 2, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);
  addAppointment("SE Lab", 4, 2, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);

  addAppointment("DMP Lab", 4, 3, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);
  addAppointment("None", 4, 3, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);

  addAppointment("GP Lab", 4, 4, _labColorS1, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);
  addAppointment("DMP Lab", 4, 4, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);

  addAppointment("None", 4, 5, Colors.transparent,
      'FREQ=DAILY;INTERVAL=7;COUNT=14', _monDates, _group4, _normalCourse);
  addAppointment("GP Lab", 4, 5, _labColorS2, 'FREQ=DAILY;INTERVAL=7;COUNT=14',
      _monDates, _group4, _normalCourse);

  return _group4;
}

void addAppointment(
    String title,
    int day,
    int hour,
    Color color,
    String freq,
    List<dynamic> _monDates,
    List<Appointment> appointments,
    Duration _normalCourse) {
  appointments.add(Appointment(
    startTime: _monDates[day][hour],
    endTime: _monDates[day][hour].add(_normalCourse),
    subject: title,
    color: color,
    recurrenceRule: freq,
  ));
}

List<BottomNavigationBarItem> bottomNavItems = const [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
    backgroundColor: Colors.blueGrey,
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_today),
    label: 'Calendar',
    backgroundColor: Colors.green,
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.school),
    label: 'School',
    backgroundColor: Colors.purple,
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Settings',
    backgroundColor: Colors.pink,
  ),
];
