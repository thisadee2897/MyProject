import 'package:flutter/material.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("ระบบกิจกรรมนักศึกษา"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (Route<dynamic> route) => false);
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              CustomListTitle(
                Icons.data_usage,
                'จัดการข้อมูลนักศึกษา',
                () => {Navigator.pushNamed(context, '/student')},
              ),
              CustomListTitle(
                Icons.account_circle,
                'จัดการข้อมูลผู้ดูแลระบบ',
                () => {Navigator.pushNamed(context, '/admin')},
              ),
              CustomListTitle(
                Icons.card_travel,
                'จัดการข้อมูลสาขา',
                () => {Navigator.pushNamed(context, '/section')},
              ),
              CustomListTitle(
                Icons.assignment,
                'จัดการข้อมูลโปรแกรม',
                () => {Navigator.pushNamed(context, '/program')},
              ),
              CustomListTitle(
                Icons.account_tree_outlined,
                'จัดการข้อมูลกิจกรรม',
                () => {Navigator.pushNamed(context, '/activitys')},
              ),
              CustomListTitle(
                Icons.calendar_today,
                'ปฏิทินกิจกรรม',
                () => {Navigator.pushNamed(context, '/calendar')},
              ),
              CustomListTitle(
                Icons.workspaces_outline,
                'รายงานผลการเข้าร่วมกิจกรรม',
                () => {Navigator.pushNamed(context, '/reportactivity')},
              ),
              CustomListTitle(
                Icons.qr_code_scanner_rounded,
                'สร้าง คิวอาโค๊ต กิจกรรม',
                () => {Navigator.pushNamed(context, '/add_qrcode')},
              ),
            ],
          ),
        ),
      ),

    );
  }
}

// ignore: must_be_immutable
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
          onTap: onTap,
          child: Container(
            height: 66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
