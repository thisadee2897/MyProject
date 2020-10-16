import 'package:flutter/material.dart';
import 'package:my_qrcode/Page/activitted.dart';
import 'package:my_qrcode/editemyprofile.dart';
import 'package:my_qrcode/scan.dart';

class HomeStudent extends StatefulWidget {
  final String username;

  HomeStudent({Key key, @required this.username}) : super(key: key);

  @override
  _HomeStudentState createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {
  @override
  void initState() {
    //   print(widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สวัสดีนักศึกษา"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (Route<dynamic> route) => false);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                CustomListTitle(
                  Icons.data_usage,
                  'แก้ไขข้อมูลส่วนตัว',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditMyProflie(username: widget.username),
                    ),
                  ),
                ),
                CustomListTitle(
                  Icons.data_usage,
                  'เข้าร่วมกิจกรรม',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scan(username: widget.username),
                    ),
                  ),
                ),
                CustomListTitle(
                  Icons.data_usage,
                  'ผลการเข้าร่วมกิจกรรม',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Activitted(username: widget.username),
                    ),
                  ),
                ),
                CustomListTitle(
                  Icons.data_usage,
                  'ปฏิทินกิจกรรม',
                      () => {Navigator.pushNamed(context, '/calendar')},
                ),
              ],
            )),
      ),
    );
  }
}

class CustomListTitle extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTitle(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    //todo implemant build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Colors.blue,
          onTap: onTap,
          child: Container(
            height: 66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
