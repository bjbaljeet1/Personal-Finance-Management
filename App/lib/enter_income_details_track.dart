// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pfm/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const enter_income_details_track(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class enter_income_details_track extends StatefulWidget {
//   const enter_income_details_track({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<enter_income_details_track> createState() => _enter_income_details_trackState();
// }
//
// class _enter_income_details_trackState extends State<enter_income_details_track> {
//
//   TextEditingController incomecontroller=new TextEditingController();
//   TextEditingController sourceofincomecontroller=new TextEditingController();
//   TextEditingController datecontroller=new TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               controller: incomecontroller,
//               decoration: InputDecoration(border: OutlineInputBorder(),label: Text("income")),),
//             TextFormField(
//               controller: sourceofincomecontroller,
//               decoration: InputDecoration(border: OutlineInputBorder(),label: Text("sourceofincome")),),
//
//
//             TextFormField(
//               controller: datecontroller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 label: Text("Date"),
//                 suffixIcon: Icon(Icons.calendar_today), // Calendar icon
//               ),
//               readOnly: true, // Prevent manual editing
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2101),
//                 );
//
//                 if (pickedDate != null) {
//                   String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
//                   setState(() {
//                     datecontroller.text = formattedDate; // Update controller value
//                   });
//                 }
//               },
//             ),
//
//             ElevatedButton(onPressed: (){_send_data();}, child: Text("submit"))
//
//           ],
//         ),
//       ),
//
//     );
//   }
//   void _send_data() async{
//
//
//     String income=incomecontroller.text;
//     String sourceofincome=sourceofincomecontroller.text;
//     String date=datecontroller.text;
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/user_income_details/');
//     try {
//       final response = await http.post(urls, body: {
//         'income':income,
//         'sourceofincome':sourceofincome,
//         'date':date,
//         'lid':lid,
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
//
//           Fluttertoast.showToast(msg: 'Successfully added');
//
//
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) => user_home_page(),));
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Income Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const enter_income_details_track(title: 'Income Tracker'),
    );
  }
}

class enter_income_details_track extends StatefulWidget {
  const enter_income_details_track({super.key, required this.title});
  final String title;

  @override
  State<enter_income_details_track> createState() => _enter_income_details_trackState();
}

class _enter_income_details_trackState extends State<enter_income_details_track> {
  TextEditingController incomeController = TextEditingController();
  TextEditingController sourceOfIncomeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: incomeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Income",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.currency_rupee, color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: sourceOfIncomeController,
                    decoration: InputDecoration(
                      labelText: "Source of Income",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.work, color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: "Date",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.calendar_today, color: Colors.deepPurple),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                        });
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sendData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("Submit", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendData() async {
    String income = incomeController.text;
    String sourceOfIncome = sourceOfIncomeController.text;
    String date = dateController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_income_details/');
    try {
      final response = await http.post(urls, body: {
        'income': income,
        'sourceofincome': sourceOfIncome,
        'date': date,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Successfully added');
          Navigator.push(context, MaterialPageRoute(builder: (context) => user_home_new(title: 'home page',)));
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

