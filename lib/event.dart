//
//
// class EventModel  {
//
//   final String id;
//   //final String id_act;
//   final String act_name;
//   //final DateTime unit;
//   //final DateTime type;
//   final String agency;
//   final String date;
//
//   EventModel(this.id, this.act_name,this.agency, this.date);
// }
//
// // Future <List> getData() async{
// //   final response = await http.get("https://o.sppetchz.com/project/getdataactivitys.php");
// //   print(json.decode(response.body));
// //   var jsonData= json.decode(response.body);
// //   List<EventModel> appointmentData = [];
// //   for (var u in jsonData) {
// //     EventModel user = EventModel(
// //         u['id'], u['act_name'], u['agency'], u['date']);
// //     appointmentData.add(user);
// //   }
// //   print(appointmentData.length);
// //   return appointmentData;
// //
// // }