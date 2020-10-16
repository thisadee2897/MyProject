import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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


  List<StudentsModel> listModel =[];

  TextEditingController controllerfirstname;
  TextEditingController controllerlastname;
  TextEditingController controllerid_card;


  Future<Null> getData() async {
    var url = "https://o.sppetchz.com/project/editpro.php";
    final response =
    await http.post(url,
        body: {"username": widget.username});
    print(response.statusCode);
    final data = jsonDecode(response.body);

    setState(() {
      for(Map map in data){
        listModel.add(StudentsModel.fromJson(map));
      }
      //print("test" +listModel[0].fName);
      controllerfirstname = new TextEditingController(text: listModel[0].fName);
      controllerlastname = new TextEditingController(text: listModel[0].lName);
      controllerid_card = new TextEditingController(text: listModel[0].idCard);
    });
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
        title: Text("แก้ไขข้อมูลส่วนตัว"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: Container(

          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  ),
                  _buildLoginBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class StudentsModel{
  final String fName;
  final String lName;
  final String idCard;
  StudentsModel(this.fName, this.lName, this.idCard);

  StudentsModel.fromJson(Map<String,dynamic> json):
        fName=json["firstname"],
        lName=json["lastname"],
        idCard=json["id_card"];
}



Widget _buildLoginBtn() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () {},
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
  );
}






