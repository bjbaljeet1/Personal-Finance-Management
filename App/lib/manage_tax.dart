
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tax Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Manage_tax(title: 'Tax Management'),
    );
  }
}

class Manage_tax extends StatefulWidget {
  const Manage_tax({super.key, required this.title});

  final String title;

  @override
  State<Manage_tax> createState() => _Manage_taxState();
}

class _Manage_taxState extends State<Manage_tax> {
  String taxOwed = '';
  String  totalIncome = "0.0";
  String  totalExpense = "0.0";
  String  deductibleAmount = "0.0";
  String taxableIncome = "0.0";
  List<IncomeData> monthlyIncomeData = [];
  List<IncomeData> yearlyIncomeData = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Tax Owed
              _buildInfoCard(
                icon: Icons.currency_rupee,
                title: 'Total Tax Owed',
                value: '₹$taxOwed',
                color: Colors.red,
              ),
              SizedBox(height: 20),

              // Total Income
              _buildInfoCard(
                icon: Icons.currency_rupee,
                title: 'Total Income',
                value: '₹$totalIncome',
                color: Colors.green,
              ),
              SizedBox(height: 20),

              // Total Expense
              _buildInfoCard(
                icon: Icons.currency_rupee,
                title: 'Total Expense',
                value: '₹$totalExpense',
                color: Colors.orange,
              ),
              SizedBox(height: 20),

              // Deductible Amount
              _buildInfoCard(
                icon: Icons.money,
                title: 'Deductible Amount',
                value: '₹$deductibleAmount',
                color: Colors.blue,
              ),
              SizedBox(height: 20),

              // Taxable Income
              _buildInfoCard(
                icon: Icons.calculate,
                title: 'Taxable Income',
                value: '$taxableIncome',
                color: Colors.purple,
              ),
              SizedBox(height: 20),

              // Monthly Tax Owed
              ...monthlyIncomeData.map((item) {
                return _buildInfoCard(
                  icon: Icons.calendar_today,
                  title: item.month ?? 'N/A',
                  value: 'Tax: ₹${item.tax}',
                  color: Colors.teal,
                );
              }).toList(),

              // Yearly Tax Owed
              // SizedBox(height: 20),
              // Text(
              //   'Yearly Tax Owed',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 10),
              ...yearlyIncomeData.map((item) {
                return _buildInfoCard(
                  icon: Icons.calendar_today,
                  title: item.year.toString(),
                  value: 'Tax: ₹${item.tax}',
                  color: Colors.indigo,
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Info Card Widget
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 40),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fetch Data from Backend
  void _getData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/income_and_expense/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String status = responseData['status'];
        if (status == 'ok') {
          // Parse tax owed
          String taxOwedValue = responseData['tax_owed'].toString();

          // Parse total income, expense, deductible, and taxable income
          String totalIncomeValue = responseData['total_income'].toString();
          String totalExpenseValue = responseData['total_expense'].toString();
          String deductibleAmountValue = responseData['deductible'].toString();
          String taxableIncomeValue = responseData['taxable_income'].toString();



          setState(() {

            taxOwed = taxOwedValue;
            totalIncome = totalIncomeValue;
            totalExpense = totalExpenseValue;
            deductibleAmount = deductibleAmountValue;
            taxableIncome = taxableIncomeValue;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

class IncomeData {
  final String? month;
  final int? year;
  final double income;
  final double tax;

  IncomeData({
    this.month,
    this.year,
    required this.income,
    required this.tax,
  });
}