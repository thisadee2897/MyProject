import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_qrcode/Page/student.dart';

class UpdateStudent extends StatefulWidget {
  final List list;
  final int index;

  UpdateStudent({
    this.list,
    this.index,
  });
  @override
  _UpdateStudentState createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  TextEditingController controllerfirstname;
  TextEditingController controllerlastname;
  TextEditingController controllerid_card;
  TextEditingController controllerusername;
  TextEditingController controllerstudy;
  TextEditingController controllerboard;
  TextEditingController controllersubject;
  TextEditingController controllerprogram;
  TextEditingController controllerpass;


  void editData() {


    var url = "https://o.sppetchz.com/project/editdatastudent.php";
    http.post(
      url,
      body: {
        "id": widget.list[widget.index]['id_username'],
        "id_card": controllerid_card.text.toString(),
        "firstname": controllerfirstname.text.toString(),
        "lastname": controllerlastname.text.toString(),
        "study": _mystudy,
        "board": _myboard,
        "subject": _mysubject,
        "program": _myprogram,
        "password" : controllerpass.text.toString(),
        "username" : controllerusername.text.toString(),
        "level" : "1",
      },

    ).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });

    print("istest"+ _myprogram);
  }
  void deletestudent() {
    var url = "https://o.sppetchz.com/project/deletestudent.php";
    http.post(url,
        body: {'id': widget.list[widget.index]['id_username'],
        }).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });
    print("delete"+widget.list[widget.index]['id_username']);
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
                  editData();
                  Navigator.pop(context);
                  Navigator.of(context).pop(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new Student(),
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
  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: new Text("ลบ'${widget.list[widget.index]['username']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: Text("ok"),
          color: Colors.red,
          onPressed: () {
            deletestudent();

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

  @override
  void initState() {
    controllerfirstname = new TextEditingController(text: widget.list[widget.index]['firstname']);
    controllerlastname = new TextEditingController(text: widget.list[widget.index]['lastname']);
    // controllerusername = new TextEditingController(text: widget.list[widget.index]['id_username']);
    controllerid_card = new TextEditingController(text: widget.list[widget.index]['id_card']);
    controllerusername = new TextEditingController(text: widget.list[widget.index]['username']);
    controllerpass = new TextEditingController(text: widget.list[widget.index]['password']);
    this.getDataRevel();
    this.getDataStudy();
    this.getDataBoard();
    this.getDataSubject();
    this.getDataProgram();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(( widget.list[widget.index]['username']),),
        actions: <Widget>[IconButton(icon:Icon(Icons.delete), onPressed: ()=> confirm(),)],
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
                      autofocus: true,
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
                                  autofocus: true,
                                  items: datastudy.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['study']),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  hint: Text((widget.list[widget.index]['study']),),
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
                                  autofocus: true,
                                  items: databoard.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['board']),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  hint: Text(widget.list[widget.index]['board']),
                                  onChanged: (newVal) {
                                    setState(
                                          () {
                                        _myboard = newVal;
                                        selectsubject(_myboard);
                                        print(_myboard);
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
                                  autofocus: true,
                                  items: datasubject.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['subject']),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  hint: Text(widget.list[widget.index]['subject']),
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
                                  autofocus: true,
                                  items: dataprogram.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['program']),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  hint: Text(widget.list[widget.index]['program']),
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
                    TextFormField(
                      autovalidate: true,
                      controller: controllerpass,
                      decoration: InputDecoration(
                        labelText: "Password",
                        icon: Icon(Icons.lock),
                      ),
                      validator: _validatepassword,
                      obscureText: true,
                      maxLength: 16,
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
  String _mystatus;
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

  String _validateid_card(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
    if (value.length < 13) {
      return "กรอกข้อมูลให้ครบถ้วน";
    }
    return null;
  }

  String _validateid_student(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
    if (value.length < 13) {
      return "กรอกข้อมูลให้ครบถ้วน";
    }
    return null;
  }

  String _validatefname(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
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

  String _validatelname(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
  }

  void selectboard(String idstudy) {
    var url = "https://o.sppetchz.com/project/selectboard.php";
    http.post(
      url,
      body: {
        "id": idstudy
      },

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
      body: {
        "id": idsubject
      },

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
      body: {
        "id": idsubject
      },

    ).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${json.decode(response.body)}");

      setState(() {
        dataprogram = json.decode(response.body);

      });


    });
  }
}
