import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'Page/slip.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

class Scan extends StatefulWidget {
  final String username;

  Scan({Key key, @required this.username}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  GlobalKey globalKey = GlobalKey();
  var vBool=false;
  String qrCodeResult=" " ;
  List<dataModel> listModel = [];
  String username;
  String fName;
  String lName;
  String program;
  String act_name;
  String unit;
  String damage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _requestPermission();
    getData();
  }

  Future<Null> getData() async {
    var url = "https://o.sppetchz.com/project/selectSlip.php";
    final response = await http
        .post(url, body: {"username": widget.username, "id_act": qrCodeResult});
    print(response.statusCode);
    final data = jsonDecode(response.body);
    print("test" + data.toString());

    setState(() {
      for (Map map in data) {
        listModel.add(dataModel.fromJson(map));
      }
      username = listModel[0].fName.toString();
      act_name = listModel[0].act_name.toString();
      damage = listModel[0].damage.toString();
      fName = listModel[0].fName.toString();
      lName = listModel[0].lName.toString();
      unit = listModel[0].unit.toString();
      program = listModel[0].program.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.share), onPressed: shared),
        // ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Visibility(
                visible: vBool,
                child: RepaintBoundary(
                  key: globalKey,
                  child: CreditCardsPage(
                    username: fName,
                    act_name: act_name,
                    damage: damage,
                    fName: fName,
                    lName: lName,
                    unit: unit,
                    program: program,
                  ),
                ),
              ),
              Text(
                qrCodeResult,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  String codeSanner =
                  (await BarcodeScanner.scan()) as String; //barcode scnner
                  setState(() {
                    capture();
                    qrCodeResult = codeSanner;
                    sendScan(qrCodeResult);
                    vBool =true;

                  });
                },
                child: Text(
                  "SCAN QR CODE",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildTitleSection({@required title, @required subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            '$title',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            '$subTitle',
            style: TextStyle(fontSize: 21, color: Colors.black45),
          ),
        )
      ],
    );
  }

  void sendScan(String qrCodeResult) {
    print(widget.username);
    var url = "https://o.sppetchz.com/project/InsertScan.php";
    http.post(
      url,
      body: {
        "id_act": qrCodeResult,
        "username": widget.username,
      },
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

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    final info = statuses[Permission.storage].toString();
    print(info);
    _toastInfo(info);
  }

  _toastInfo(String info) {
    print("$info");
    // Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  void capture() async {
    RenderRepaintBoundary boundary =
    globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 1);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result =
    await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    print(result);
    _toastInfo(result.toString());
  }
}

class dataModel {
  final String fName;
  final String lName;
  final String program;
  final String act_name;
  final String unit;
  final String damage;

  dataModel(this.fName, this.lName, this.program, this.act_name, this.unit,
      this.damage);

  dataModel.fromJson(Map<String, dynamic> json)
      : fName = json["firstname"],
        lName = json["lastname"],
        program = json["program"],
        act_name = json["act_name"],
        unit = json["unit"],
        damage = json["damage"];
}
