// import 'package:flutter/material.dart';
// import 'package:new_project/add_notifications.dart';
// import 'package:new_project/alert_notification.dart';
// import 'package:new_project/budget_management.dart';
// import 'package:new_project/change_password.dart';
// import 'package:new_project/enter_income_details_track.dart';
// import 'package:new_project/login.dart';
// import 'package:new_project/loginmain.dart';
// import 'package:new_project/manage_tax.dart';
// import 'package:new_project/recieve_tax_estimate.dart';
// import 'package:new_project/review.dart';
// import 'package:new_project/view_Profile.dart';
// import 'package:new_project/view_budget.dart';
// import 'package:new_project/view_expenses.dart';
// import 'package:new_project/view_experts.dart';
// import 'package:new_project/view_income.dart';
// import 'package:new_project/view_notification.dart';
// import 'package:new_project/view_suggestions.dart';
// import 'package:new_project/view_tax.dart';
// import 'Expenses.dart';
//
// void main() {
//   runApp(user_home_page());
// }
//
// class user_home_page extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Personal Finance Management '),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: Text(
//                   'Personal Finance Management',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text('Home'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.pop(context);
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.account_box),
//                 title: Text('Profile'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => ViewProfilePage(title: "Profile",),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.currency_rupee),
//                 title: Text('Income Details'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => enter_income_details_track(title: "Income Details",),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.currency_rupee),
//                 title: Text('View Income'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => viewincome(title: "View income",),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.password),
//                 title: Text('Change Password'),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => MyChangePasswordPage(title: "Change Password",),));
//                 },
//               ),
//               // ListTile(
//               //   leading: Icon(Icons.account_balance_wallet),
//               //   title: Text('Expenses'),
//               //   onTap: () {
//               //     Navigator.push(context, MaterialPageRoute(
//               //       builder: (context) => ExpensesPage(title: "Expenses",),));
//               //
//               //
//               //   },
//               // ),
//
//
//               ListTile(
//                 leading: Icon(Icons.account_balance_wallet),
//                 title: Text('View Expense'),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => viewexpense(title: " View Expense",),));
//
//
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.money),
//                 title: Text('Budget'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => BudgetManagement(title: "Budget Management",),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.money),
//                 title: Text('View budget'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => viewbudget(title: "Budget",),));
//                 },
//               ),
//
//
//               ListTile(
//                 leading: Icon(Icons.book),
//                 title: Text('Receive tax'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => receive_tax(title: "Receive tax",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.manage_accounts),
//                 title: Text('Manage tax'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => Manage_tax(title: "manage tax",),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.currency_rupee),
//                 title: Text('View tax'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => viewtax(title: "View tax",),));
//                 },
//               ),
//
//
//               ListTile(
//                 leading: Icon(Icons.notifications),
//                 title: Text('Notifications'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => alert_notification(title: "Notifications",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.notifications),
//                 title: Text('Add Notifications'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => Addnotification(title: "Add Notifications",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.notifications),
//                 title: Text('view Notifications'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => viewnotification(title: "View Notifications",),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.settings_suggest),
//                 title: Text('Suggestions'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => viewsuggestions(title: "Suggestions",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.reviews),
//                 title: Text('Reviews'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => expertreviews(title: "Reviews",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.reviews),
//                 title: Text('View Experts'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => viewexpert(title: "Experts",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.reviews),
//                 title: Text('Logout'),
//                 onTap: () {
//                   // Update the state of the app
//                   // ...
//                   // Then close the drawer
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => MyLogin(title: "Login",),));
//                 },
//               ),
//
//
//             ],
//           ),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//
//
//               // TextFormField(decoration: InputDecoration(border: OutlineInputBorder(),label: Text("ipaddress")),),
//               // ElevatedButton(onPressed: (){}, child: Text("connect"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:new_project/recieve_tax_estimate.dart';
import 'package:new_project/review.dart';
import 'package:new_project/view_Profile.dart';
import 'package:new_project/view_budget.dart';
import 'package:new_project/view_experts.dart';
import 'package:new_project/view_income.dart';
import 'package:new_project/view_notification.dart';
import 'package:new_project/view_suggestions.dart';
import 'package:new_project/view_tax.dart';
// import 'package:package_conf/add_notifications.dart';
// import 'package:pfm/alert_notification.dart';
// import 'package:pfm/budget_management.dart';
// import 'package:pfm/change_password.dart';
// import 'package:pfm/enter_income_details_track.dart';
// import 'package:pfm/login.dart';
// import 'package:pfm/loginmain.dart';
// import 'package:pfm/manage_tax.dart';
// import 'package:pfm/recieve_tax_estimate.dart';
// import 'package:pfm/review.dart';
// import 'package:pfm/view_Profile.dart';
// import 'package:pfm/view_budget.dart';
// import 'package:pfm/view_expenses.dart';
// import 'package:pfm/view_experts.dart';
// import 'package:pfm/view_income.dart';
// import 'package:pfm/view_notification.dart';
// import 'package:pfm/view_suggestions.dart';
// import 'package:pfm/view_tax.dart';
import 'Expenses.dart';
import 'add_notifications.dart';
import 'alert_notification.dart';
import 'budget_management.dart';
import 'change_password.dart';
import 'enter_income_details_track.dart';
import 'loginmain.dart';
import 'manage_tax.dart';

