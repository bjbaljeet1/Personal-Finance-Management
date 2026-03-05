import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_project/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Addnotification(title: 'Flutter Demo Home Page'),
    );
  }
}

class Addnotification extends StatefulWidget {
  const Addnotification({super.key, required this.title});


  final String title;

  @override
  State<Addnotification> createState() => _AddnotificationState();
}

class _AddnotificationState extends State<Addnotification> {

  TextEditingController notificationcontroller=new TextEditingController();
  TextEditingController notifdatecontroller=new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: notificationcontroller,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("notification")),),


            TextFormField(
              controller: notifdatecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Date"),
                suffixIcon: Icon(Icons.calendar_today), // Calendar icon
              ),
              readOnly: true, // Prevent manual editing
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                  setState(() {
                    notifdatecontroller.text = formattedDate; // Update controller value
                  });
                }
              },
            ),
            ElevatedButton(onPressed: (){_send_data();}, child: Text("submit"))

          ],
        ),
      ),

    );
  }
  void _send_data() async{


    String notify=notificationcontroller.text;
    String date=notifdatecontroller.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/manage_notifications/');
    try {
      final response = await http.post(urls, body: {
        'notify':notify,
        'date':date,
        'lid':lid,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {


          Fluttertoast.showToast(msg: 'Successfully added');


          Navigator.push(context, MaterialPageRoute(
            builder: (context) => user_home_page(),));
        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
