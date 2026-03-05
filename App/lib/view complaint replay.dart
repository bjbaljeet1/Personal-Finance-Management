import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';

void main() {
  runApp(const ViewReply());
}

class ViewReply extends StatelessWidget {
  const ViewReply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const viewComplaint(title: 'View Reply'),
    );
  }
}

class viewComplaint extends StatefulWidget {
  const viewComplaint({super.key, required this.title});

  final String title;

  @override
  State<viewComplaint> createState() => _viewComplaintState();
}

class _viewComplaintState extends State<viewComplaint> {
  _viewComplaintState() {
    viewReply();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> complaint_ = <String>[];
  List<String> status_ = <String>[];
  List<String> replay_ = <String>[];

  Future<void> viewReply() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> complaint = <String>[];
    List<String> status = <String>[];
    List<String> replay = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/view_replay/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['Date'].toString());
        complaint.add(arr[i]['Complaint'].toString());
        status.add(arr[i]['Status'].toString());
        replay.add(arr[i]['Reply'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        complaint_ = complaint;
        status_ = status;
        replay_ = replay;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => user_home_new(title: 'Home',)),
              );
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 18, 82, 98).withOpacity(0.8),
                Color.fromARGB(255, 18, 82, 98).withOpacity(0.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              date_[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Complaint:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          complaint_[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 10),

                        Text(
                          "Replay:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          replay_[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),    SizedBox(height: 10),

                        Text(
                          "Status:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          status_[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),

                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


//2222
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'homescreen.dart';
//
// void main() {
//   runApp(const ViewReply());
// }
//
// class ViewReply extends StatelessWidget {
//   const ViewReply({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Reply',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF125262)),
//         useMaterial3: true,
//       ),
//       home: const viewComplaint(title: 'View Reply'),
//     );
//   }
// }
//
// class viewComplaint extends StatefulWidget {
//   const viewComplaint({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewComplaint> createState() => _viewComplaintState();
// }
//
// class _viewComplaintState extends State<viewComplaint> {
//   List<String> id_ = [];
//   List<String> date_ = [];
//   List<String> complaint_ = [];
//   List<String> status_ = [];
//   List<String> replay_ = [];
//
//   @override
//   void initState() {
//     super.initState();
//     viewReply();
//   }
//
//   Future<void> viewReply() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//       String url = '$urls/view_replay/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//
//       if (jsondata['status'] == 'success') {
//         List arr = jsondata["data"];
//
//         setState(() {
//           id_ = arr.map((item) => item['id'].toString()).toList();
//           date_ = arr.map((item) => item['Date'].toString()).toList();
//           complaint_ = arr.map((item) => item['Complaint'].toString()).toList();
//           status_ = arr.map((item) => item['Status'].toString()).toList();
//           replay_ = arr.map((item) => item['Reply'].toString()).toList();
//         });
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => user_home_new(title: 'Home')),
//             );
//           },
//         ),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         title: Text(widget.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF125262), Color(0xFF4796A1)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: id_.isEmpty
//             ? Center(
//           child: CircularProgressIndicator(color: Colors.white),
//         )
//             : ListView.builder(
//           physics: BouncingScrollPhysics(),
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               elevation: 6,
//               margin: EdgeInsets.symmetric(vertical: 10),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     buildRow("Date:", date_[index]),
//                     SizedBox(height: 8),
//                     buildTextBlock("Complaint:", complaint_[index]),
//                     SizedBox(height: 8),
//                     buildTextBlock("Reply:", replay_[index]),
//                     SizedBox(height: 8),
//                     buildStatus(status_[index]),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildRow(String title, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
//         Text(value, style: TextStyle(fontSize: 16, color: Colors.black87)),
//       ],
//     );
//   }
//
//   Widget buildTextBlock(String title, String content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
//         SizedBox(height: 4),
//         Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Text(content, style: TextStyle(fontSize: 14, color: Colors.black87)),
//         ),
//       ],
//     );
//   }
//
//   Widget buildStatus(String status) {
//     Color statusColor = status == "Resolved" ? Colors.green : Colors.red;
//     return Row(
//       children: [
//         Icon(Icons.circle, color: statusColor, size: 14),
//         SizedBox(width: 8),
//         Text(
//           status,
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: statusColor),
//         ),
//       ],
//     );
//   }
// }
