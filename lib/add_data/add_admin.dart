import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_qrcode/Page/admin.dart';




class AddAdmin extends StatefulWidget {
  final List list;
  final int index;

  AddAdmin({
    this.list,
    this.index,
  });
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  TextEditingController controllerfirstname = new TextEditingController();
  TextEditingController controllerlastname = new TextEditingController();
  TextEditingController controllerusername = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  TextEditingController controllerlevel = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController controllerid_username = new TextEditingController();
  void addData() {
    var url = "https://o.sppetchz.com/project/adddataad.php";
    http.post(url, body: {
      "firstname": controllerfirstname.text,
      "lastname": controllerlastname.text,
      "username": controllerusername.text,
      "password": controllerpassword.text,
      "level": _mystatus,
    },
    );
  }
  final formKey = new GlobalKey<FormState>();
  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ข้อมูลของ..."),
            content: Text("เพิ่มข้อมูลเรียบร้อยแล้ว"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  addData();
                  Navigator.pop(context);
                  Navigator.of(context).pop(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new Admin(),
                    ),
                  );
                },
                child: Text("ยืนยัน"),
              ),
            ],
          );
        },
      );
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    this.getDataRevel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มผู้ดูแลกิจกรรม"),
      ),
      body: SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                new TextFormField(
                  autofocus: true,
                  controller: controllerfirstname,
                  decoration: new InputDecoration(
                    labelText: "ชื่อจริง",
                    icon: Icon(Icons.account_circle),
                  ),
                  validator: _validatefname,
                  maxLength: 24,
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  textInputAction: TextInputAction.send,
                  controller: controllerlastname,
                  decoration: new InputDecoration(
                    labelText: "นามสกุล",
                    icon: Icon(Icons.account_circle),
                  ),
                  maxLength: 24,
                  validator: _validatelname,
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  controller: controllerusername,
                  decoration: new InputDecoration(
                    labelText: "Username",
                    icon: Icon(Icons.person),
                  ),
                  validator: _validateusername,
                  maxLength: 16,
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(

                  controller: controllerpassword,
                  decoration: new InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.lock),
                  ),
                  validator: _validatepassword,
                  obscureText: true,
                  maxLength: 16,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(

                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _mystatus,
                              iconSize: 30,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text('หน่วยงานที่รับผิดชอบ'),
                              onChanged: (newVal) {
                                setState(
                                      () {
                                    _mystatus = newVal;
                                    print(_mystatus);
                                  },
                                );
                              },
                              items: datastatus.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['level']),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                new RaisedButton(
                  child: new Text(
                    "ตกลง",
                    style: new TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: _submit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _validateusername(String value) {
    if (value.isEmpty) {
      return "บัญชีผู้ใช้ว่าง";
    }
    return null;
  }

  String _validatepassword(String value) {
    if (value.isEmpty) {
      return "รหัสผ่านว่าง";
    }
    if (value.length < 8) {
      return "โปรดสร้างหรัสผ่านมากกว่า 8 ";
    }
    return null;
  }

  String _validatefname(String value) {
    if (value.isEmpty) {
      return "ข้อมูลชื่อจริงว่าง";
    }
    return null;
  }

  String _validatelname(String value) {
    if (value.isEmpty) {
      return "ข้อมูลนามสกุลว่าง";
    }
    return null;
  }


  List statusList;
  String _mystatus;
  final String url = "https://o.sppetchz.com/project/getdatalevel.php";
  List datastatus = List();

  Future<String> getDataRevel() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      datastatus = resBody;
    });
    print(resBody);
    return "Sucess";
  }


}
