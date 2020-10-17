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

class Scan extends StatefulWidget {
  final String username;

  Scan({Key key, @required this.username}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  GlobalKey globalKey = GlobalKey();
  String qrCodeResult = "ว่าง";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: shared),
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTitleSection(
                title: "การเข้าร่วมกิจกรรม",
                subTitle: "สแกนเสร็จแล้วอย่าลืมบันทึกไว้นะ"),
            RepaintBoundary(
                key: globalKey,
                child: CreditCardsPage()),
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
                  qrCodeResult = codeSanner;
                  sendScan(qrCodeResult);
                });
              },
              child: Text(
                "SCAN QR CODE",
                style:
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            )
          ],
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
}
