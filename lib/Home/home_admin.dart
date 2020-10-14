import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("สวัสดี SAY HAI"),
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
                Icons.bug_report,
                'จัดการข้อมูลกิจกรรม',
                    () => {Navigator.pushNamed(context, '/activitys')},
              ),
              CustomListTitle(
                Icons.bug_report,
                'ปฏิทินกิจกรรม',
                    () => {Navigator.pushNamed(context, '/calendar')},
              ),
              CustomListTitle(
                Icons.bug_report,
                'รายงานผลการเข้าร่วมกิจกรรม',
                    () => {Navigator.pushNamed(context, '/reportactivity')},
              ),
              CustomListTitle(
                Icons.bug_report,
                'สร้าง คิวอาโค๊ต กิจกรรม',
                    () => {Navigator.pushNamed(context, '/add_qrcode')},
              ),
              CustomListTitle(
                Icons.settings,
                'เปลี่ยนรหัสผ่าน',
                    () => {Navigator.pushNamed(context, '/changpassword')},
              ),
            ],
          ),
        ),
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
