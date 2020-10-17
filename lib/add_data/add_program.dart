import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_qrcode/Page/student.dart';

class AddProgram extends StatefulWidget {
  @override
  _AddProgramState createState() => _AddProgramState();
}

class _AddProgramState extends State<AddProgram> {
  TextEditingController controllerprogram = new TextEditingController();
  TextEditingController controllersubject = new TextEditingController();
  void addprogram() {
    var url = "https://o.sppetchz.com/project/adddatapro.php";
    http.post(
      url,
      body: {
        "program": controllerprogram.text,
        "subject": _mysubject,
      },
    );
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
                  addprogram();
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

  @override
  void initState() {
    super.initState();
    this.getDataSubject();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มโปแแกรมวิชา"),
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
                                  value: _mysubject,
                                  iconSize: 30,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                  hint: Text('เลือกสาขา'),
                                  onChanged: (newVal) {
                                    setState(
                                      () {
                                        _mysubject = newVal;
                                        print(_mysubject);
                                      },
                                    );
                                  },
                                  items: datasubject.map((item) {
                                    return new DropdownMenuItem(
                                      child: new Text(item['subject']),
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
                    new TextFormField(
                      autofocus: true,
                      controller: controllerprogram,
                      decoration: new InputDecoration(
                        labelText: "เพิ่มโปรแกรมวิชา",
                        icon: Icon(Icons.account_circle),
                      ),
                      validator: _validatefname,
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

  // ignore: missing_return
  String _validatefname(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
  }
}
