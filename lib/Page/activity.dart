import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:my_qrcode/update/update_activity.dart';

class Activitys extends StatefulWidget {
  @override
  _ActivitysState createState() => _ActivitysState();
}

class _ActivitysState extends State<Activitys> {
  Future<List> getData2() async {
    final response =
        await http.get("https://o.sppetchz.com/project/getdataactivitys.php");
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
        title: Text("กิจกรรม"),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () {
                  Navigator.pushNamed(context, '/add_activity');
                },
              ),
            ],
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    onChanged: (String text) {},
                    controller: null,
                    decoration: InputDecoration(
                      hintText: "ค้นหา",
                      contentPadding: const EdgeInsets.only(left: 24),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _search();
                  })
            ],
          ),
        ),
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
              Text(list[i]['act_name'],overflow: TextOverflow.ellipsis,),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(list[i]['id_act']),
              Text(list[i]['type']),
              Text(list[i]['agency']),
            ],
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context) => UpdateActivity(
                list: list,
                index: i,
              ),
            ),
          ),
        );
      },
    );
  }
}
