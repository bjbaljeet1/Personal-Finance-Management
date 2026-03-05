

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const FinancialReportApp());
}

class FinancialReportApp extends StatelessWidget {
  const FinancialReportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Report',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FinancialReportPage(title: 'Financial Report'),
    );
  }
}

class FinancialReportPage extends StatefulWidget {
  const FinancialReportPage({super.key, required this.title});

  final String title;

  @override
  State<FinancialReportPage> createState() => _FinancialReportPageState();
}

class _FinancialReportPageState extends State<FinancialReportPage> {
  Map<String, dynamic> financialReport = {};
  bool isLoading = false;
  String selectedMonth = 'January';
  String selectedYear = '2023';

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> years = [
    '2021', '2022', '2023', '2024', '2025'
  ];

  Future<void> generateFinancialReport() async {
    setState(() {
      isLoading = true;
      financialReport = {}; // Clear previous report
    });

    try {
      // Fetch URL and LID from SharedPreferences
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();
      String? lid = sh.getString('lid');



      // Construct the API endpoint
      final urls = Uri.parse('$url/generate_financial_report/');


      final response = await http.post(urls, body: {
        'lid': lid, // Use LID from SharedPreferences
        'month': selectedMonth,
        'year': selectedYear,
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          financialReport = data['financial_report'];
        });
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data available for the specified month and year')),
        );
      } else {
        throw Exception('Failed to generate financial report');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Month Dropdown
            DropdownButton<String>(
              value: selectedMonth,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMonth = newValue!;
                });
              },
              items: months.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            // Year Dropdown
            DropdownButton<String>(
              value: selectedYear,
              onChanged: (String? newValue) {
                setState(() {
                  selectedYear = newValue!;
                });
              },
              items: years.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Generate Report Button
            ElevatedButton(
              onPressed: isLoading ? null : generateFinancialReport,
              child: const Text('Generate Financial Report'),
            ),
            const SizedBox(height: 20),
            // Loading Indicator
            if (isLoading)
              const Center(child: CircularProgressIndicator()),
            // Display Financial Report
            if (financialReport.isNotEmpty)
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      elevation: 8,
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Financial Report for ${financialReport['raw_data']['month']} ${financialReport['raw_data']['year']}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Text('Total Budget:\₹ ${financialReport['raw_data']['total_budget']}'),
                            Text('Total Expenses:\₹ ${financialReport['raw_data']['total_expenses']}'),
                            Text('Total Income:\₹ ${financialReport['raw_data']['total_income']}'),
                            Text('Savings:\₹ ${financialReport['raw_data']['savings']}'),
                            const SizedBox(height: 20),
                            const Text(
                              'Financial Analysis:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(financialReport['analysis']),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // No Data Message
            if (!isLoading && financialReport.isEmpty)
              const Center(
                child: Text(
                  'No financial report data available.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}