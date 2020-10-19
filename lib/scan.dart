import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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
  var vBool = false;
  String qrCodeResult = " ";

  List<dataModel> listModel = [];
  String fName;
  String lName;
  String program;
  String act_name;
  String unit;
  String damage;
  String subject;

  @override
  void initState() {
    super.initState();

    _requestPermission();
  }

  Future<Null> getData(String codeSanner) async {
    var url = "https://o.sppetchz.com/project/selectSlip.php";
    print(codeSanner);
    final response = await http
        .post(url, body: {"username": widget.username, "id_act": codeSanner});
    print(response.statusCode);
    final data = jsonDecode(response.body);

    for (Map map in data) {
      print("getData0 $map");
      listModel.add(dataModel.fromJson(map));
      setState(() {
        act_name = map['act_name'].toString();
        damage = map['damage'].toString();
        fName = map['firstname'].toString();
        lName = map['lastname'].toString();
        unit = map['unit'].toString();
        program = map['program'].toString();
        subject =map['subject'].toString();
        vBool = true;

      });

    }

    print('Howdy, ${act_name}!') ;
    sendScan(codeSanner);




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
      body: SafeArea(
        child: Container(

          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: vBool,
                  child: RepaintBoundary(
                    key: globalKey,
                    child:  CreditCardsPage(
                      username: widget.username,
                      act_name: act_name,
                      damage: damage,
                      fName: fName,
                      lName: lName,
                      unit: unit,
                      program: program,
                      subject: subject,
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
                    (await BarcodeScanner.scan()); //barcode scnner
                    setState(() {
                      qrCodeResult = codeSanner;
                      getData(codeSanner);

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

  void sendScan(String qrCodeResult) async {

    var url = "https://o.sppetchz.com/project/InsertScan.php";
    await http.post(
      url,
      body: {
        "id_act": qrCodeResult,
        "username": widget.username,
      },
    );
    print(widget.username);
    capture();
  }

  // Future shared() async {
  //   try {
  //     RenderRepaintBoundary boundary =
  //         globalKey.currentContext.findRenderObject();
  //     var image = await boundary.toImage();
  //     ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
  //     Uint8List pngBytes = byteData.buffer.asUint8List();
  //
  //     final tempDir = await getTemporaryDirectory();
  //     final file = await File('${tempDir.path}/image.png').create();
  //     await file.writeAsBytes(pngBytes);
  //     final channel = MethodChannel('cm.share/share');
  //     channel.invokeMethod('shareFile', 'image.png');
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    final info = statuses[Permission.storage].toString();
    print(info);
    _toastInfo(info);
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  void capture() async {
    print(vBool);

    RenderRepaintBoundary boundary =
    globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 1);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
        name: "$qrCodeResult${widget.username}");
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
  final String subject;

  dataModel(this.fName, this.lName, this.program, this.act_name, this.unit,
      this.damage, this.subject);

  dataModel.fromJson(Map<String, dynamic> json)
      : fName = json["firstname"],
        lName = json["lastname"],
        program = json["program"],
        act_name = json["act_name"],
        unit = json["unit"],
        damage = json["damage"],
        subject = json["subject"];
}
