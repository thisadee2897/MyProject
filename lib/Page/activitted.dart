import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Activitted extends StatefulWidget {
  final String username;

  Activitted({Key key, @required this.username}) : super(key: key);

  @override
  _ActivittedState createState() => _ActivittedState();
}

class _ActivittedState extends State<Activitted> {
  GlobalKey globalKey = GlobalKey();
  List<ActivityModel> listModel = [];
  var sum = "0";

  Future<Null> getData() async {
    var url = "https://o.sppetchz.com/project/selectActivity.php";
    final response = await http.post(url, body: {"username": widget.username});
    print(response.statusCode);
    final data = jsonDecode(response.body);

    setState(() {
      for (Map map in data) {
        listModel.add(ActivityModel.fromJson(map));
      }
      if (listModel.length != 0) {
        print(listModel[listModel.length - 1].sum.toString());
        sum = listModel[listModel.length - 1].sum.toString();
      }
    });
  }

  Future<List> getData2() async {
    var url = "https://o.sppetchz.com/project/selectActivity.php";
    final response = await http.post(url, body: {"username": widget.username});
    print(response.statusCode);
    final data = jsonDecode(response.body);
    return data;
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    setState(() {});

    return null;
  }

  @override
  void initState() {
    getData();
    print(widget.username);
    super.initState();
    this.refreshList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(widget.username),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: shared),
        ],
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: SafeArea(
          child: SingleChildScrollView(
            child: RepaintBoundary(
              key: globalKey,
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "หน่วยกิจสะสม",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              sum,
                              style: TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "หน่วย",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    color: Colors.blue.shade800,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "กิจกรรม",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                ('ประเภท'),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                ("หน่วย"),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 600,
                    // height: double.maxFinite,
                    // width: double.infinity,
                    child: new FutureBuilder<List>(
                      future: getData2(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? new buildROW(
                                list: snapshot.data,
                              )
                            : new Center(
                                child: new CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future shared() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      final channel = MethodChannel('cm.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }
}

class ActivityModel {
  final String actName;
  final String type;
  final String unit;
  final int sum;

  ActivityModel(this.actName, this.type, this.unit, this.sum);

  ActivityModel.fromJson(Map<String, dynamic> json)
      : actName = json["act_name"],
        type = json["damage"],
        unit = json["unit"],
        sum = json["sum"];
}

class buildROW extends StatefulWidget {
  List list = [];

  buildROW({this.list});

  @override
  _buildROWState createState() => _buildROWState();
}

class _buildROWState extends State<buildROW> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white10),
            ),
          ),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.list[i]['act_name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (widget.list[i]['damage']),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      (widget.list[i]['unit']),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
