import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("scan"),
      ),
      body: Center(child: _buildScan(context: context),),
    );
  }
  _buildScan({BuildContext context}) => Expanded(
    flex: 1,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          "assets/ic_scan_qrcode.png",
          width: 110,
          height: 110,
        ),
        SizedBox(
          height: 15,
        ),
        RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text("SCAN"),
          onPressed: () {
            scanQRCode(context: context);
          },
        )
      ],
    ),
  );
  Future scanQRCode({BuildContext context}) async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      showAlertDialog(result: barcode.rawContent, context: context);
    } on PlatformException catch (exception) {
      if (exception.code == BarcodeScanner.cameraAccessDenied) {
        showAlertDialog(
            result: 'not grant permission to open the camera',
            context: context);
      } else {
        print('Unknown error: $exception');
      }
    } catch (exception) {
      print('Unknown error: $exception');
    }
  }
  showAlertDialog({BuildContext context, String result}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Result"),
          content: Text(result),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            )
          ],
        );
      },
    );
  }
}
