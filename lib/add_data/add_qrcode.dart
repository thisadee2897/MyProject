import 'dart:typed_data';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';

class AddQRcode extends StatefulWidget {
  @override
  _AddQRcodeState createState() => _AddQRcodeState();
}

class _AddQRcodeState extends State<AddQRcode> {
  GlobalKey globalKey = GlobalKey();
  final TextEditingController _textcontoller = TextEditingController();

  String _dataQRCode = "";
  @override
  void initState() {
    super.initState();
    _textcontoller.addListener(Change);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QRCode"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: shared),
        ],
      ),
      body:
      SingleChildScrollView(
        child: SafeArea(
          child: _buildcontant(),
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
  _buildcontant() => Padding(
    padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 30),
    child: Column(
      children: <Widget>[
        TextField(
          controller: _textcontoller,
          decoration: InputDecoration(hintText: 'กรอกรหัสกิจกรรม'),
        ),
        SizedBox(
          height: 40,
        ),
        RepaintBoundary(
          key: globalKey,
          child: QrImage(
            backgroundColor: Colors.white,
            data: _dataQRCode,
            size: 250,
            errorStateBuilder: (context, exception) {
              return Center(
                child: Text(exception),
              );
            },
          ),
        ),
      ],
    ),
  );

  void Change() {
    setState(() {
      _dataQRCode = _textcontoller.text;
    });
  }
}
