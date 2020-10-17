import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:my_qrcode/Page/activitted.dart';
import 'package:my_qrcode/Page/activitypeport.dart';
import 'package:my_qrcode/Page/reportdata.dart';

import 'Home/home_admin.dart';
import 'Home/home_student.dart';
import 'Page/activity.dart';
import 'Page/admin.dart';
import 'Page/program.dart';
import 'Page/student.dart';
import 'Page/subject.dart';
import 'add_data/add_activity.dart';
import 'add_data/add_admin.dart';
import 'add_data/add_program.dart';
import 'add_data/add_qrcode.dart';
import 'add_data/add_student.dart';
import 'add_data/add_subject.dart';
import 'calendar.dart';
import 'changpassword.dart';
import 'editemyprofile.dart';
import 'login.dart';
import 'scan.dart';
import 'update/update_activity.dart';
import 'update/update_admin.dart';
import 'update/update_program.dart';
import 'update/update_student.dart';
import 'update/update_subject.dart';

void main() {
  Intl.defaultLocale = "th";
  initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _route = <String, WidgetBuilder>{
    '/edit_myprofile': (context) => EditMyProflie(),
    '/login': (context) => Login(),
    '/home_admin': (context) => home(),
    '/home_student': (context) => HomeStudent(),
    '/student': (context) => Student(),
    '/admin': (context) => Admin(),
    '/section': (context) => Subject(),
    '/program': (context) => Program(),
    '/activitys': (context) => Activitys(),
    '/changpassword': (context) => ChangPassword(),
    '/add_student': (context) => AddStudent(),
    '/add_admin': (context) => AddAdmin(),
    '/add_activity': (context) => AddActivity(),
    '/add_subject': (context) => AddSubject(),
    '/add_program': (context) => AddProgram(),
    '/add_qrcode': (context) => AddQRcode(),
    '/update_student': (context) => UpdateStudent(),
    '/update_admin': (context) => UpdateAdmin(),
    '/update_subject': (context) => UpdateSubject(),
    '/update_program': (context) => UpdateProgram(),
    '/update_activity': (context) => UpdateActivity(),
    // ignore: missing_required_param
    '/home_student': (context) => HomeStudent(),
    '/signup': (context) => AddStudent(),
    // ignore: missing_required_param
    '/scan': (context) => Scan(),
    '/calendar': (context) => calendar(),
    '/activitted': (context) => Activitted(),
    '/reportactivity': (context) => Report(),
    '/reportdata': (context) => ReportData(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: _route,
    );
  }
}
