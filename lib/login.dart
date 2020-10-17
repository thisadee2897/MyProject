import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Home/home_student.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

var _user;

class _LoginState extends State<Login> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  // ignore: missing_return
  Future<List> _submits() async {
    final response = await http.post("https://o.sppetchz.com/project/login.php",
        body: {"username": username.text, "password": password.text});
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {
        _showAlertDialog();
      });
    } else {
      if (datauser[0]['level'] == '1') {
        Navigator.pushReplacementNamed(context, '/home_admin');
      } else if (datauser[0]['level'] == '2') {
        Navigator.pushReplacementNamed(context, '/home_student');
      } else if (datauser[0]['level'] == '3') {
        // Navigator.pushReplacementNamed(context, '/home_student');
      } else if (datauser[0]['level'] == '4') {
        setState(
          () {
            _user = username.text;
          },
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeStudent(username: _user),
          ),
        );
      }
      setState(() {
        username = datauser[0]['username'];
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new TextFormField(
          autofocus: true,
          controller: username,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: new InputDecoration(
            labelText: "username",
            icon: Icon(Icons.account_circle),
          ),
          validator: _validateusername,
        ),
      ],
    );
  }

  String _validateusername(String value) {
    if (value.isEmpty) {
      return "ว่างเปล่า";
    }

    return null;
  }

  String _validatepassword(String value) {
    if (value.isEmpty) {
      return "ว่างเปล่า";
    }
    return null;
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("ข้อมูลไม่ถูกต้อง"),
            content: Text("กรุณาลองอีกครั้ง"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new TextFormField(
          cursorColor: Colors.white,
          autofocus: true,
          controller: password,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          obscureText: true,
          decoration: new InputDecoration(
            labelText: "password",
            icon: Icon(Icons.lock),
          ),
          validator: _validatepassword,
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _submits,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/signup');
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE9),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'ACTIVITES',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _buildEmailTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        SizedBox(
                          height: 25,
                        ),
                        _buildLoginBtn(),
                        SizedBox(
                          height: 50,
                        ),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
