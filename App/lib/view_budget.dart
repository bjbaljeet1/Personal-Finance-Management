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
// //       home: const viewbudget(title: 'View Reply'),
// //     );
// //   }
// // }
// //
// // class viewbudget extends StatefulWidget {
// //   const viewbudget({super.key, required this.title});
// //
// //   final String title;
// //
// //   @override
// //   State<viewbudget> createState() => _viewbudgetState();
// // }
// //
// // class _viewbudgetState extends State<viewbudget> {
// //
// //   _viewbudgetState(){
// //     viewreply();
// //   }
// //
// //   List<String> id_ = <String>[];
// //   List<String> month_= <String>[];
// //   List<String> year_= <String>[];
// //   List<String> budget_= <String>[];
// //
// //   Future<void> viewreply() async {
// //     List<String> id = <String>[];
// //     List<String> month = <String>[];
// //     List<String> year = <String>[];
// //     List<String> budget = <String>[];
// //
// //
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //       String url = '$urls/user_view_budget/';
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
// //         month.add(arr[i]['month'].toString());
// //         year.add(arr[i]['year'].toString());
// //         budget.add(arr[i]['budget'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         month_ = month;
// //         year_ = year;
// //         budget_ = budget;
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
// //                                     child: Text(budget_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(month_[index]),
// //                                   ),    Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(year_[index]),
// //                                   ),
// //                                   ElevatedButton(onPressed: () async {
// //               SharedPreferences sh = await SharedPreferences.getInstance();
// //               String url = sh.getString('url').toString();
// //               String lid = sh.getString('lid').toString();
// //
// //               final Uri urls = Uri.parse('$url/user_delete_budget/');
// //               try {
// //                 final response = await http.post(urls, body: {
// //                   'id': id_[index],
// //
// //                 });
// //
// //                 if (response.statusCode == 200) {
// //                   String status = jsonDecode(response.body)['status'];
// //                   if (status == 'ok') {
// //                     Fluttertoast.showToast(msg: 'Deleted');
// //
// //                     Navigator.push(context, MaterialPageRoute(
// //                       builder: (context) => viewbudget(title: "Budget"),));
// //
// //
// //                   } else {
// //                     Fluttertoast.showToast(msg: 'Not Found');
// //                   }
// //                 } else {
// //                   Fluttertoast.showToast(msg: 'Network Error');
// //                 }
// //               } catch (e) {
// //                 Fluttertoast.showToast(msg: e.toString());
// //               }
// //
// //
// //
// //
// //
// //                                   }, child: Text("Delete")),
// //
// //
// //
// //
// //
// //                                   ElevatedButton(onPressed: () async {
// //
// //                                     SharedPreferences sh = await SharedPreferences.getInstance();
// //                                     sh.setString('bid', id_[index]);
// //
// //                                     Navigator.push(context, MaterialPageRoute(
// //                                       builder: (context) => ExpensesPage(title: ""),));
// //
// //                                   }, child: Text("Add Expenese"))
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
// import 'package:pfm/Expenses.dart';
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
//       title: 'View Budget',
//       theme: ThemeData.dark().copyWith(
//         primaryColor: Colors.teal,
//         colorScheme: ColorScheme.dark(
//           primary: Colors.teal,
//           secondary: Colors.tealAccent,
//         ),
//       ),
//       home: const viewbudget(title: 'View Budget'),
//     );
//   }
// }
//
// class viewbudget extends StatefulWidget {
//   const viewbudget({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewbudget> createState() => _viewbudgetState();
// }
//
// class _viewbudgetState extends State<viewbudget> {
//   List<String> id_ = [];
//   List<String> month_ = [];
//   List<String> year_ = [];
//   List<String> budget_ = [];
//   bool isLoading = true;
//   String errorMessage = "";
//
//   @override
//   void initState() {
//     super.initState();
//     fetchBudgetData();
//   }
//
//   Future<void> fetchBudgetData() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? "";
//       String lid = sh.getString('lid') ?? "";
//
//       if (urls.isEmpty || lid.isEmpty) {
//         setState(() {
//           errorMessage = "User not authenticated. Please login again.";
//           isLoading = false;
//         });
//         return;
//       }
//
//       String url = '$urls/user_view_budget/';
//       var response = await http.post(Uri.parse(url), body: {'lid': lid});
//
//       if (response.statusCode == 200) {
//         var jsondata = json.decode(response.body);
//
//         if (jsondata['status'] == 'ok' && jsondata['data'] != null) {
//           var arr = jsondata["data"];
//           if (arr.isNotEmpty) {
//             List<String> tempId = [];
//             List<String> tempMonth = [];
//             List<String> tempYear = [];
//             List<String> tempBudget = [];
//
//             for (var item in arr) {
//               tempId.add(item['id'].toString());
//               tempMonth.add(item['month'].toString());
//               tempYear.add(item['year'].toString());
//               tempBudget.add(item['budget'].toString());
//             }
//
//             setState(() {
//               id_ = tempId;
//               month_ = tempMonth;
//               year_ = tempYear;
//               budget_ = tempBudget;
//             });
//           } else {
//             setState(() {
//               errorMessage = "No budget records found.";
//             });
//           }
//         } else {
//           setState(() {
//             errorMessage = "Failed to fetch data. Please try again.";
//           });
//         }
//       } else {
//         setState(() {
//           errorMessage = "Server error. Please try again later.";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error: ${e.toString()}";
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> deleteBudget(int index) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? "";
//       if (urls.isEmpty) return;
//
//       String url = '$urls/user_delete_budget/';
//       var response = await http.post(Uri.parse(url), body: {'id': id_[index]});
//
//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         if (jsonResponse['status'] == 'ok') {
//           Fluttertoast.showToast(msg: 'Budget record deleted.');
//           setState(() {
//             id_.removeAt(index);
//             month_.removeAt(index);
//             year_.removeAt(index);
//             budget_.removeAt(index);
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Failed to delete record.');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network error. Try again.');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => true,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => user_home_page()));
//             },
//           ),
//           backgroundColor: Colors.teal[800],
//           title: Text(widget.title),
//         ),
//         body: isLoading
//             ? Center(child: CircularProgressIndicator())
//             : errorMessage.isNotEmpty
//             ? Center(
//           child: Text(
//             errorMessage,
//             style: TextStyle(fontSize: 18, color: Colors.redAccent),
//             textAlign: TextAlign.center,
//           ),
//         )
//             : ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               elevation: 4,
//               margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               color: Colors.grey[900],
//               child: Padding(
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Budget: \$${budget_[index]}",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.tealAccent),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       "Month: ${month_[index]}",
//                       style: TextStyle(fontSize: 16, color: Colors.white70),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       "Year: ${year_[index]}",
//                       style: TextStyle(fontSize: 16, color: Colors.white70),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () => deleteBudget(index),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Text("Delete"),
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             SharedPreferences sh = await SharedPreferences.getInstance();
//                             sh.setString('bid', id_[index]);
//
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => ExpensesPage(title: "Add Expense")),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.tealAccent[700],
//                             foregroundColor: Colors.black,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Text("Add Expense"),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/Expenses.dart';
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
      title: 'View Budget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const viewbudget(title: 'View Budget'),
    );
  }
}

