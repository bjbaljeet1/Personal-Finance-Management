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
//       home: const viewincome(title: 'View Reply'),
//     );
//   }
// }
//
// class viewincome extends StatefulWidget {
//   const viewincome({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewincome> createState() => _viewincomeState();
// }
//
// class _viewincomeState extends State<viewincome> {
//
//   _viewincomeState(){
//     viewreply();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> date_= <String>[];
//   List<String> income_= <String>[];
//   List<String> sourceofincome_= <String>[];
//
//
//   Future<void> viewreply() async {
//     List<String> id = <String>[];
//     List<String> date = <String>[];
//     List<String> income = <String>[];
//     List<String> sourceofincome = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/user_view_income/';
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
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date'].toString());
//         income.add(arr[i]['income'].toString());
//         sourceofincome.add(arr[i]['sourceofincome'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         income_ = income;
//         sourceofincome_ = sourceofincome;
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
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text("Date     :"),
//                                         Text(date_[index]),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text("Income    :"),
//                                         Text(income_[index]),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text("Source of income   :"),
//                                         Text(sourceofincome_[index]),
//                                       ],
//                                     ),
//                                   ),
//
//
//
//                                   ElevatedButton(onPressed: () async {
//                                     SharedPreferences sh = await SharedPreferences.getInstance();
//                                     String url = sh.getString('url').toString();
//                                     String lid = sh.getString('lid').toString();
//
//                                     final Uri urls = Uri.parse('$url/user_delete_income/');
//                                     try {
//                                       final response = await http.post(urls, body: {
//                                         'id': id_[index],
//
//                                       });
//
//                                       if (response.statusCode == 200) {
//                                         String status = jsonDecode(response.body)['status'];
//                                         if (status == 'ok') {
//                                           Fluttertoast.showToast(msg: 'Deleted');
//
//                                           Navigator.push(context, MaterialPageRoute(
//                                             builder: (context) => viewincome(title: ""),));
//
//
//                                         } else {
//                                           Fluttertoast.showToast(msg: 'Not Found');
//                                         }
//                                       } else {
//                                         Fluttertoast.showToast(msg: 'Network Error');
//                                       }
//                                     } catch (e) {
//                                       Fluttertoast.showToast(msg: e.toString());
//                                     }
//
//
//
//
//
//                                   }, child: Text("Delete")),
//
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

//2

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:pfm/home.dart';
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
//       theme: ThemeData.dark().copyWith(
//         primaryColor: Colors.teal,
//         scaffoldBackgroundColor: Colors.black,
//         cardColor: Colors.grey[900],
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.teal,
//             foregroundColor: Colors.white,
//           ),
//         ),
//       ),
//       home: const viewincome(title: 'View Reply'),
//     );
//   }
// }
//
// class viewincome extends StatefulWidget {
//   const viewincome({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewincome> createState() => _viewincomeState();
// }
//
// class _viewincomeState extends State<viewincome> {
//   List<String> id_ = [];
//   List<String> date_ = [];
//   List<String> income_ = [];
//   List<String> sourceOfIncome_ = [];
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
//       String url = '${sh.getString('url')}/user_view_income/';
//       String lid = sh.getString('lid') ?? '';
//
//       var response = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<dynamic> data = jsonData['data'];
//         setState(() {
//           id_ = data.map((e) => e['id'].toString()).toList();
//           date_ = data.map((e) => e['date'].toString()).toList();
//           income_ = data.map((e) => e['income'].toString()).toList();
//           sourceOfIncome_ = data.map((e) => e['sourceofincome'].toString()).toList();
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
//           onPressed: () => Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => user_home_page()),
//           ),
//         ),
//         title: Text(widget.title),
//         backgroundColor: Colors.teal,
//       ),
//       body: ListView.builder(
//         physics: BouncingScrollPhysics(),
//         itemCount: id_.length,
//         itemBuilder: (context, index) {
//           return Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             margin: EdgeInsets.all(10),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoRow("Date", date_[index]),
//                   _buildInfoRow("Income", income_[index]),
//                   _buildInfoRow("Source", sourceOfIncome_[index]),
//                   SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton.icon(
//                       onPressed: () => _deleteIncome(index),
//                       icon: Icon(Icons.delete),
//                       label: Text("Delete"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "$title:",
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           Text(
//             value,
//             style: TextStyle(color: Colors.white70),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _deleteIncome(int index) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = '${sh.getString('url')}/user_delete_income/';
//       var response = await http.post(Uri.parse(url), body: {'id': id_[index]});
//
//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         if (jsonResponse['status'] == 'ok') {
//           Fluttertoast.showToast(msg: 'Deleted');
//           setState(() {
//             id_.removeAt(index);
//             date_.removeAt(index);
//             income_.removeAt(index);
//             sourceOfIncome_.removeAt(index);
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Error deleting');
//         }
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Network Error");
//     }
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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
      title: 'View Income',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 18, 82, 98),
        ),
        useMaterial3: true,
      ),
      home: const viewincome(title: 'View Income'),
    );
  }
}

class viewincome extends StatefulWidget {
  const viewincome({super.key, required this.title});

  final String title;

  @override
  State<viewincome> createState() => _viewincomeState();
}

class _viewincomeState extends State<viewincome> {
  List<String> id_ = [];
  List<String> date_ = [];
  List<String> income_ = [];
  List<String> sourceofincome_ = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchIncomeData();
  }

  Future<void> fetchIncomeData() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? "";
      String lid = sh.getString('lid') ?? "";

      if (urls.isEmpty || lid.isEmpty) {
        setState(() {
          errorMessage = "User not authenticated. Please login again.";
          isLoading = false;
        });
        return;
      }

      String url = '$urls/user_view_income/';
      var response = await http.post(Uri.parse(url), body: {'lid': lid});

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);

        if (jsondata['status'] == 'ok' && jsondata['data'] != null) {
          var arr = jsondata["data"];
          if (arr.isNotEmpty) {
            List<String> tempId = [];
            List<String> tempDate = [];
            List<String> tempIncome = [];
            List<String> tempSource = [];

            for (var item in arr) {
              tempId.add(item['id'].toString());
              tempDate.add(item['date'].toString());
              tempIncome.add(item['income'].toString());
              tempSource.add(item['sourceofincome'].toString());
            }

            setState(() {
              id_ = tempId;
              date_ = tempDate;
              income_ = tempIncome;
              sourceofincome_ = tempSource;
            });
          } else {
            setState(() {
              errorMessage = "No income records found.";
            });
          }
        } else {
          setState(() {
            errorMessage = "Failed to fetch data. Please try again.";
          });
        }
      } else {
        setState(() {
          errorMessage = "Server error. Please try again later.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: ${e.toString()}";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteIncome(int index) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? "";
      if (urls.isEmpty) return;

      String url = '$urls/user_delete_income/';
      var response = await http.post(Uri.parse(url), body: {'id': id_[index]});

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'ok') {
          Fluttertoast.showToast(msg: 'Income record deleted.');
          setState(() {
            id_.removeAt(index);
            date_.removeAt(index);
            income_.removeAt(index);
            sourceofincome_.removeAt(index);
          });
        } else {
          Fluttertoast.showToast(msg: 'Failed to delete record.');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network error. Try again.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(
        child: Text(
          errorMessage,
          style: TextStyle(fontSize: 18, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(date_[index]),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Income: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${income_[index]}"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Source: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(sourceofincome_[index]),
                    ],
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => deleteIncome(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Delete"),
                    ),
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
