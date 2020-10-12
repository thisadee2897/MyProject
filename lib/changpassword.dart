import 'package:flutter/material.dart';

class ChangPassword extends StatefulWidget {
  @override
  _ChangPasswordState createState() => _ChangPasswordState();
}

class _ChangPasswordState extends State<ChangPassword> {


  //String password;

  String _validate_password(String value) {
    if (value.isEmpty) return 'กรุณากรอกรหัสผ่านเดิม';
    return null;
  }

  String _validatepassword(String value) {
    if (value.isEmpty) return 'กรุณากรอกรหัสผ่านใหม่';
    return null;
  }

  

  String _validatepassword_(String value) {
    if (value.isEmpty) return 'กรุณากรอกรหัสผ่านใหม่';
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เปลี่ยนรหัสผ่าน"),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    autovalidate: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.lock),
                      hintText: 'กรอกรหัสผ่านเดิม',
                      labelText: 'รหัสผ่านเดิม',
                    ),
                    validator: _validate_password,
                    obscureText: true,
                    maxLength: 16,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    autovalidate: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.lock),
                      hintText: 'กรอกรหัสผ่านใหม่',
                      labelText: 'รหัสผ่านใหม่',
                    ),
                    validator: _validatepassword,
                    obscureText: true,
                    maxLength: 16,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    autovalidate: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.lock),
                      hintText: 'ยืนยันรหัสผ่านใหม่',
                      labelText: 'ยืนยันรหัสผ่านใหม่',
                    ),
                    validator: _validatepassword_,
                    obscureText: true,
                    maxLength: 16,
                  ),
                  _buildLoginBtn()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Widget _buildLoginBtn() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () {},
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Text(
        'OK',
        style: TextStyle(
          color: Color(0xFF527DAA),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
  );
}