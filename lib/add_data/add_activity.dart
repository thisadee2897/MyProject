import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_qrcode/Page/admin.dart';




class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  TextEditingController controllerid_activity = new TextEditingController();
  TextEditingController controlleract_name = new TextEditingController();
  TextEditingController controllertype = new TextEditingController();
  TextEditingController controlleragengy = new TextEditingController();
  TextEditingController controllerunit = new TextEditingController();
  TextEditingController controllerexpdate = new TextEditingController();
  TextEditingController controllercreatedate = new TextEditingController();
  TextEditingController controllerStartTime = new TextEditingController();
  TextEditingController controllerEndTime = new TextEditingController();
  void addactivity() {
    var url = "https://o.sppetchz.com/project/adddataact.php";
    http.post(url, body: {
      "id_act": controllerid_activity.text,
      "act_name": controlleract_name.text,
      "type": _mytypes,
      "agency": _myagency,
      "unit": controlleract_name.text,
      "StartTime": controllerStartTime.text,
      "EndTime": controllerStartTime.text,
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
                  addactivity();
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
    this.getDataagency();
    this.getDatatype();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มกิจกรรม"),
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
                  autovalidate: true,
                  controller: controllerid_activity,
                  decoration: new InputDecoration(
                    labelText: "สร้างไอดีกิจกรรม",
                    icon: Icon(Icons.account_circle),
                  ),
                  validator: _validatefname,
                  maxLength: 16,
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  textInputAction: TextInputAction.send,
                  autovalidate: true,
                  controller: controlleract_name,
                  decoration: new InputDecoration(
                    labelText: "ชื่อกิจกรรม",
                    icon: Icon(Icons.account_circle),
                  ),
                  maxLength: 36,
                  validator: _validatelname,
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  autovalidate: true,
                  controller: controllerunit,
                  decoration: new InputDecoration(
                    labelText: "จำนวนหน่วย",
                    icon: Icon(Icons.person),
                  ),
                  validator: _validateusername,
                  maxLength: 16,
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  autofocus: true,
                  autovalidate: true,
                  controller: controllerStartTime,
                  decoration: new InputDecoration(
                    labelText: "วันที่เริ่มจัดกิจกรรม",
                    hintText: "ปปปป-ดด-ววT08:30:00",
                    icon: Icon(Icons.account_circle),
                  ),
                  validator: _validatedate,
                  maxLength: 19,
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  autofocus: true,
                  autovalidate: true,
                  controller: controllerEndTime,
                  decoration: new InputDecoration(
                    labelText: "วันที่สิ้นสุดกิจกรรม",
                    hintText: "ปปปป-ดด-ววT12:30:00",
                    icon: Icon(Icons.account_circle),
                  ),
                  validator: _validatedate,
                  maxLength: 19,
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
                              value: _myagency,
                              iconSize: 30,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text('หน่วยงานที่รับผิดชอบ'),
                              onChanged: (newVal) {
                                setState(
                                      () {
                                    _myagency = newVal;
                                    print(_myagency);
                                  },
                                );
                              },
                              items: dataagency.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['agency']),
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
                              value: _mytypes,
                              iconSize: 30,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text('ประเภท'),
                              onChanged: (newVal) {
                                setState(
                                      () {
                                    _mytypes = newVal;
                                    print(_mytypes);
                                  },
                                );
                              },
                              items: datatypes.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['damage']),
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
  String _validatedate(String value) {
    if (value.isEmpty) {
      return "วันที่ว่าง";
    }
    return null;
  }

  String _validateusername(String value) {
    if (value.isEmpty) {
      return "บัญชีผู้ใช้ว่าง";
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
  List agencyList;
  String _myagency;
  final String url1 = "https://o.sppetchz.com/project/getdataagency.php";
  List dataagency = List();

  Future<String> getDataagency() async {
    var res = await http
        .get(Uri.encodeFull(url1), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      dataagency = resBody;
    });
    print(resBody);
    return "Sucess";
  }
  List typesList;
  String _mytypes;
  final String url = "https://o.sppetchz.com/project/getdatadamage.php";
  List datatypes = List();

  Future<String> getDatatype() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      datatypes = resBody;
    });
    print(resBody);
    return "Sucess";
  }


}
