
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_qrcode/Page/admin.dart';

class UpdateAdmin extends StatefulWidget {
  final List list;
  final int index;

  UpdateAdmin({
    this.list,
    this.index,
  });
  @override
  _UpdateAdminState createState() => _UpdateAdminState();
}

class _UpdateAdminState extends State<UpdateAdmin> {
  TextEditingController controllerfirstname;
  TextEditingController controllerlastname;
  TextEditingController controllerusername;
  TextEditingController controllerpassword;
  void editData() {
    var url = "https://o.sppetchz.com/project/editdataadmin.php";
    http.post(
      url,
      body: {
        "id": widget.list[widget.index]['idadmin'],
        "firstname": controllerfirstname.text,
        "lastname": controllerlastname.text,
        "username": controllerusername.text,
        "password": controllerpassword.text,
        "level": _mystatus,
      },
    ).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });

    print(widget.list[widget.index]['idadmin']);
  }

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

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ข้อมูลของ..."),
            content: Text("แก้ไขข้อมูลเรียบร้อยแล้ว"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  editData();
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

  void deleteData() {
    var url = "https://o.sppetchz.com/project/deleteDataad.php";
    http.post(url, body: {'id': widget.list[widget.index]['idadmin'],
      "username": widget.list[widget.index]['username']},

    );
  }


  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: new Text("sure '${widget.list[widget.index]['firstname']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: Text("ok"),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Navigator.pop(context);
            Navigator.pop(context, '/admin');
          },
        ),
        RaisedButton(
          child: Text("no"),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  final formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    controllerfirstname = new TextEditingController(text: widget.list[widget.index]['firstname']);
    controllerlastname = new TextEditingController(text: widget.list[widget.index]['lastname']);
    controllerusername = new TextEditingController(text: widget.list[widget.index]['username']);
    controllerpassword = new TextEditingController(text: widget.list[widget.index]['password']);
    super.initState();
    this.getDataRevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("อัพเดตผู้ดูแลกิจกรรม"),
      ),
      body: Container(
        child: new Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  autovalidate: true,
                  controller: controllerfirstname,
                  decoration: InputDecoration(
                    labelText: "ชื่อจริง",
                    icon: Icon(Icons.account_circle),
                  ),
                  validator: _validatefname,
                  maxLength: 24,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidate: true,
                  controller: controllerlastname,
                  decoration: InputDecoration(
                    labelText: "นามสกุล",
                    icon: Icon(Icons.account_circle),
                  ),
                  maxLength: 24,
                  validator: _validatelname,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidate: true,
                  controller: controllerusername,
                  decoration: InputDecoration(
                    labelText: "Username",
                    icon: Icon(Icons.person),
                  ),
                  validator: _validateusername,
                  maxLength: 16,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidate: true,
                  controller: controllerpassword,
                  decoration: InputDecoration(
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
                            child: DropdownButton(
                              autofocus: true,
                              items: datastatus.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item['level']),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              hint: Text((widget.list[widget.index]['level']),),
                              onChanged: (newVal) {
                                setState(
                                      () {
                                    _mystatus = newVal;
                                    print(_mystatus);
                                  },
                                );
                              },
                              value: _mystatus,
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                RaisedButton(
                  child: new Text(
                    "ตกลง",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: _submit,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: IconButton(
        highlightColor: Colors.red,
        icon: Icon(Icons.delete),
        onPressed: () => confirm(),
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
}
