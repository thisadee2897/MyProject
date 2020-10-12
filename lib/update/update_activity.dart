import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_qrcode/Page/activity.dart';


class UpdateActivity extends StatefulWidget {
  final List list;
  final int index;

  UpdateActivity({
    this.list,
    this.index,
  });
  @override
  _UpdateActivityState createState() => _UpdateActivityState();
}
class _UpdateActivityState extends State<UpdateActivity> {
  TextEditingController controllerid_act ;
  TextEditingController controlleract_name ;
  TextEditingController controllerunit ;
  TextEditingController controllerStartTime ;
  TextEditingController controllerEndTime ;


  void editactivity() {
    var url = "https://o.sppetchz.com/project/editdataactivitys.php";
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "id_act": controllerid_act.text,
      "act_name": controlleract_name.text,
      "unit": controllerunit.text,
      "type": _mytypes,
      "agency": _myagency,
      "StartTime": controllerStartTime.text,
      "EndTime": controllerStartTime.text,

    },
    );
  }


  void deleteData() {
    var url = "https://o.sppetchz.com/project/deleteactivity.php";
    http.post(url, body: {'id': widget.list[widget.index]['id'],
      'id_act': widget.list[widget.index]['id_act']},

    );
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: new Text("sure '${widget.list[widget.index]['act_name']}'"),
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
                  editactivity();
                  Navigator.pop(context);
                  Navigator.of(context).pop(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new Activitys(),
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
    controllerStartTime = new TextEditingController(text: widget.list[widget.index]['StartTime']);
    controllerEndTime = new TextEditingController(text: widget.list[widget.index]['EndTime']);
    controllerid_act = new TextEditingController(text: widget.list[widget.index]['id_act']);
    controlleract_name = new TextEditingController(text: widget.list[widget.index]['act_name']);
    controllerunit = new TextEditingController(text: widget.list[widget.index]['unit']);

    super.initState();
    this.getDataagency();
    this.getDatatype();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("อัพเดตกิจกรรม"),
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
                  controller: controllerid_act,
                  decoration: new InputDecoration(
                    labelText: "ไอดีกิจกรรม",
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
                ),new TextFormField(
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
                              value: _myagency,
                              iconSize: 30,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text(widget.list[widget.index]['agency']),
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
                              value: _mytypes,
                              iconSize: 30,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint:Text(widget.list[widget.index]['type']),
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
      floatingActionButton: IconButton(
        highlightColor: Colors.red,
        icon: Icon(Icons.delete),
        onPressed: () => confirm(),
      ),
    );
  }
  String _validatedate(String value) {
    if (value.isEmpty) {
      return "ว่าง";
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
