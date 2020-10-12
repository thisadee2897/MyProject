import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_qrcode/Page/admin.dart';



class UpdateProgram extends StatefulWidget {
  final List list;
  final int index;

  UpdateProgram({
    this.list,
    this.index,
  });

  @override
  UpdateProgramState createState() => UpdateProgramState();
}

class UpdateProgramState extends State<UpdateProgram> {
  TextEditingController controllersubject ;
  TextEditingController controllerprogram ;

  void editsubject() {
    var url = "https://o.sppetchz.com/project/editdataprogram.php";
    http.post(
      url,
      body: {
        "id": widget.list[widget.index]['id'],
        "subject": _mysubject,
        "program": controllerprogram.text
      },
    );
  }

  void deleteData() {
    var url = "https://o.sppetchz.com/project/deleteprogram.php";
    http.post(url, body: {'id': widget.list[widget.index]['id']},

    );
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: new Text("sure '${widget.list[widget.index]['program']}'"),
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
                  editsubject();
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
    controllerprogram = new TextEditingController(text: widget.list[widget.index]['program']);

    super.initState();
    this.getDataSubject();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แก้ไขโปรแกรมวิชา"),
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
                    new TextFormField(
                      autofocus: true,
                      autovalidate: true,
                      controller: controllerprogram,
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
      floatingActionButton: IconButton(
        highlightColor: Colors.red,
        icon: Icon(Icons.delete),
        onPressed: () => confirm(),
      ),
    );
  }



  String _validatefname(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
  }
}
