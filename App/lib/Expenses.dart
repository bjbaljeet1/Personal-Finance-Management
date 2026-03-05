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
      title: 'Expenses Tracker',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF7F2FA),
        colorScheme: ColorScheme.light(
          primary: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
        ),
        useMaterial3: true,
      ),
      home: const ExpensesPage(title: 'Expense Details'),
    );
  }
}

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key, required this.title});
  final String title;

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;
  String? bid; // Add this variable to store the budget ID

  @override
  void initState() {
    super.initState();
    _loadBudgetId(); // Load the budget ID when the page is initialized
  }

  // Method to load the budget ID from SharedPreferences
  void _loadBudgetId() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      bid = sh.getString('bid');
    });

    // Check if bid is valid
    if (bid == null || bid!.isEmpty) {
      Fluttertoast.showToast(msg: "Budget ID not found. Please try again.");
      Navigator.pop(context); // Go back to the previous page
    }
  }

  final List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Utilities',
    'Health Insurance',
    'Homeowner’s Insurance',
    'Car Insurance',
    'Life Insurance',
    'Home Rent',
    'Business Insurance',
    'Travel Insurance',
    'Mortgage Insurance',
    'Insurance for Rental Property'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(expenseController, 'Expense', Icons.currency_rupee),
                  const SizedBox(height: 15),
                  _buildTextField(descriptionController, 'Description', Icons.description),
                  const SizedBox(height: 15),
                  _buildDropdown(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    onPressed: _sendData,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        labelText: label,
        labelStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButton<String>(
      value: selectedCategory,
      hint: const Text("Select Category", style: TextStyle(color: Colors.black54)),
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(color: Colors.black54)),
        );
      }).toList(),
      isExpanded: true,
    );
  }

  void _sendData() async {
    String expense = expenseController.text.trim();
    String description = descriptionController.text.trim();

    // Validate fields
    if (selectedCategory == null || expense.isEmpty || description.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields");
      return;
    }

    // Validate expense is a number
    double? expenseValue = double.tryParse(expense);  // Parse as double
    if (expenseValue == null) {
      Fluttertoast.showToast(msg: "Expense must be a number");
      return;
    }

    // Retrieve shared preferences
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String? lid = sh.getString('lid');
    String? bid = sh.getString('bid');

    // Validate shared preferences
    if (url == null || lid == null || bid == null) {
      Fluttertoast.showToast(msg: "Invalid configuration. Please restart the app.");
      return;
    }

    // Prepare the request body
    final Map<String, String> body = {
      'Expense': expenseValue.toString(),  // Send as string
      'discription': description,
      'category': selectedCategory!,
      'lid': lid,
      'bid': bid,
      'month': DateTime.now().month.toString(),
      'year': DateTime.now().year.toString(),
    };

    // Send the request
    final Uri uri = Uri.parse('$url/user_expenses/');
    try {
      final response = await http.post(uri, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 'ok') {
          Fluttertoast.showToast(msg: 'Added Successfully');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const user_home_new(title: 'Home'),
            ),
          );
        } else {
          Fluttertoast.showToast(msg: responseBody['message'] ?? 'Error occurred');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }
}