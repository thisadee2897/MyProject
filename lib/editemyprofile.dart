import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_qrcode/Home/home_student.dart';

class EditMyProflie extends StatefulWidget {
  final String username;
  EditMyProflie({Key key, @required this.username}) : super(key: key);

  @override
  _EditMyProflieState createState() => _EditMyProflieState();
}

class _EditMyProflieState extends State<EditMyProflie> {
  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
    );
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }

  List<StudentsModel> listModel = [];

  TextEditingController controllerfirstname;
  TextEditingController controllerlastname;
  TextEditingController controllerid_card;
  void editData() {
    var url = "https://o.sppetchz.com/project/edithomestudent.php";
    http.post(
      url,
      body: {
        "username": widget.username,
        "firstname": controllerfirstname.text,
        "lastname": controllerlastname.text,
        "id_card": controllerid_card.text,
      },
    ).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });
  }

  Future<Null> getData() async {
    var url = "https://o.sppetchz.com/project/editpro.php";
    final response = await http.post(url, body: {"username": widget.username});
    print(response.statusCode);
    final data = jsonDecode(response.body);

    setState(() {
      for (Map map in data) {
        listModel.add(StudentsModel.fromJson(map));
      }
      //print("test" +listModel[0].fName);
      controllerfirstname = new TextEditingController(text: listModel[0].fName);
      controllerlastname = new TextEditingController(text: listModel[0].lName);
      controllerid_card = new TextEditingController(text: listModel[0].idCard);
    });
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
            title: Row(
              children: [
                Text("ข้อมูลของ"),
                Text(widget.username),
              ],
            ),
            content: Text("แก้ไขข้อมูลเรียบร้อยแล้ว"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  editData();
                  Navigator.pop(context);
                  Navigator.of(context).pop(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new HomeStudent(),
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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: controllerfirstname,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        filled: true,
                        icon: Icon(Icons.person),
                        hintText: 'กรอกชื่อ',
                        labelText: 'ขื่อจริง',

                      ),
                      onSaved: (String value) {
                        //this.f_name = value;
                      },
                      validator: _validatefname,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: controllerlastname,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        filled: true,
                        icon: Icon(Icons.person),
                        hintText: 'กรอกนามสกุล',
                        labelText: 'นามสกุล',
                      ),
                      onSaved: (String value) {
                        // this.l_name = value;
                      },
                      validator: _validatelname,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: controllerid_card,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        filled: true,
                        icon: Icon(Icons.credit_card),
                        hintText: 'xxxxxxxxxxxxx',
                        labelText: 'เลขบัตรประชาชน',
                      ),
                      onSaved: (String value) {
                        //this.id_card = value;
                      },
                      validator: _validateid_card,
                      maxLength: 13,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: _submit,
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Color(0xFF527DAA),
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  String _validatelname(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
  }
  String _validatefname(String value) {
    if (value.isEmpty) {
      return "ว่าง";
    }
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
}

class StudentsModel {
  final String fName;
  final String lName;
  final String idCard;
  StudentsModel(this.fName, this.lName, this.idCard);

  StudentsModel.fromJson(Map<String, dynamic> json)
      : fName = json["firstname"],
        lName = json["lastname"],
        idCard = json["id_card"];
}
