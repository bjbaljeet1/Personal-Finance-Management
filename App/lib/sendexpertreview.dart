import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_project/home.dart';
import 'package:new_project/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'homescreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const sendexpertreview(title: 'Flutter Demo Home Page'),
    );
  }
}

class sendexpertreview extends StatefulWidget {
  final dynamic title;

  const sendexpertreview({super.key, required this.title});





  @override
  State<sendexpertreview> createState() => _sendexpertreviewState();
}

class _sendexpertreviewState extends State<sendexpertreview> {

  TextEditingController reviewcontroller=new TextEditingController();
  TextEditingController ratingcontroller=new TextEditingController();
  double rat=3.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,


      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: reviewcontroller,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Review")),),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              rat=rating;
            },
          ),


            ElevatedButton(onPressed: (){_send_data();}, child: Text("submit"))

          ],
        ),
      ),

    );
  }
  void _send_data() async{


    String review=reviewcontroller.text;
    String rating=ratingcontroller.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String eid = sh.getString('eid').toString();

    final urls = Uri.parse('$url/send_expert_review/');
    try {
      final response = await http.post(urls, body: {
        'review':review,
        'rating':rat.toString(),
        'lid':lid,
        'eid':eid


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {


          Fluttertoast.showToast(msg: 'Successfully added');


          Navigator.push(context, MaterialPageRoute(
            builder: (context) => user_home_new(title: 'Home',),));
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
