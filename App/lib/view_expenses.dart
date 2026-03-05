import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF125262)),
        useMaterial3: true,
      ),
      home: const viewexpense(title: 'View Reply'),
    );
  }
}

class viewexpense extends StatefulWidget {
  const viewexpense({super.key, required this.title});
  final String title;
  @override
  State<viewexpense> createState() => _viewexpenseState();
}

class _viewexpenseState extends State<viewexpense> {
  _viewexpenseState() {
    viewReply();
  }

  List<Map<String, String>> expensesList = [];

  Future<void> viewReply() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String url = '$urls/user_view_expense/';
      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      if (jsondata['status'] == 'ok') {
        setState(() {
          expensesList = List<Map<String, String>>.from(
            jsondata['data'].map((item) => {
              'id': item['id'].toString(),
              'date': item['date'].toString(),
              'budget': item['budget'].toString(),
              'expense': item['expense'].toString(),
              'description': item['description'].toString(),
              'category': item['type'].toString(),
            }),
          );
        });
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  Future<void> deleteExpense(String id) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    final Uri urls = Uri.parse('$url/user_delete_expense/');
    try {
      final response = await http.post(urls, body: {'id': id});
      if (response.statusCode == 200 && jsonDecode(response.body)['status'] == 'ok') {
        Fluttertoast.showToast(msg: 'Deleted');
        setState(() {
          expensesList.removeWhere((item) => item['id'] == id);
        });
      } else {
        Fluttertoast.showToast(msg: 'Failed to delete');
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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => user_home_new(title: '',)),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: expensesList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        itemCount: expensesList.length,
        itemBuilder: (context, index) {
          var item = expensesList[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Date", item['date']!),
                  _infoRow("Budget", item['budget']!),
                  _infoRow("Expense", item['expense']!),
                  _infoRow("Description", item['description']!),
                  _infoRow("Category", item['category']!),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => deleteExpense(item['id']!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Delete", style: TextStyle(color: Colors.white)),
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

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}