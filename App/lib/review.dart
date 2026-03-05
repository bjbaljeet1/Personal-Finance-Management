// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // import 'package:http/http.dart' as http;
// // import 'package:pfm/Expenses.dart';
// // import 'package:pfm/home.dart';
// // import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // void main() {
// //   runApp(const ViewReply());
// // }
// //
// // class ViewReply extends StatelessWidget {
// //   const ViewReply({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'View Reply',
// //       theme: ThemeData(
// //
// //         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
// //         useMaterial3: true,
// //       ),
// //       home: const expertreviews(title: 'View Reply'),
// //     );
// //   }
// // }
// //
// // class expertreviews extends StatefulWidget {
// //   const expertreviews({super.key, required this.title});
// //
// //   final String title;
// //
// //   @override
// //   State<expertreviews> createState() => _expertreviewsState();
// // }
// //
// // class _expertreviewsState extends State<expertreviews> {
// //
// //   _expertreviewsState(){
// //     viewreply();
// //   }
// //
// //   List<String> id_ = <String>[];
// //   List<String> user_= <String>[];
// //   List<String> review_= <String>[];
// //   List<String> rating_= <String>[];
// //   List<String> date_= <String>[];
// //   List<String> expert_= <String>[];
// //
// //   Future<void> viewreply() async {
// //     List<String> id = <String>[];
// //     List<String> user = <String>[];
// //     List<String> review = <String>[];
// //     List<String> rating = <String>[];
// //     List<String> date = <String>[];
// //     List<String> expert = <String>[];
// //
// //
// //
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //       String url = '$urls/view_expert_reviews/';
// //
// //       var data = await http.post(Uri.parse(url), body: {
// //
// //         'lid':lid
// //
// //       });
// //       var jsondata = json.decode(data.body);
// //       String statuss = jsondata['status'];
// //
// //       var arr = jsondata["data"];
// //
// //       print(arr.length);
// //
// //       for (int i = 0; i < arr.length; i++) {
// //         id.add(arr[i]['id'].toString());
// //         user.add(arr[i]['user'].toString());
// //         review.add(arr[i]['review'].toString());
// //         rating.add(arr[i]['rating'].toString());
// //         date.add(arr[i]['date'].toString());
// //         expert.add(arr[i]['expert'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         user_ = user;
// //         review_ = review;
// //         rating_ = rating;
// //         date_=date;
// //         expert_=expert;
// //       });
// //
// //       print(statuss);
// //     } catch (e) {
// //       print("Error ------------------- " + e.toString());
// //       //there is error during converting file image to base64 encoding.
// //     }
// //   }
// //
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //
// //
// //     return WillPopScope(
// //       onWillPop: () async{ return true; },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leading: BackButton( onPressed:() {
// //
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (context) => user_home_page()),);
// //
// //           },),
// //           backgroundColor: Theme.of(context).colorScheme.primary,
// //           title: Text(widget.title),
// //         ),
// //         body: ListView.builder(
// //           physics: BouncingScrollPhysics(),
// //           // padding: EdgeInsets.all(5.0),
// //           // shrinkWrap: true,
// //           itemCount: id_.length,
// //           itemBuilder: (BuildContext context, int index) {
// //             return ListTile(
// //               onLongPress: () {
// //                 print("long press" + index.toString());
// //               },
// //               title: Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Column(
// //                     children: [
// //                       Card(
// //                         child:
// //                         Row(
// //                             children: [
// //                               Column(
// //                                 children: [
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(user_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(review_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(rating_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(date_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text('Expert name :${expert_[index]}'),
// //                                   ),
// //
// //                                   // ElevatedButton(onPressed: () async {
// //                                   //   SharedPreferences sh = await SharedPreferences.getInstance();
// //                                   //   String url = sh.getString('url').toString();
// //                                   //   String lid = sh.getString('lid').toString();
// //                                   //
// //                                   //   final Uri urls = Uri.parse('$url/user_delete_budget/');
// //                                   //   try {
// //                                   //     final response = await http.post(urls, body: {
// //                                   //       'id': id_[index],
// //                                   //
// //                                   //     });
// //                                   //
// //                                   //     if (response.statusCode == 200) {
// //                                   //       String status = jsonDecode(response.body)['status'];
// //                                   //       if (status == 'ok') {
// //                                   //         Fluttertoast.showToast(msg: 'Deleted');
// //                                   //
// //                                   //         Navigator.push(context, MaterialPageRoute(
// //                                   //           builder: (context) => expertreviews(title: "Budget"),));
// //                                   //
// //                                   //
// //                                   //       } else {
// //                                   //         Fluttertoast.showToast(msg: 'Not Found');
// //                                   //       }
// //                                   //     } else {
// //                                   //       Fluttertoast.showToast(msg: 'Network Error');
// //                                   //     }
// //                                   //   } catch (e) {
// //                                   //     Fluttertoast.showToast(msg: e.toString());
// //                                   //   }
// //                                   //
// //                                   //
// //                                   //
// //                                   //
// //                                   //
// //                                   // }, child: Text("Delete")),
// //
// //
// //
// //
// //
// //                                   // ElevatedButton(onPressed: () async {
// //                                   //
// //                                   //   SharedPreferences sh = await SharedPreferences.getInstance();
// //                                   //   sh.setString('bid', id_[index]);
// //                                   //
// //                                   //   Navigator.push(context, MaterialPageRoute(
// //                                   //     builder: (context) => ExpensesPage(title: ""),));
// //                                   //
// //                                   // }, child: Text("Add Expenese"))
// //
// //
// //
// //                                 ],
// //                               ),
// //
// //                             ]
// //                         ),
// //
// //                         elevation: 8,
// //                         margin: EdgeInsets.all(10),
// //                       ),
// //                     ],
// //                   )),
// //             );
// //           },
// //         ),
// //
// //
// //
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:new_project/home.dart';
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
//         primarySwatch: Colors.teal,
//         scaffoldBackgroundColor: Colors.grey[200],
//         useMaterial3: true,
//       ),
//       home: const expertreviews(title: 'View Reply'),
//     );
//   }
// }
//
// class expertreviews extends StatefulWidget {
//   const expertreviews({super.key, required this.title});
//   final String title;
//   @override
//   State<expertreviews> createState() => _expertreviewsState();
// }
//
// class _expertreviewsState extends State<expertreviews> {
//   List<Map<String, String>> reviews = [];
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
//       String url = '${sh.getString('url')}/view_expert_reviews/';
//       String lid = sh.getString('lid') ?? '';
//       String img_url = sh.getString('img_url') ?? '';
//
//       var response = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           reviews = List<Map<String, String>>.from(
//             jsonData['data'].map((item) => {
//               'id': item['id'].toString(),
//               'user': item['user'].toString(),
//               'review': item['review'].toString(),
//               'photo': img_url+item['photo'].toString(),
//               'rating': item['rating'].toString(),
//               'date': item['date'].toString(),
//               'expert': item['expert'].toString(),
//             }),
//           );
//         });
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => user_home_page()),
//           ),
//         ),
//         backgroundColor: Colors.teal,
//         title: Text(widget.title, style: TextStyle(color: Colors.white)),
//         elevation: 5,
//       ),
//       body: reviews.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         physics: BouncingScrollPhysics(),
//         itemCount: reviews.length,
//         itemBuilder: (context, index) {
//           final review = reviews[index];
//           return Card(
//             margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             elevation: 8,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.teal.shade100,
//                       child: Icon(Icons.person, color: Colors.teal),
//                     ),
//                     title: Text(
//                       review['user'] ?? '',
//                       style: TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(
//                       review['date'] ?? '',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     trailing: Chip(
//                       backgroundColor: Colors.teal.shade200,
//                       label: Text('⭐ ${review['rating']}',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                   Divider(),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       review['review'] ?? '',
//                       style: TextStyle(fontSize: 16, color: Colors.black87),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Expert: ${review['expert']}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.teal.shade700,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.teal,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           'View Details',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/home.dart';
import 'package:new_project/view_experts.dart';
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
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[200],
        useMaterial3: true,
      ),
      home: const expertreviews(title: 'View Reply'),
    );
  }
}

