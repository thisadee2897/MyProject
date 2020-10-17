import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class CreditCardsPage extends StatelessWidget {
  DateTime myDateTime = DateTime.now();
  final String username;
  final String fName;
  final String lName;
  final String program;
  final String act_name;
  final String unit;
  final String damage;

  CreditCardsPage(
      {Key key,
      @required this.username,
      this.fName,
      this.lName,
      this.program,
      this.act_name,
      this.unit,
      this.damage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCreditCard(
            color: Colors.blue,
            cardHolder: "$fName $lName",
            id_student: username,
            fristname: fName,
            lastname: lName,
            subject: program,
            program: program,
            activityname: act_name,
            activitytype: damage,
            activityunit: unit,
          ),
        ],
      ),
    );
  }

  // Build the credit card widget
  Card _buildCreditCard({
    @required Color color,
    @required String fristname,
    @required String lastname,
    @required String id_student,
    @required String subject,
    @required String program,
    @required String activitytype,
    @required String activityunit,
    @required String activityname,
    @required String cardHolder,
  }) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 22.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  '$id_student',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      fontFamily: 'CourrierPrime'),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'ชื่อ :',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'CourrierPrime'),
                ),
                SizedBox(
                  width: 3,
                ),
                Row(
                  children: [
                    Text(
                      '$fristname',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'CourrierPrime'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '$lastname',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'CourrierPrime'),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'สาขา :',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'CourrierPrime'),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  '$subject',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'CourrierPrime'),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'โปรแกรม :',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontFamily: 'CourrierPrime'),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Text(
                      '$program',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'CourrierPrime'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    'กิจกรรม :',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontFamily: 'CourrierPrime'),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Text(
                      '$activityname',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'CourrierPrime'),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'ประเภท :',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'CourrierPrime'),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  '$activitytype',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'CourrierPrime'),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'จำนวน :',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'CourrierPrime'),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  '$activityunit',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'CourrierPrime'),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    var formatter = DateFormat.yMMMEd();
    var formatter2 = DateFormat.Hms();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Text("SKC.RMUTI",
        //     style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold,fontSize: 20)),
        Expanded(
          child: Row(
            children: [
              Text('วัน ${formatter.format(myDateTime)}',
                  style: TextStyle(color: Colors.white)),
              SizedBox(
                width: 5,
              ),
              Text('เวลา ${formatter2.format(myDateTime)}',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        // Text("Activity", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({@required String label, @required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