void main() {
  runApp(user_home_page());
}

class user_home_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personal Finance Management '),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Personal Finance Management',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.account_box),
                title: Text('Profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewProfilePage(title: "Profile",),));
                },
              ),

              ListTile(
                leading: Icon(Icons.currency_rupee),
                title: Text('Income Details'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => enter_income_details_track(title: "Income Details",),));
                },
              ),

              ListTile(
                leading: Icon(Icons.currency_rupee),
                title: Text('View Income'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => viewincome(title: "View income",),));
                },
              ),

              ListTile(
                leading: Icon(Icons.password),
                title: Text('Change Password'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyChangePasswordPage(title: "Change Password",),));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.account_balance_wallet),
              //   title: Text('Expenses'),
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(
              //       builder: (context) => ExpensesPage(title: "Expenses",),));
              //
              //
              //   },
              // ),


              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text('View Expense'),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) => viewexpense(title: " View Expense",),));
                  //

                },
              ),
              ListTile(
                leading: Icon(Icons.money),
                title: Text('Budget'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => BudgetManagement(title: "Budget Management",),));
                },
              ),

              ListTile(
                leading: Icon(Icons.money),
                title: Text('View budget'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => viewbudget(title: "Budget",),));
                },
              ),


              ListTile(
                leading: Icon(Icons.book),
                title: Text('Receive tax'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => receive_tax(title: "Receive tax",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.manage_accounts),
                title: Text('Manage tax'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Manage_tax(title: "manage tax",),));
                },
              ),

              ListTile(
                leading: Icon(Icons.currency_rupee),
                title: Text('View tax'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => viewtax(title: "View tax",),));
                },
              ),


              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => alert_notification(title: "Notifications",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Add Notifications'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Addnotification(title: "Add Notifications",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('view Notifications'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => viewnotification(title: "View Notifications",),));
                },
              ),

              ListTile(
                leading: Icon(Icons.settings_suggest),
                title: Text('Suggestions'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => viewsuggestions(title: "Suggestions",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.reviews),
                title: Text('Reviews'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => expertreviews(title: "Reviews",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.reviews),
                title: Text('View Experts'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => viewexpert(title: "Experts",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.reviews),
                title: Text('Logout'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyLogin(title: "Login",),));
                },
              ),


            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              // TextFormField(decoration: InputDecoration(border: OutlineInputBorder(),label: Text("ipaddress")),),
              // ElevatedButton(onPressed: (){}, child: Text("connect"))
            ],
          ),
        ),
      ),
    );
  }
}