class expertreviews extends StatefulWidget {
  const expertreviews({super.key, required this.title});
  final String title;
  @override
  State<expertreviews> createState() => _expertreviewsState();
}

class _expertreviewsState extends State<expertreviews> {
  List<Map<String, String>> reviews = [];

  @override
  void initState() {
    super.initState();
    viewReply();
  }

  Future<void> viewReply() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = '${sh.getString('url')}/view_expert_reviews/';
      String lid = sh.getString('lid') ?? '';
      String img_url = sh.getString('img_url') ?? '';

      var response = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        setState(() {
          reviews = List<Map<String, String>>.from(
            jsonData['data'].map((item) => {
              'id': item['id'].toString(),
              'user': item['user'].toString(),
              'review': item['review'].toString(),
              'photo': img_url + item['photo'].toString(),
              'rating': item['rating'].toString(),
              'date': item['date'].toString(),
              'expert': item['expert'].toString(),
            }),
          );
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }

  void _showDetailsPopup(BuildContext context, Map<String, String> review) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Review Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('User: ${review['user']}'),
                Text('Date: ${review['date']}'),
                Text('Rating: ⭐ ${review['rating']}'),
                Text('Review: ${review['review']}'),
                Text('Expert: ${review['expert']}'),
                SizedBox(height: 10),
                CircleAvatar(
                  backgroundImage: NetworkImage(review['photo'] ?? ''),
                  radius: 50,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => user_home_new(title: '',)),
          ),
        ),
        backgroundColor: Colors.teal,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        elevation: 5,
      ),
      body: reviews.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(review['photo'] ?? ''),
                      radius: 25,
                    ),
                    title: Text(
                      review['user'] ?? '',
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      review['date'] ?? '',
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Chip(
                      backgroundColor: Colors.teal.shade200,
                      label: Text('⭐ ${review['rating']}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      review['review'] ?? '',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expert: ${review['expert']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => viewexpert(title: '')),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent, // Change "Colors.blue" to your desired color
                        ),
                        child: Text(
                          'View Details',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
