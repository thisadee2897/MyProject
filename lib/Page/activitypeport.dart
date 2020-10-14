import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  Future<List> getData2() async {
    final response =
        await http.get("https://o.sppetchz.com/project/getdataactivitys.php");
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
        title: Text('ผลกิจกรรม'),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: Container(
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
        return ListTile(
          title: Row(
            children: <Widget>[
              Text(list[i]['act_name']),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(list[i]['agency']),
            ],
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.pushNamed(context, '/reportdata');
          },
          // onTap: () => Navigator.of(context).push(
          //   new MaterialPageRoute(
          //     builder: (BuildContext context) => ReportData(
          //       list: list,
          //       index: i,
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
