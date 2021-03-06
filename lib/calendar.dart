import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

class calendar extends StatefulWidget {
  @override
  _calendarState createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ปฎิทินกิจกรรม"),
      ),
      body: OnlineJsonData(),
    );
  }
}

class OnlineJsonData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarExample();
}

class CalendarExample extends State<OnlineJsonData> {
  DateTime myDateTime = DateTime.now();

  List<Color> _colorCollection;
  String _networkStatusMsg;
  @override
  void initState() {
    _initializeEventColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getDataFromWeb(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            DateTime myDateTime = DateTime.now();
            if (snapshot.data != null) {
              return SafeArea(
                child: Container(
                  child: SfCalendar(
                    view: CalendarView.month,
                    initialDisplayDate: DateTime(myDateTime.year,
                        myDateTime.month, myDateTime.day, 0, 0, 0),
                    dataSource: MeetingDataSource(snapshot.data),
                    monthViewSettings: MonthViewSettings(
                      showAgenda: true,
                      agendaViewHeight: 200,
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text('$_networkStatusMsg'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Meeting>> getDataFromWeb() async {
    var data =
        await http.get("https://o.sppetchz.com/project/getdataactivitys.php");
    var jsonData = json.decode(data.body);

    final List<Meeting> appointmentData = [];
    final Random random = new Random();
    for (var data in jsonData) {
      Meeting meetingData = Meeting(
          eventName: data['act_name'],
          from: _convertDateFromString(
            data['StartTime'],
          ),
          to: _convertDateFromString(data['EndTime']),
          background: _colorCollection[random.nextInt(9)],
          allDay: false);
      appointmentData.add(meetingData);
    }
    return appointmentData;
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }

  void _initializeEventColor() {
    this._colorCollection = new List<Color>();
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].allDay;
  }
}

class Meeting {
  Meeting(
      {this.eventName,
      //this.act_name,
      this.from,
      this.to,
      this.background,
      this.allDay = false});

  String eventName;
  //String act_name;
  DateTime from;
  DateTime to;
  Color background;
  bool allDay;
}
