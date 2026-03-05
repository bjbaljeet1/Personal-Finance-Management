// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pfm/home.dart';
// import 'package:pfm/signup.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
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
//       home: const message(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class message extends StatefulWidget {
//   final dynamic title;
//
//   const message({super.key, required this.title});
//
//
//
//
//
//   @override
//   State<message> createState() => _messageState();
// }
//
// class _messageState extends State<message> {
//
//   TextEditingController messagecontroller=new TextEditingController();
//  
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
//
//       ),
//       body: Center(
//
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               controller: messagecontroller,
//               decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Message")),),
//            
//
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
//     String message=messagecontroller.text;
//   
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//     String eid = sh.getString('eid').toString();
//
//     final urls = Uri.parse('$url/send_request/');
//     try {
//       final response = await http.post(urls, body: {
//         'message':message,
//         'lid':lid,
//         'eid':eid
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
      title: 'Message Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const message(title: 'Send Message'),
    );
  }
}

class message extends StatefulWidget {
  final String title;
  const message({super.key, required this.title});

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Enter your message",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Submit", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _sendData() async {
    String message = messageController.text.trim();
    if (message.isEmpty) {
      Fluttertoast.showToast(msg: 'Message cannot be empty');
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';
    String eid = sh.getString('eid') ?? '';

    final Uri apiUrl = Uri.parse('$url/send_request/');
    try {
      final response = await http.post(apiUrl, body: {
        'message': message,
        'lid': lid,
        'eid': eid,
      });

      if (response.statusCode == 200 && jsonDecode(response.body)['status'] == 'ok') {
        Fluttertoast.showToast(msg: 'Message Sent Successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => user_home_new(title: 'Home',)),
        );
      } else {
        Fluttertoast.showToast(msg: 'Failed to send message');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }
}

