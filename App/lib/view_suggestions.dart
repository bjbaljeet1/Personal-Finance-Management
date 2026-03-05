// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:pfm/home.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
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
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const viewsuggestions(title: 'View Reply'),
//     );
//   }
// }
//
// class viewsuggestions extends StatefulWidget {
//   const viewsuggestions({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewsuggestions> createState() => _viewsuggestionsState();
// }
//
// class _viewsuggestionsState extends State<viewsuggestions> {
//
//   _viewsuggestionsState(){
//     viewreply();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> date_= <String>[];
//   List<String> suggestion_= <String>[];
//   List<String> expert_= <String>[];
//   List<String> status_= <String>[];
//   List<String> message_= <String>[];
//
//   Future<void> viewreply() async {
//     List<String> id = <String>[];
//     List<String> date = <String>[];
//     List<String> suggestion = <String>[];
//     List<String> expert = <String>[];
//     List<String> message = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/suggestions/';
//
//       var data = await http.post(Uri.parse(url), body: {
//
//         'lid':lid
//
//       });
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date']);
//         suggestion.add(arr[i]['suggestion']);
//         expert.add(arr[i]['expert']);
//         message.add(arr[i]['msg']);
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         suggestion_ = suggestion;
//         expert_ = expert;
//         message_ = message;
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return WillPopScope(
//       onWillPop: () async{ return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton( onPressed:() {
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => user_home_page()),);
//
//           },),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           // padding: EdgeInsets.all(5.0),
//           // shrinkWrap: true,
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               onLongPress: () {
//                 print("long press" + index.toString());
//               },
//               title: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Card(
//                         child:
//                         Row(
//                             children: [
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(date_[index]),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(message_[index]),
//                                   ), Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text("Expert:"+suggestion_[index]),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child:
//                                     Text("Expert name: "+expert_[index]),
//
//                                   ),
//                                 ],
//                               ),
//
//                             ]
//                         ),
//
//                         elevation: 8,
//                         margin: EdgeInsets.all(10),
//                       ),
//                     ],
//                   )),
//             );
//           },
//         ),
//      
//
//
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/home.dart';
import 'package:new_project/homescreen.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF125262)),
        useMaterial3: true,
      ),
      home: const viewsuggestions(title: 'View Reply'),
    );
  }
}

class viewsuggestions extends StatefulWidget {
  const viewsuggestions({super.key, required this.title});

  final String title;

  @override
  State<viewsuggestions> createState() => _viewsuggestionsState();
}

class _viewsuggestionsState extends State<viewsuggestions> {
  _viewsuggestionsState() {
    viewReply();
  }

  List<String> id_ = [];
  List<String> date_ = [];
  List<String> suggestion_ = [];
  List<String> expert_ = [];
  List<String> message_ = [];

  Future<void> viewReply() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String url = '$urls/suggestions/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsonData = json.decode(data.body);
      String status = jsonData['status'];

      var arr = jsonData["data"];

      setState(() {
        id_ = List<String>.from(arr.map((item) => item['id'].toString()));
        date_ = List<String>.from(arr.map((item) => item['date']));
        suggestion_ = List<String>.from(arr.map((item) => item['suggestion']));
        expert_ = List<String>.from(arr.map((item) => item['expert']));
        message_ = List<String>.from(arr.map((item) => item['msg']));
      });

      print(status);
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => user_home_new(title: '',)),
              );
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: ${date_[index]}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Message: ${message_[index]}",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Expert: ${suggestion_[index]}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.teal[700]),
                      ),
                      Text(
                        "Expert Name: ${expert_[index]}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.teal[900]),
                      ),
                    ],
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

