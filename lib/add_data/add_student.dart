import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../login.dart';


class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  // ignore: non_constant_identifier_names
  TextEditingController controllerid_card = new TextEditingController();
  TextEditingController controllerfirstname = new TextEditingController();
  TextEditingController controllerlastname = new TextEditingController();
  TextEditingController controllerusername = new TextEditingController();
  TextEditingController controllerstudy = new TextEditingController();
  TextEditingController controllerboard = new TextEditingController();
  TextEditingController controllersubject = new TextEditingController();
  TextEditingController controllerprogram = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  TextEditingController controllerlevel = new TextEditingController();
  void addData() {
    var url = "https://o.sppetchz.com/project/adddatast.php";
    http.post(
      url,
      body: {
        "id_card": controllerid_card.text,
        "firstname": controllerfirstname.text,
        "lastname": controllerlastname.text,
        "study": _mystudy,
        "board": _myboard,
        "subject": _mysubject,
        "program": _myprogram,
        "username": controllerusername.text,
        "password": controllerpassword.text,
      },
    );
  }


  List studyList;
  String _mystudy;
  final String url1 = "https://o.sppetchz.com/project/getdatastudy.php";
  List datastudy = List();

  Future<String> getDataStudy() async {
    var res = await http
        .get(Uri.encodeFull(url1), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      datastudy = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  List boardList;
  String _myboard;
  final String url2 = "https://o.sppetchz.com/project/getdataboard.php";
  List databoard = List();
  Future<String> getDataBoard() async {
    var res = await http
        .get(Uri.encodeFull(url2), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      databoard = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  List subjectList;
  String _mysubject;
  final String url3 = "https://o.sppetchz.com/project/getdatasubject.php";
  List datasubject = List();

  Future<String> getDataSubject() async {
    var res = await http
        .get(Uri.encodeFull(url3), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      datasubject = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  List programList;
  String _myprogram;
  final String url4 = "https://o.sppetchz.com/project/getdataprogram.php";
  List dataprogram = List();

  Future<String> getDataProgram() async {
    var res = await http
        .get(Uri.encodeFull(url4), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      dataprogram = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  List revelList;
  final String url5 = "https://o.sppetchz.com/project/getdatalevel.php";
  List datastatus = List();

  Future<String> getDataRevel() async {
    var res = await http
        .get(Uri.encodeFull(url5), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      datastatus = resBody;
    });
    print(resBody);
    return "Sucess";
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
                      builder: (BuildContext context) => new Login(),
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
    this.getDataStudy();
//    this.getDataBoard();
//    this.getDataSubject();
//    this.getDataProgram();
//    this.getDataRevel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มนักศึกษา"),
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new TextFormField(

                      // ignore: deprecated_member_use
                      autovalidate: true,
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
                      // ignore: deprecated_member_use
                      autovalidate: true,
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
                      // ignore: deprecated_member_use
                      autovalidate: true,
                      controller: controllerid_card,
                      decoration: new InputDecoration(
                        labelText: "เลขบัตรประชาชน",
                        icon: Icon(Icons.person),
                      ),
                      validator: _validateid_card,
                      maxLength: 13,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new TextFormField(
                      // ignore: deprecated_member_use
                      autovalidate: true,
                      controller: controllerusername,
                      decoration: new InputDecoration(
                        labelText: "รหัสนักศึกษา",
                        icon: Icon(Icons.lock),
                      ),
                      validator: _validateid_student,
                      maxLength: 13,
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
                                  isExpanded: true,
                                  items: datastudy.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['study']),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  hint: Text('ระดับการศึกษา'),
                                  onChanged: (newVal) {
                                    setState(
                                          () {
                                        _mystudy = newVal;
                                        selectboard(_mystudy);
                                        print(_mystudy);
                                      },
                                    );
                                  },
                                  value: _mystudy,
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
                                  isExpanded: true,
                                  items: databoard.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['board']),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  hint: Text('คณะ'),
                                  onChanged: (newVal) {
                                    setState(
                                          () {
                                        _myboard = newVal;
                                        selectsubject(_myboard);
                                        print("subject" + _myboard);
                                      },
                                    );
                                  },
                                  value: _myboard,
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
                                  isExpanded: true,
                                  items: datasubject.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['subject']),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  hint: Text('สาขา'),
                                  onChanged: (newVal) {
                                    setState(
                                          () {
                                        _mysubject = newVal;
                                        selectprogram(_mysubject);
                                        print(_mysubject);
                                      },
                                    );
                                  },
                                  value: _mysubject,
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
                                  isExpanded: true,
                                  items: dataprogram.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['program']),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  hint: Text('โปรแกรม'),
                                  onChanged: (newVal) {
                                    setState(
                                          () {
                                        _myprogram = newVal;
                                        print(_myprogram);
                                      },
                                    );
                                  },
                                  value: _myprogram,
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
                    new TextFormField(
                      // ignore: deprecated_member_use
                      autovalidate: true,
                      controller: controllerpassword,
                      decoration: new InputDecoration(
                        labelText: "สร้างรหัสผ่าน",
                        icon: Icon(Icons.account_circle),
                      ),
                      maxLength: 16,
                      obscureText: true,
                      validator: _validatepassword,
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
        ),
      ),
    );

  }

  // ignore: non_constant_identifier_names
  String _validateid_card(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
    if (value.length < 13) {
      return "กรอกข้อมูลให้ครบถ้วน";
    }
    return null;
  }

  // ignore: non_constant_identifier_names
  String _validateid_student(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
    if (value.length < 13) {
      return "กรอกข้อมูลให้ครบถ้วน";
    }
    return null;
  }

  // ignore: missing_return
  String _validatefname(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
  }

  // ignore: missing_return
  String _validatelname(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
  }

  // ignore: missing_return
  String _validatepassword(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
    if (value.length < 8) {
      return "กรอกข้อมูลให้ครบถ้วน";
    }
  }
  void selectstudy(String idboard) {
    var url = "https://o.sppetchz.com/project/selectboard.php";
    http.post(
      url,
      body: {"id": idboard},
    ).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${json.decode(response.body)}");

      setState(() {
        databoard = json.decode(response.body);
      });
    });
  }
  void selectboard(String idboard) {
    var url = "https://o.sppetchz.com/project/selectboard.php";
    http.post(
      url,
      body: {"id": idboard},
    ).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${json.decode(response.body)}");

      setState(() {
        databoard = json.decode(response.body);
      });
    });
  }

  void selectsubject(String idsubject) {
    var url = "https://o.sppetchz.com/project/selectsubject.php";
    http.post(
      url,
      body: {"id": idsubject},
    ).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${json.decode(response.body)}");

      setState(() {
        datasubject = json.decode(response.body);
      });
    });
  }

  void selectprogram(String idsubject) {
    var url = "https://o.sppetchz.com/project/selectprogram.php";
    http.post(
      url,
      body: {"id": idsubject},
    ).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${json.decode(response.body)}");

      setState(() {
        dataprogram = json.decode(response.body);
      });
    });
  }
}
