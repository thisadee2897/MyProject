import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:my_qrcode/update/update_subject.dart';


class Subject extends StatefulWidget {

  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  Future<List> getData() async {
    final response = await http.get(
      "https://o.sppetchz.com/project/getdatasubject.php",
    );

    return json.decode(response.body);
  }

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

  _search() async {}
  @override
  @override
  void initState() {
    super.initState();
    this.refreshList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สาขา"),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  Navigator.pushNamed(context, '/add_subject');
                },
              ),
            ],
          )
        ],
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
        return SingleChildScrollView(
          child: ListTile(
            title: Text(list[i]['subject'],overflow: TextOverflow.ellipsis,),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => UpdateSubject(
                  list: list,
                  index: i,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
