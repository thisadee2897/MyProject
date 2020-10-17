import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_qrcode/Page/student.dart';


class AddSubject extends StatefulWidget {
  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  TextEditingController controllersubject = new TextEditingController();
  TextEditingController controllerbord = new TextEditingController();
  void addsubject() {
    var url = "https://o.sppetchz.com/project/adddatasub.php";
    http.post(
      url,
      body: {
        "subject": controllersubject.text,
        "board": _myboard,
      },
    );
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
                  addsubject();
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
    this.getDataBoard();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มสาขา"),
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
                                  value: _myboard,
                                  iconSize: 30,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                  hint: Text('เลือกคณะ'),
                                  onChanged: (newVal) {
                                    setState(
                                          () {
                                        _myboard = newVal;
                                        print(_myboard);
                                      },
                                    );
                                  },
                                  items: databoard.map((item) {
                                    return new DropdownMenuItem(
                                      child: new Text(item['board']),
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
                      controller: controllersubject,
                      decoration: new InputDecoration(
                        labelText: "เพิ่มสาขา",
                        icon: Icon(Icons.account_circle),
                      ),
                      validator: _validatefname,
                      maxLength: 36,
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
