import 'package:flutter/material.dart';

class CreditCardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4,right: 4,top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          _buildCreditCard(
            color: Colors.blue,
            cardExpiration: "วิศว",
            cardHolder: "ทฤษฎี จรบุรมย์",
            id_student: '60522110042-2',
            fristname: "ทฤษฎี",
            lastname: "จรบุรมย์",
            subject: 'วิศวกรรมไฟฟ้า',
            program: 'วิศวกรรคอมพิวเตอร์',
            activityname: 'ปัจฉิมนิเทศ',
            activitytype: 'บังคับ',
            activityunit: '4',
          ),
        ],
      ),
    );
  }

  // Build the title section
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

  // Build the credit card widget
  Card _buildCreditCard(
      {@required Color color,
      @required String fristname,
      @required String lastname,
      @required String id_student,
      @required String subject,
      @required String program,
      @required String activitytype,
      @required String activityunit,
      @required String activityname,
      @required String cardHolder,
      @required String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 400,
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
                  'รหัสนักศึกษา :',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'CourrierPrime'),
                ),
                SizedBox(
                  width: 3,
                ),
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
                          fontSize: 20,
                          fontFamily: 'CourrierPrime'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '$lastname',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
            Row(
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
                Text(
                  '$program',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'CourrierPrime'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
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
                Text(
                  '$activityname',
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
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("SKC.RMUTI",
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold,fontSize: 20)),
        Row(
          children: [
            Text("22 ต.ค.2563", style: TextStyle(color: Colors.white)),
            SizedBox(
              width: 5,
            ),
            Text("19:47 น.", style: TextStyle(color: Colors.white)),
          ],
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
