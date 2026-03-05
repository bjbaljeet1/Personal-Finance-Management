// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
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
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const BudgetManagement(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class BudgetManagement extends StatefulWidget {
//   const BudgetManagement({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<BudgetManagement> createState() => _BudgetManagementState();
// }
//
// class _BudgetManagementState extends State<BudgetManagement> {
//   TextEditingController budgetController = TextEditingController();
//
//   // Dropdown values
//   List<String> months = [
//     'January', 'February', 'March', 'April', 'May', 'June',
//     'July', 'August', 'September', 'October', 'November', 'December'
//   ];
//   List<String> years = List.generate(10, (index) => (DateTime.now().year - index).toString());
//
//   String selectedMonth = "January"; // Default selected month
//   String selectedYear = DateTime.now().year.toString(); // Default selected year
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Budget Input Field
//             TextFormField(
//               controller: budgetController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "Budget",
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             // Month Dropdown
//             DropdownButton<String>(
//               value: selectedMonth,
//               items: months.map((String month) {
//                 return DropdownMenuItem<String>(
//                   value: month,
//                   child: Text(month),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedMonth = newValue!;
//                 });
//               },
//             ),
//
//             // Year Dropdown
//             DropdownButton<String>(
//               value: selectedYear,
//               items: years.map((String year) {
//                 return DropdownMenuItem<String>(
//                   value: year,
//                   child: Text(year),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedYear = newValue!;
//                 });
//               },
//             ),
//
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _sendData();
//               },
//               child: const Text("Submit"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _sendData() async {
//     String budget = budgetController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final Uri urls = Uri.parse('$url/user_budget_manage/');
//     try {
//       final response = await http.post(urls, body: {
//         'budget': budget,
//         'month': selectedMonth,
//         'year': selectedYear,
//         'lid': lid,
//       });
//
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Added');
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_project/home.dart';
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
      title: 'Budget Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const BudgetManagement(title: 'Budget Manager'),
    );
  }
}

class BudgetManagement extends StatefulWidget {
  const BudgetManagement({super.key, required this.title});
  final String title;

  @override
  State<BudgetManagement> createState() => _BudgetManagementState();
}

class _BudgetManagementState extends State<BudgetManagement> {
  TextEditingController budgetController = TextEditingController();
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  List<String> years = List.generate(10, (index) => (DateTime.now().year - index).toString());

  String selectedMonth = "January";
  String selectedYear = DateTime.now().year.toString();

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
                    controller: budgetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Budget",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.currency_rupee, color: Colors.deepPurple),
                    ),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: selectedMonth,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.calendar_today, color: Colors.deepPurple),
                    ),
                    items: months.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: selectedYear,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.date_range, color: Colors.deepPurple),
                    ),
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
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
    String budget = budgetController.text;
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final Uri urls = Uri.parse('$url/user_budget_manage/');
    try {
      final response = await http.post(urls, body: {
        'budget': budget,
        'month': selectedMonth,
        'year': selectedYear,
        'lid': lid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Added');
          Navigator.push(context, MaterialPageRoute(builder: (context) => user_home_new(title: 'home page',)));
        } else {
          Fluttertoast.showToast(msg: 'Already Budget Added To This Month');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
