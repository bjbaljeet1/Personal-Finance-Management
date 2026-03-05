// import 'dart:convert';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:new_project/home.dart';
// import 'package:new_project/signup.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'home.dart';
// import 'homescreen.dart';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const sendComplaint(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class sendComplaint extends StatefulWidget {
//   final dynamic title;
//
//   const sendComplaint({super.key, required this.title});
//
//
//
//
//
//   @override
//   State<sendComplaint> createState() => _sendComplaintState();
// }
//
// class _sendComplaintState extends State<sendComplaint> {
//
//   TextEditingController reviewcontroller=new TextEditingController();
//   TextEditingController ratingcontroller=new TextEditingController();
//   double rat=3.0;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//
//       ),
//       body: Center(
//
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               controller: reviewcontroller,
//               decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Review")),),
//
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
//     String review=reviewcontroller.text;
//     String rating=ratingcontroller.text;
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/send_complaint/');
//     try {
//       final response = await http.post(urls, body: {
//         'com':review,
//         'lid':lid,
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
//
//           Fluttertoast.showToast(msg: 'Successfully Send');
//
//
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) => user_home_new(title: 'Home',),));
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


//222222222222222222222222222222222222

// import 'dart:convert';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'homescreen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const sendComplaint(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class sendComplaint extends StatefulWidget {
//   final String title;
//   const sendComplaint({super.key, required this.title});
//
//   @override
//   State<sendComplaint> createState() => _sendComplaintState();
// }
//
// class _sendComplaintState extends State<sendComplaint> {
//   TextEditingController reviewController = TextEditingController();
//   double rating = 3.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Send Complaint"),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//         elevation: 4,
//         shadowColor: Colors.black45,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             elevation: 5,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text(
//                     "Submit Your Complaint",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: reviewController,
//                     maxLines: 4,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       labelText: "Enter Your Complain",
//                       prefixIcon: Icon(Icons.feedback, color: Colors.deepPurple),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   RatingBar.builder(
//                     initialRating: rating,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (newRating) {
//                       setState(() {
//                         rating = newRating;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _sendData,
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//                       backgroundColor: Colors.deepPurple,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "Submit",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _sendData() async {
//     String review = reviewController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//
//     if (review.isEmpty) {
//       Fluttertoast.showToast(msg: 'Please enter your complaint');
//       return;
//     }
//
//     final urls = Uri.parse('$url/send_complaint/');
//     try {
//       final response = await http.post(urls, body: {
//         'com': review,
//         'lid': lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Successfully Sent');
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => user_home_new(title: 'Home'),
//             ),
//           );
//         } else {
//           Fluttertoast.showToast(msg: 'Submission Failed');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }


//3333333333333333333333333

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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const sendComplaint(title: 'Flutter Demo Home Page'),
    );
  }
}

class sendComplaint extends StatefulWidget {
  final String title;
  const sendComplaint({super.key, required this.title});

  @override
  State<sendComplaint> createState() => _sendComplaintState();
}

class _sendComplaintState extends State<sendComplaint> {
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Complaint"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black45,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Submit Your Complaint",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Enter Your Complain",
                      prefixIcon: Icon(Icons.feedback, color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sendData,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
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
    String review = reviewController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';

    if (review.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter your complaint');
      return;
    }

    final urls = Uri.parse('$url/send_complaint/');
    try {
      final response = await http.post(urls, body: {
        'com': review,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Successfully Sent');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => user_home_new(title: 'Home'),
            ),
          );
        } else {
          Fluttertoast.showToast(msg: 'Submission Failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
