import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportData extends StatefulWidget {


  final String idAct;
  final int index;


  ReportData({Key key, @required this.idAct, this.index}) : super(key: key);

  @override
  _ReportDataState createState() => _ReportDataState();
}

class _ReportDataState extends State<ReportData> {

  Future<List> getData() async {
    var url = "https://o.sppetchz.com/project/selectUsername.php";
    final response = await http.post(url, body: {"id_act": widget.idAct});
    print(response.statusCode);

    return json.decode(response.body);
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
    //print("test"+widget.idAct);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ชื่อกิจกรรม"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: Container(
          child: new FutureBuilder<List>(
            future: getData(),
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
      ),
    );
  }
}
class buildROW extends StatelessWidget {
  List list;

  buildROW({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.only(left: 1,right: 1,top: 0,bottom: 0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Text(list[i]['firstname']),
                SizedBox(
                  width: 10,
                ),
                Text(list[i]['lastname']),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(list[i]['username']),
                Text(list[i]['program']),
              ],
            ),
          ),
        );
      },
    );
  }
}
