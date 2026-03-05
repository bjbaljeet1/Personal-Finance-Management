import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:new_project/home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const viewtax(title: 'View Reply'),
    );
  }
}

class viewtax extends StatefulWidget {
  const viewtax({super.key, required this.title});

  final String title;

  @override
  State<viewtax> createState() => _viewtaxState();
}

class _viewtaxState extends State<viewtax> {

  _viewtaxState(){
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> taxname_= <String>[];
  List<String> taxamount_= <String>[];
  List<String> taxdate_= <String>[];


  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> taxname = <String>[];
    List<String> taxamount = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_tax/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];


      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        taxname.add(arr[i]['taxname'].toString());
        taxamount.add(arr[i]['taxamount'].toString());
      }

      setState(() {
        id_ = id;
        taxname_ = taxname;
        taxamount_ = taxamount;
        taxdate_ = date;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => user_home_page()),);

          },),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        child:
                        Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Date     :"),
                                        Text(taxdate_[index]),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Tax name    :"),
                                        Text(taxname_[index]),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Tax amount   :"),
                                        Text(taxamount_[index]),
                                      ],
                                    ),
                                  ),



                                  ElevatedButton(onPressed: () async {
                                    SharedPreferences sh = await SharedPreferences.getInstance();
                                    String url = sh.getString('url').toString();
                                    String lid = sh.getString('lid').toString();

                                    final Uri urls = Uri.parse('$url/user_delete_tax/');
                                    try {
                                      final response = await http.post(urls, body: {
                                        'id': id_[index],

                                      });

                                      if (response.statusCode == 200) {
                                        String status = jsonDecode(response.body)['status'];
                                        if (status == 'ok') {
                                          Fluttertoast.showToast(msg: 'Deleted');

                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => viewtax(title: ""),));


                                        } else {
                                          Fluttertoast.showToast(msg: 'Not Found');
                                        }
                                      } else {
                                        Fluttertoast.showToast(msg: 'Network Error');
                                      }
                                    } catch (e) {
                                      Fluttertoast.showToast(msg: e.toString());
                                    }





                                  }, child: Text("Delete")),

                                ],
                              ),

                            ]
                        ),

                        elevation: 8,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  )),
            );
          },
        ),



      ),
    );
  }
}
