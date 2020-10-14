import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportData extends StatefulWidget {
  // final List list;
  // final int index;
  //
  // ReportData({
  //   this.list,
  //   this.index,
  // });
  @override
  _ReportDataState createState() => _ReportDataState();
}

class _ReportDataState extends State<ReportData> {
  Future<List> getData() async {
    final response =
        await http.get("https://o.sppetchz.com/project/getdatastudent.php");
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