class viewbudget extends StatefulWidget {
  const viewbudget({super.key, required this.title});

  final String title;

  @override
  State<viewbudget> createState() => _viewbudgetState();
}

class _viewbudgetState extends State<viewbudget> {
  List<String> id_ = [];
  List<String> month_ = [];
  List<String> year_ = [];
  List<String> budget_ = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchBudgetData();
  }

  Future<void> fetchBudgetData() async {
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

      String url = '$urls/user_view_budget/';
      var response = await http.post(Uri.parse(url), body: {'lid': lid});

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);

        if (jsondata['status'] == 'ok' && jsondata['data'] != null) {
          var arr = jsondata["data"];
          if (arr.isNotEmpty) {
            List<String> tempId = [];
            List<String> tempMonth = [];
            List<String> tempYear = [];
            List<String> tempBudget = [];

            for (var item in arr) {
              tempId.add(item['id'].toString());
              tempMonth.add(item['month'].toString());
              tempYear.add(item['year'].toString());
              tempBudget.add(item['budget'].toString());
            }

            setState(() {
              id_ = tempId;
              month_ = tempMonth;
              year_ = tempYear;
              budget_ = tempBudget;
            });
          } else {
            setState(() {
              errorMessage = "No budget records found.";
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

  Future<void> deleteBudget(int index) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? "";
      if (urls.isEmpty) return;

      String url = '$urls/user_delete_budget/';
      var response = await http.post(Uri.parse(url), body: {'id': id_[index]});

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'ok') {
          Fluttertoast.showToast(msg: 'Budget record deleted.');
          setState(() {
            id_.removeAt(index);
            month_.removeAt(index);
            year_.removeAt(index);
            budget_.removeAt(index);
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
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => user_home_new(title: '',)));
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
            style: TextStyle(fontSize: 18, color: Colors.redAccent),
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
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget: ${budget_[index]}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text("Month: ${month_[index]}", style: TextStyle(fontSize: 16)),
                    Text("Year: ${year_[index]}", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => deleteBudget(index),
                          child: Text("Delete"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sh = await SharedPreferences.getInstance();
                            sh.setString('bid', id_[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExpensesPage(title: "Add Expense")),
                            );
                          },
                          child: Text("Add Expense"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

