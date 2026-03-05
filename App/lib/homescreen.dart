//
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
//
// import 'package:http/http.dart' as http;
// import 'package:new_project/Expenses.dart';
// import 'package:new_project/budget_management.dart';
// import 'package:new_project/change_password.dart';
// import 'package:new_project/enter_income_details_track.dart';
// import 'package:new_project/loginmain.dart';
// import 'package:new_project/manage_tax.dart';
// import 'package:new_project/view%20investment%20advice.dart';
// import 'package:new_project/view_Profile.dart';
// import 'package:new_project/view_advice.dart';
// import 'package:new_project/view_budget.dart';
// import 'package:new_project/view_expenses.dart';
// import 'package:new_project/view_experts.dart';
// import 'package:new_project/view_income.dart';
// import 'package:new_project/view_notification.dart';
// import 'package:new_project/view_suggestions.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// void main() {
//   runApp(const HomeNew());
// }
//
// class HomeNew extends StatelessWidget {
//   const HomeNew({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Home',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
//             255, 234, 234, 234)),
//         useMaterial3: true,
//       ),
//       home: const user_home_new(title: 'Home'),
//     );
//   }
// }
//
// class user_home_new extends StatefulWidget {
//   const user_home_new({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<user_home_new> createState() => _user_home_newState();
// }
//
// class _user_home_newState extends State<user_home_new> {
//
//
//
//   String uname_="";
//   String uemail_="";
//   String uphoto_="";
//
//
//
//   _user_home_newState()
//   {
//     a();
//
//   }
//
//   a()
//   async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String imgurls = sh.getString('imgurl').toString();
//     String uname = sh.getString('name').toString();
//     // String uemail = sh.getString('uemail').toString();
//     String uphoto = imgurls+sh.getString('photo').toString();
//     // print(uphoto+"hloooooo");
//
//
//     setState(() {
//       uname_=uname;
//       // uemail_=uemail;
//       uphoto_=uphoto;
//     });
//
//
//   }
//
//
//   TextEditingController unameController = new TextEditingController();
//   TextEditingController passController = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     return WillPopScope(
//       onWillPop: () async{
//         Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin(title: 'LOGIN',),));
//         return false; },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 255, 255, 255),
//           title: Text(
//             widget.title,
//             style: TextStyle(color: Colors.black87), // Optional: Customize title color
//           ),
//           actions: [
//             TextButton.icon(
//               onPressed: () async {
//                 // Show a confirmation dialog before logging out
//                 bool shouldLogout = await showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text('Confirm Logout'),
//                       content: Text('Are you sure you want to log out?'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context, false); // User cancels logout
//                           },
//                           child: Text('Cancel'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context, true); // User confirms logout
//                           },
//                           child: Text(
//                             'Logout',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//                 if (shouldLogout == true) {
//                   // Proceed with logout
//                   // SharedPreferences prefs = await SharedPreferences.getInstance();
//                   // await prefs.clear(); // Clear stored data
//                   Fluttertoast.showToast(
//                     msg: "Logged out successfully",
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.BOTTOM,
//                   );
//
//                   // Redirect to the login page
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => MyLogin(title: 'LOGIN',)),
//                   );
//                 }
//               },
//               icon: Icon(Icons.logout, color: Colors.black87),
//               label: Text(
//                 "Logout",
//                 style: TextStyle(color: Colors.black87, fontSize: 14),
//               ),
//             )
//
//           ],
//         ),
//
//
//         // body:
//         // GridView.builder(
//         //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         //         maxCrossAxisExtent: 210,
//         //         childAspectRatio: 10/10,
//         //         crossAxisSpacing: 10,
//         //         mainAxisSpacing: 10,
//         //       mainAxisExtent: 180
//         //
//         //     ),
//         //     padding: const EdgeInsets.all(10.0),
//         //     itemCount: name_.length,
//         //     itemBuilder: (BuildContext ctx, index) {
//         //       return Container(
//         //         alignment: Alignment.center,
//         //         decoration: BoxDecoration(
//         //             color: Color.fromARGB(255, 53, 65, 68),
//         //             borderRadius: BorderRadius.circular(15)),
//         //         child:  Column(
//         //             children: [
//         //               SizedBox(height: 5.0),
//         //               InkWell(
//         //                 onTap: () async {
//         //                   final pref =await SharedPreferences.getInstance();
//         //                             pref.setString("did", id_[index]);
//         //                             Navigator.push(
//         //                               context,
//         //                               MaterialPageRoute(builder: (context) => ViewSchedule()),);
//         //                             },
//         //                 child: CircleAvatar(
//         //                 radius: 45,backgroundImage: NetworkImage(photo_[index])),
//         //                 ),
//         //               // SizedBox(height: 5.0),
//         //                // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
//         //               Column(
//         //                 children: [
//         //                   Padding(
//         //                     padding: EdgeInsets.all(1),
//         //                     child: Text(name_[index],style: TextStyle(color: Colors.white,fontSize: 18)),
//         //                   ),],
//         //
//         //               ),
//         //               Column(
//         //                 children: [
//         //                   Padding(
//         //                     padding: EdgeInsets.all(0),
//         //                     child: Text(phone_[index],style: TextStyle(color: Colors.white)),
//         //                   ),
//         //                 Padding(
//         //                     padding: EdgeInsets.all(0),
//         //                     child: Text(qualification_[index],style: TextStyle(color: Colors.white)),
//         //                   ),
//         //         ],
//         //               ),
//         //               // Column(
//         //               //   children: [
//         //               //     Padding(
//         //               //       padding: EdgeInsets.all(1),
//         //               //       child: Text(gender_[index],style: TextStyle(color: Colors.white)),
//         //               //     ),
//         //               //     ],
//         //               // ),
//         //             ]
//         //         )
//         //       );
//         //     }),
//
//
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Welcome Widget
//             Container(
//               margin: const EdgeInsets.all(16.0),
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//                 gradient: LinearGradient(
//                   colors: [Colors.orange.shade300, Colors.white],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: InkWell(onTap: (){
//                 // Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppProfilr(),));
//
//               },
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Welcome ${uname_}",
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "GETMEHELP",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white70,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           // Text(
//                           //   "Hi ${uname_}",
//                           //   style: TextStyle(
//                           //     fontSize: 18,
//                           //     color: Colors.white,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: CircleAvatar(
//                           radius: 55,
//                           backgroundImage:NetworkImage(uphoto_,
//                             // fit: BoxFit.cover,
//                             // height: 100,
//                             // width: 100,
//                           )
//
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Navigation Cards
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 5,
//                 padding: const EdgeInsets.all(10.0),
//                 children: [
//
//
//
//                   buildNavigationCard(
//                     context,
//                     title: "Profile",
//                     image: "assets/pro.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(title: "Profile"),)
//
//                       );
//                     },
//                   ),
//
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Edit Profile",
//                   //   image: "assets/reset-password.png",
//                   //   onTap: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyChangePasswordPage(title: " Change Password",),));
//                   //
//                   //   },
//                   // ),
//                   buildNavigationCard(
//                     context,
//                     title: "Income Details",
//                     image: "assets/income.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => enter_income_details_track(title: " Income Details",),));
//
//                     },
//                   ),
//
//                   buildNavigationCard(
//                     context,
//                     title: "Budget ",
//                     image: "assets/bud.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetManagement(title: " Budget Management",),));
//
//                     },
//                   ),
//
//
//                   buildNavigationCard(
//                     context,
//                     title: "View Expenses",
//                     image: "assets/expenses.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => viewexpense(title: "View Expenses ",),));
//
//                     },
//                   ),
//
//
//
//
//
//                   buildNavigationCard(
//                     context,
//                     title: "View Income",
//                     image: "assets/incomee.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => viewincome(title: " View Income",),));
//
//                     },
//                   ),
//                   buildNavigationCard(
//                     context,
//                     title: "View Advice",
//                     image: "assets/incomee.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => view_advice(title: " View Advice",),));
//
//                     },
//                   ),
//                   buildNavigationCard(
//                     context,
//                     title: "View investment",
//                     image: "assets/incomee.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => view_advice_investemnt(title: " View investment Advice",),));
//
//                     },
//                   ),
//
//
//                   buildNavigationCard(
//                     context,
//                     title: "View Budget",
//                     image: "assets/vbudget.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => viewbudget(title: " View Budget",),));
//
//                     },
//                   ),
//
//                   buildNavigationCard(
//                     context,
//                     title: "Suggestions",
//                     image: "assets/sugg.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => viewsuggestions(title: " View Suggestions",),));
//
//                     },
//                   ),
//
//                   buildNavigationCard(
//                     context,
//                     title: "View Experts",
//                     image: "assets/experts.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => viewexpert(title: "Experts ",),));
//
//                     },
//                   ),
//
//
//                   buildNavigationCard(
//                     context,
//                     title: "Manage tax",
//                     image: "assets/tax.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_tax(title: " Manage tax",),));
//
//                     },
//                   ),
//
//                   buildNavigationCard(
//                     context,
//                     title: "Notifications",
//                     image: "assets/noti.png",
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => viewnotification(title: "Notification ",),));
//
//                     },
//                   ),
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Pi Chart",
//                   //   image: "assets/expenses.png",
//                   //   onTap: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => viewexpense(title: "View Expenses ",),));
//                   //
//                   //   },
//                   // ),
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Addexpence",
//                   //   image: "assets/noti.png",
//                   //   onTap: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => ExpensesPage(title: "Notification ",),));
//                   //
//                   //   },
//                   // ),
//
//
//
//
//
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Editprofile",
//                   //   image: "assets/doctor.png",
//                   //   onTap: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (context) => UserEditProfile(title: ""),
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//
//
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Registration",
//                   //   image: "assets/booking.png",
//                   //   onTap: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistration(title: "Registration",),));
//                   //
//                   //   },
//                   // ),
//
//
//
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: " Help",
//                   //   image: "assets/booking.png",
//                   //   onTap: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => RequestedHelp(title: " Requested Help",),));
//                   //
//                   //   },
//                   // ),
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Complaint",
//                   //   image: "assets/complaint.png",
//                   //   onTap: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (context) => SendComplaint(title: "Send Complaint"),
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Feedback",
//                   //   image: "assets/feedback.png",
//                   //   onTap: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => SendFeedback(title: "Send Feedback",),));
//                   //   },
//                   // ),
//                   //
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Reply",
//                   //   image: "assets/reply.png",
//                   //   onTap: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReplay(title: " View Reply",),));
//                   //   },
//                   // ),
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Architectures",
//                   //   image: "assets/engi.png",
//                   //   onTap: () async {
//                   //
//                   //     SharedPreferences sh= await SharedPreferences.getInstance();
//                   //     sh.setString("type", "Architecture");
//                   //
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewService(title: "viewservice"),));
//                   //   },
//                   // ),
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Mechanic",
//                   //   image: "assets/mech.png",
//                   //   onTap: () async {
//                   //     SharedPreferences sh= await SharedPreferences.getInstance();
//                   //     sh.setString("type", "Mechanic");
//                   //
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewService(title: "viewservice"),));
//                   //   },
//                   // ),
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Cleaning",
//                   //   image: "assets/household.png",
//                   //   onTap: () async {
//                   //     SharedPreferences sh= await SharedPreferences.getInstance();
//                   //     sh.setString("type", "cleaning");
//                   //
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewService(title: "viewservice"),));
//                   //   },
//                   // ),
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Electrical",
//                   //   image: "assets/engineering.png",
//                   //   onTap: () async {
//                   //     SharedPreferences sh= await SharedPreferences.getInstance();
//                   //     sh.setString("type", "electrical");
//                   //
//                   //
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewService(title: "viewservice"),));
//                   //   },                  ),
//                   //
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "Booking",
//                   //   image: "assets/online-booking.png",
//                   //   onTap: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => user_booking_status(title: "Booking Status",),));
//                   //   },
//                   // ),
//
//
//                   //
//                   // buildNavigationCard(
//                   //   context,
//                   //   title: "AI",
//                   //   image: "assets/chat-gpt.png",
//                   //   onTap: () {
//                   //     Navigator.push(
//                   //         context,
//                   //         MaterialPageRoute(builder: (context) => ChatScreen(title: '',),
//                   //         ));
//                   //
//                   //
//                   //   },
//                   //
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//
//
//
//
//
//         // drawer: Drawer(
//         //   child: ListView(
//         //     padding: EdgeInsets.zero,
//         //     children: [
//         //        DrawerHeader(
//         //         decoration: BoxDecoration(
//         //           color: Color.fromARGB(255, 255, 255, 255),
//         //         ),
//         //         child:
//         //         Column(children: [
//         //
//         //           Text(
//         //             'Covid-19',
//         //             style: TextStyle(fontSize: 15,color: Colors.white),
//         //
//         //           ),
//         //           CircleAvatar(radius: 29,backgroundImage: NetworkImage(uphoto_)),
//         //           Text(uname_,style: TextStyle(color: Colors.white)),
//         //           // Text(uemail_,style: TextStyle(color: Colors.white)),
//         //         ]),
//         //       ),
//         //       ListTile(
//         //         leading: Icon(Icons.home),
//         //         title: const Text('Home'),
//         //         onTap: () {
//         //           Navigator.pop(context);
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
//         //         },
//         //       ),
//         //       ListTile(
//         //         leading: Icon(Icons.person_pin),
//         //         title: const Text(' View Profile '),
//         //         onTap: () {
//         //           Navigator.pop(context);
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppProfilr(),));
//         //         },
//         //       ),
//         //       // ListTile(
//         //       //   leading: Icon(Icons.upload),
//         //       //   title: const Text('Heart Disease'),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => Heart_disease_page(),));
//         //       //   },
//         //       // ),
//         //       // ListTile(
//         //       //   leading: Icon(Icons.upload),
//         //       //   title: const Text('Pnuemonia'),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => Pnuemonia_Detect_Page(title: '',),));
//         //       //   },
//         //       // ),
//         //       // ListTile(
//         //       //   leading: Icon(Icons.upload),
//         //       //   title: const Text('Covid'),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => Covide_Detect_Page(),));
//         //       //   },
//         //       // ),
//         //       // ListTile(
//         //       //   leading: Icon(Icons.upload),
//         //       //   title: const Text('Parkinson'),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => PD_Detect_Page(),));
//         //       //   },
//         //       // ),
//         //
//         //       // ListTile(
//         //       //   leading: Icon(Icons.coronavirus),
//         //       //   title: const Text(' View Disease '),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => View_Disease_page(title: 'View Disease',),));
//         //       //   },
//         //       // ),
//         //       // ListTile(
//         //       //   leading: Icon(Icons.person_pin_outlined),
//         //       //   title: const Text(' View Doctors '),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDoctors(title: "Doctors",),));
//         //       //   },
//         //       // ),
//         //       // ListTile(
//         //       //   leading: Icon(Icons.book_outlined),
//         //       //   title: const Text(' View Booking Details '),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewBookingDetailsPage(title: "Booking Details",),));
//         //       //   },
//         //       // ),
//         //       // ListTile(
//         //       //   leading: Icon(Icons.upload),
//         //       //   title: const Text('Predict'),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => Myuploadpage(title: 'Predict'),));
//         //       //   },
//         //       // ),
//         //       // ListTile(
//         //       //   leading: Icon(Icons.medical_services_outlined),
//         //       //   title: const Text(' View Test Details '),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyResult(),));
//         //       //   },
//         //       // ),
//         //
//         //       ListTile(
//         //         leading: Icon(Icons.feed_outlined),
//         //         title: const Text('Complaint '),
//         //         onTap: () {
//         //           Navigator.pop(context);
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReplyPage(title: "View Complaint",),));
//         //         },
//         //       ),
//         //       // // ListTile(
//         //       //   leading: Icon(Icons.feed_outlined),
//         //       //   title: const Text('Feedback '),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => MySendFeedback(),));
//         //       //   },
//         //       // ),
//         //
//         //       ListTile(
//         //         leading: Icon(Icons.change_circle),
//         //         title: const Text(' Change Password '),
//         //         onTap: () {
//         //           Navigator.pop(context);
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) => MyChangePasswordPage(title: "Change Password",),));
//         //         },
//         //       ),
//         //       ListTile(
//         //         leading: Icon(Icons.logout),
//         //         title: const Text('LogOut'),
//         //         onTap: () {
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin(),));
//         //         },
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         // drawer: Drawer(
//         //   child: ListView(
//         //     padding: EdgeInsets.zero,
//         //     children: [
//         //       // Drawer Header
//         //       DrawerHeader(
//         //         decoration: BoxDecoration(
//         //           gradient: LinearGradient(
//         //             colors: [Colors.blueAccent, Colors.lightBlueAccent],
//         //             begin: Alignment.topLeft,
//         //             end: Alignment.bottomRight,
//         //           ),
//         //         ),
//         //         child: Column(
//         //           mainAxisAlignment: MainAxisAlignment.center,
//         //           children: [
//         //             CircleAvatar(
//         //               radius: 35,
//         //               backgroundImage: NetworkImage(uphoto_),
//         //             ),
//         //             SizedBox(height: 10),
//         //             Text(
//         //               uname_,
//         //               style: TextStyle(
//         //                 fontSize: 18,
//         //                 fontWeight: FontWeight.bold,
//         //                 color: Colors.white,
//         //               ),
//         //             ),
//         //             Text(
//         //               'Covid-19',
//         //               style: TextStyle(fontSize: 14, color: Colors.white70),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //
//         //       // Drawer Items
//         //       ListTile(
//         //         leading: Icon(Icons.home, color: Colors.blueAccent),
//         //         title: Text(
//         //           'Home',
//         //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         //         ),
//         //         onTap: () {
//         //           Navigator.pop(context);
//         //           Navigator.push(
//         //             context,
//         //             MaterialPageRoute(builder: (context) => HomeNew()),
//         //           );
//         //         },
//         //       ),
//         //       Divider(),
//         //
//         //       ListTile(
//         //         leading: Icon(Icons.person_pin, color: Colors.orangeAccent),
//         //         title: Text(
//         //           'View Profile',
//         //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         //         ),
//         //         onTap: () {
//         //           Navigator.pop(context);
//         //           Navigator.push(
//         //             context,
//         //             MaterialPageRoute(builder: (context) => MyAppProfilr()),
//         //           );
//         //         },
//         //       ),
//         //       // ListTile(
//         //       //   leading: Icon(Icons.person_pin, color: Colors.orangeAccent),
//         //       //   title: Text(
//         //       //     'Prescription',
//         //       //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         //       //   ),
//         //       //   onTap: () {
//         //       //     Navigator.pop(context);
//         //       //     Navigator.push(
//         //       //       context,
//         //       //       MaterialPageRoute(builder: (context) => ViewPrescriptionPage(title: "")),
//         //       //     );
//         //       //   },
//         //       // ),
//         //       Divider(),
//         //
//         //       ListTile(
//         //         leading: Icon(Icons.feed_outlined, color: Colors.green),
//         //         title: Text(
//         //           'Complaint',
//         //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         //         ),
//         //         onTap: () {
//         //           Navigator.pop(context);
//         //           Navigator.push(
//         //             context,
//         //             MaterialPageRoute(
//         //               builder: (context) => ViewReplyPage(title: "View Complaint"),
//         //             ),
//         //           );
//         //         },
//         //       ),
//         //       Divider(),
//         //
//         //       ListTile(
//         //         leading: Icon(Icons.change_circle, color: Colors.purple),
//         //         title: Text(
//         //           'Change Password',
//         //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         //         ),
//         //         onTap: () {
//         //           Navigator.pop(context);
//         //           Navigator.push(
//         //             context,
//         //             MaterialPageRoute(
//         //               builder: (context) =>
//         //                   MyChangePasswordPage(title: "Change Password"),
//         //             ),
//         //           );
//         //         },
//         //       ),
//         //       Divider(),
//         //
//         //       ListTile(
//         //         leading: Icon(Icons.logout, color: Colors.red),
//         //         title: Text(
//         //           'LogOut',
//         //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         //         ),
//         //         onTap: () {
//         //           Navigator.push(
//         //             context,
//         //             MaterialPageRoute(builder: (context) => MyLogin()),
//         //           );
//         //         },
//         //       ),
//         //     ],
//         //   ),
//         // ),
//
//       ),
//     );
//   }
//
//   Widget buildNavigationCard(BuildContext context, {
//     required String title,
//     required String image,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 6,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               image,
//               height: 60,
//               width: 60,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//
// // void _send_data() async{
// //
// //
// //   String uname=unameController.text;
// //   String password=passController.text;
// //
// //
// //   SharedPreferences sh = await SharedPreferences.getInstance();
// //   String url = sh.getString('url').toString();
// //
// //   final urls = Uri.parse('$url/myapp/user_loginpost/');
// //   try {
// //     final response = await http.post(urls, body: {
// //       'name':uname,
// //       'password':password,
// //
// //
// //     });
// //     if (response.statusCode == 200) {
// //       String status = jsonDecode(response.body)['status'];
// //       if (status=='ok') {
// //         String lid=jsonDecode(response.body)['lid'];
// //         sh.setString("lid", lid);
// //         // Navigator.push(context, MaterialPageRoute(
// //         //   builder: (context) =>
// //         //   (title: "Home"),));
// //       }
// //       else {
// //         Fluttertoast.showToast(msg: 'Not Found');
// //       }
// //     }
// //     else {
// //       Fluttertoast.showToast(msg: 'Network Error');
// //     }
// //   }
// //   catch (e){
// //     Fluttertoast.showToast(msg: e.toString());
// //   }
// // }
//
//
//
// }



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/review.dart';
import 'package:new_project/view%20complaint%20replay.dart';
import 'package:new_project/view_Profile.dart';
import 'package:new_project/view_budget.dart';
import 'package:new_project/view_expenses.dart';
import 'package:new_project/view_experts.dart';
import 'package:new_project/view_income.dart';
import 'package:new_project/view_notification.dart';
import 'package:new_project/view_suggestions.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FinancialReportPage.dart';
import 'budget_management.dart';
import 'change_password.dart';
import 'enter_income_details_track.dart';
import 'expertreviews.dart';
import 'loginmain.dart';
import 'manage_tax.dart';


//
//
// void main() {
//   runApp(const HomeNew());
// }
//
// class HomeNew extends StatelessWidget {
//   const HomeNew({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Home',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
//         useMaterial3: true,
//       ),
//       home: const user_home_new(title: 'Home'),
//     );
//   }
// }
//
// class user_home_new extends StatefulWidget {
//   const user_home_new({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<user_home_new> createState() => _user_home_newState();
// }
//
// class _user_home_newState extends State<user_home_new> {
//   String uname_ = "";
//   String uphoto_ = "";
//   double totalIncome = 0;
//   double totalExpenses = 0;
//   double totalBudget = 0;
//   List<MapEntry<String, double>> monthlyExpenses = [];
//   String selectedMonth = DateTime.now().month.toString();
//   String selectedYear = DateTime.now().year.toString();
//   List<String> months = [
//     'January', 'February', 'March', 'April', 'May', 'June',
//     'July', 'August', 'September', 'October', 'November', 'December'
//   ];
//   List<String> years = ['2023', '2024', '2025'];
//   bool isLoading = false;
//   bool noDataFound = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     fetchDashboardSummary();
//     fetchMonthlyExpenses();
//   }
//
//   Future<void> fetchUserData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String imgurls = sh.getString('imgurl').toString();
//     String uname = sh.getString('name').toString();
//     String uphoto = imgurls + sh.getString('photo').toString();
//
//     setState(() {
//       uname_ = uname;
//       uphoto_ = uphoto;
//     });
//   }
//
//   Future<void> fetchDashboardSummary() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final response = await http.post(
//       Uri.parse('$url/dashboard_summary/'),
//       body: {'lid': lid},
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         totalIncome = data['total_income'];
//         totalExpenses = data['total_expenses'];
//         totalBudget = data['total_budget'];
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   Future<void> fetchMonthlyExpenses() async {
//     setState(() {
//       isLoading = true;
//       noDataFound = false;
//     });
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final response = await http.post(
//       Uri.parse('$url/monthly_expense_graph/'),
//       body: {
//         'lid': lid,
//         'year': selectedYear,
//         'month': selectedMonth,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data.isEmpty) {
//         setState(() {
//           noDataFound = true;
//         });
//       } else {
//         Map<String, double> expenseData = Map<String, double>.from(data);
//         setState(() {
//           monthlyExpenses = expenseData.entries.toList();
//         });
//       }
//     } else {
//       throw Exception('Failed to load data');
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   void _showExpenseDetailsPopup(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Monthly Expense Breakdown',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           content: Container(
//             width: double.maxFinite,
//             height: 400,
//             child: Column(
//               children: [
//                 // Bar Chart for Expenses
//                 Container(
//                   height: 150,
//                   child: SfCartesianChart(
//                     primaryXAxis: CategoryAxis(),
//                     series: <CartesianSeries<MapEntry<String, double>, String>>[
//                       BarSeries<MapEntry<String, double>, String>(
//                         dataSource: monthlyExpenses,
//                         xValueMapper: (MapEntry<String, double> entry, _) => entry.key,
//                         yValueMapper: (MapEntry<String, double> entry, _) => entry.value,
//                         color: Colors.orange,
//                         dataLabelSettings: DataLabelSettings(isVisible: true),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Pie Chart for Income, Expenses, and Budget
//                 Container(
//                   height: 150,
//                   child: SfCircularChart(
//                     legend: Legend(isVisible: true),
//                     series: <CircularSeries>[
//                       PieSeries<MapEntry<String, double>, String>(
//                         dataSource: [
//                           MapEntry('Income', totalIncome),
//                           MapEntry('Expenses', totalExpenses),
//                           MapEntry('Budget', totalBudget),
//                         ],
//                         xValueMapper: (MapEntry<String, double> entry, _) => entry.key,
//                         yValueMapper: (MapEntry<String, double> entry, _) => entry.value,
//                         dataLabelSettings: DataLabelSettings(isVisible: true),
//                         pointColorMapper: (MapEntry<String, double> entry, _) {
//                           switch (entry.key) {
//                             case 'Income':
//                               return Colors.green;
//                             case 'Expenses':
//                               return Colors.red;
//                             case 'Budget':
//                               return Colors.blue;
//                             default:
//                               return Colors.grey;
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'Close',
//                 style: TextStyle(color: Colors.orange),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//
//       Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin(title: 'LOGIN')));
//       return false;
//     },
//     child: Scaffold(
//     // appBar: AppBar(
//     //   backgroundColor: Colors.orange,
//     //   title: Text(
//     //     widget.title,
//     //     style: TextStyle(color: Colors.white),
//     //   ),
//     //   actions: [
//     //     IconButton(
//     //       icon: Icon(Icons.logout, color: Colors.white),
//     //       onPressed: () async {
//     //         bool shouldLogout = await showDialog(
//     //           context: context,
//     //           builder: (BuildContext context) {
//     //             return AlertDialog(
//     //               title: Text('Confirm Logout'),
//     //               content: Text('Are you sure you want to log out?'),
//     //               actions: [
//     //                 TextButton(
//     //                   onPressed: () {
//     //                     Navigator.pop(context, false);
//     //                   },
//     //                   child: Text('Cancel'),
//     //                 ),
//     //                 TextButton(
//     //                   onPressed: () {
//     //                     Navigator.pop(context, true);
//     //                   },
//     //                   child: Text(
//     //                     'Logout',
//     //                     style: TextStyle(color: Colors.red),
//     //                   ),
//     //                 ),
//     //               ],
//     //             );
//     //           },
//     //         );
//     //         if (shouldLogout == true) {
//     //           Fluttertoast.showToast(
//     //             msg: "Logged out successfully",
//     //             toastLength: Toast.LENGTH_SHORT,
//     //             gravity: ToastGravity.BOTTOM,
//     //           );
//     //           Navigator.push(
//     //             context,
//     //             MaterialPageRoute(builder: (context) => MyLogin(title: 'LOGIN')),
//     //           );
//     //         }
//     //       },
//     //     ),
//     //   ],
//     // ),
//
//     appBar: AppBar(
//     backgroundColor: Colors.orange,
//     title: Text(
//     widget.title,
//     style: TextStyle(color: Colors.white),
//     ),
//     automaticallyImplyLeading: false, // Remove the default back button
//       iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
//       actions: [
//         IconButton(
//           icon: Icon(Icons.logout),
//           onPressed: () async {
//             bool shouldLogout = await showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text('Confirm Logout'),
//                   content: Text('Are you sure you want to log out?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context, false);
//                       },
//                       child: Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context, true);
//                       },
//                       child: Text(
//                         'Logout',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//             if (shouldLogout == true) {
//               Fluttertoast.showToast(
//                 msg: "Logged out successfully",
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.BOTTOM,
//               );
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MyLogin(title: 'LOGIN')),
//               );
//             }
//           },
//         ),
//       ],
//     ),
//         body: SingleChildScrollView(
//         child: Padding(
//         padding: const EdgeInsets.all(16.0),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//       // Welcome Section
//       Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.orange, Colors.orangeAccent],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 40,
//             backgroundImage: NetworkImage(uphoto_),
//           ),
//           SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Welcome, $uname_",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 "Manage your finances\n efficiently",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white70,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     SizedBox(height: 20),
//
//     // Month and Year Selector
//     Row(
//     children: [
//     Expanded(
//     child: DropdownButton<String>(
//     value: selectedMonth,
//     onChanged: (String? newValue) {
//     setState(() {
//     selectedMonth = newValue!;
//     });
//     },
//     items: months.map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//     value: (months.indexOf(value) + 1).toString(),
//     child: Text(value),
//     );
//     }).toList(),
//     ),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//     child: DropdownButton<String>(
//     value: selectedYear,
//     onChanged: (String? newValue) {
//     setState(() {
//     selectedYear = newValue!;
//     });
//     },
//     items: years.map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//     value: value,
//     child: Text(value),
//     );
//     }).toList(),
//     ),
//     ),
//     ],
//     ),
//     SizedBox(height: 10),
//     Center(
//     child: ElevatedButton(
//     onPressed: fetchMonthlyExpenses,
//     style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.orange,
//     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//     ),
//     child: Text(
//     'Search',
//     style: TextStyle(color: Colors.white),
//     ),
//     ),
//     ),
//     SizedBox(height: 20),
//             // Display Data or No Data Message
//             if (isLoading)
//         Center(child: CircularProgressIndicator())
//     else if (noDataFound)
//     Center(
//     child: Text(
//     'No data available for the selected month and year.',
//     style: TextStyle(fontSize: 16, color: Colors.red),
//     ),
//     )
//     else
//     Column(
//     children: [
//     // Pie Chart for Income, Expenses, and Budget
//     Container(
//     padding: EdgeInsets.all(16),
//     decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(15),
//     boxShadow: [
//     BoxShadow(
//     color: Colors.black26,
//     blurRadius: 10,
//     offset: Offset(0, 4),
//     ),
//     ],
//     ),
//     child: Column(
//     children: [
//     Text(
//     'Financial Overview',
//     style: TextStyle(
//     fontSize: 20,
//     fontWeight: FontWeight.bold,
//     ),
//     ),
//     SizedBox(height: 10),
//     Container(
//     height: 200,
//     child: SfCircularChart(
//     legend: Legend(isVisible: true),
//     series: <CircularSeries>[
//     PieSeries<MapEntry<String, double>, String>(
//     dataSource: [
//     MapEntry('Income', totalIncome),
//     MapEntry('Expenses', totalExpenses),
//     MapEntry('Budget', totalBudget),
//     ],
//     xValueMapper: (MapEntry<String, double> entry, _) => entry.key,
//     yValueMapper: (MapEntry<String, double> entry, _) => entry.value,
//     dataLabelSettings: DataLabelSettings(isVisible: true),
//     pointColorMapper: (MapEntry<String, double> entry, _) {
//     switch (entry.key) {
//     case 'Income':
//     return Colors.green;
//     case 'Expenses':
//     return Colors.red;
//     case 'Budget':
//     return Colors.blue;
//     default:
//     return Colors.grey;
//     }
//     },
//     ),
//     ],
//     ),
//     ),
//     ],
//     ),
//     ),
//     SizedBox(height: 20),
//       // Summary Cards
//       Row(
//         children: [
//           Expanded(
//             child: _buildSummaryCard('Income', totalIncome, Colors.green),
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: _buildSummaryCard('Expenses', totalExpenses, Colors.red),
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: _buildSummaryCard('Budget', totalBudget, Colors.blue),
//           ),
//         ],
//       ),
//       SizedBox(height: 20),
//     ],
//     ),
//
//             // Navigation Grid
//             GridView.count(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               crossAxisCount: 3,
//               children: [
//                 _buildNavigationCard(Icons.person, 'Profile', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(title: "Profile")));
//                 }),
//                 _buildNavigationCard(Icons.attach_money, 'Income', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => enter_income_details_track(title: "Income Details")));
//                 }),
//                 _buildNavigationCard(Icons.account_balance_wallet, 'Budget', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetManagement(title: "Budget Management")));
//                 }),
//                 _buildNavigationCard(Icons.shopping_cart, 'Expenses', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => viewexpense(title: "View Expenses")));
//                 }),
//                 _buildNavigationCard(Icons.money, 'Income', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => viewincome(title: "View Income")));
//                 }),
//                 _buildNavigationCard(Icons.bar_chart, 'Budget', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => viewbudget(title: "View Budget")));
//                 }),
//                 _buildNavigationCard(Icons.lightbulb, 'Suggestions', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => viewsuggestions(title: "View Suggestions")));
//                 }),
//                 _buildNavigationCard(Icons.people, 'Experts', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => viewexpert(title: "Experts")));
//                 }),
//                 _buildNavigationCard(Icons.receipt, 'Tax', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_tax(title: "Manage Tax")));
//                 }),
//                 _buildNavigationCard(Icons.notifications, 'Notifications', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => viewnotification(title: "Notifications")));
//                 }),
//                 _buildNavigationCard(Icons.report, 'Finance', () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => FinancialReportPage(title: "Finance Report")));
//                 }),
//               ],
//             ),
//           ],
//       ),
//         ),
//         ),
//     ),
//     );
//   }
//   Widget _buildSummaryCard(String title, double value, Color color) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '\$${value.toStringAsFixed(2)}',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavigationCard(IconData icon, String label, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: Colors.orange),
//             SizedBox(height: 10),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const HomeNew());
}

class HomeNew extends StatelessWidget {
  const HomeNew({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const user_home_new(title: 'Home'),
    );
  }
}

class user_home_new extends StatefulWidget {
  const user_home_new({super.key, required this.title});

  final String title;

  @override
  State<user_home_new> createState() => _user_home_newState();
}

class _user_home_newState extends State<user_home_new> {

  String name_ = "";
  String Photo_ = "";

  String DOB_ = "";
  String Gender_ = "";
  String Email_ = "";
  String Contact_ = "";
  String Place_ = "";
  String Post_ = "";
  String Pin_ = "";
  String District_ = "";




  String uname_ = "";
  String uphoto_ = "";
  double totalIncome = 0;
  double totalExpenses = 0;
  double totalBudget = 0;
  List<MapEntry<String, double>> monthlyExpenses = [];
  String selectedMonth = DateTime.now().month.toString();
  String selectedYear = DateTime.now().year.toString();
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  List<String> years = ['2023', '2024', '2025'];
  bool isLoading = false;
  bool noDataFound = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchDashboardSummary();
    fetchMonthlyExpenses();
    _send_data();
  }

  Future<void> fetchUserData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String imgurls = sh.getString('imgurl').toString();
    String uname = sh.getString('uname').toString();
    String uphoto = imgurls + sh.getString('uphoto').toString();

    setState(() {
      uname_ = uname;
      uphoto_ = uphoto;
    });
  }

  Future<void> fetchDashboardSummary() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final response = await http.post(
      Uri.parse('$url/dashboard_summary/'),
      body: {'lid': lid},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        totalIncome = data['total_income'];
        totalExpenses = data['total_expenses'];
        totalBudget = data['total_budget'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchMonthlyExpenses() async {
    setState(() {
      isLoading = true;
      noDataFound = false;
    });

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final response = await http.post(
      Uri.parse('$url/monthly_expense_graph/'),
      body: {
        'lid': lid,
        'year': selectedYear,
        'month': selectedMonth,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isEmpty) {
        setState(() {
          noDataFound = true;
        });
      } else {
        Map<String, double> expenseData = Map<String, double>.from(data);
        setState(() {
          monthlyExpenses = expenseData.entries.toList();
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
    setState(() {
      isLoading = false;
    });
  }

  void _showExpenseDetailsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Monthly Expense Breakdown',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: Column(
              children: [
                // Bar Chart for Expenses
                Container(
                  height: 150,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries<MapEntry<String, double>, String>>[
                      BarSeries<MapEntry<String, double>, String>(
                        dataSource: monthlyExpenses,
                        xValueMapper: (MapEntry<String, double> entry, _) => entry.key,
                        yValueMapper: (MapEntry<String, double> entry, _) => entry.value,
                        color: Colors.orange,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Pie Chart for Income, Expenses, and Budget
                Container(
                  height: 150,
                  child: SfCircularChart(
                    legend: Legend(isVisible: true),
                    series: <CircularSeries>[
                      PieSeries<MapEntry<String, double>, String>(
                        dataSource: [
                          MapEntry('Income', totalIncome),
                          MapEntry('Expenses', totalExpenses),
                          MapEntry('Budget', totalBudget),
                        ],
                        xValueMapper: (MapEntry<String, double> entry, _) => entry.key,
                        yValueMapper: (MapEntry<String, double> entry, _) => entry.value,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        pointColorMapper: (MapEntry<String, double> entry, _) {
                          switch (entry.key) {
                            case 'Income':
                              return Colors.green;
                            case 'Expenses':
                              return Colors.red;
                            case 'Budget':
                              return Colors.blue;
                            default:
                              return Colors.grey;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin(title: 'LOGIN')));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                bool shouldLogout = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Logout'),
                      content: Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
                if (shouldLogout == true) {
                  Fluttertoast.showToast(
                    msg: "Logged out successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (context) => MyLogin(title: 'LOGIN')),
                  );
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(Photo_),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Manage your finances\n efficiently",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Month and Year Selector
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedMonth,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMonth = newValue!;
                          });
                        },
                        items: months.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: (months.indexOf(value) + 1).toString(),
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButton<String>(
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
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: fetchMonthlyExpenses,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Display Data or No Data Message
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else if (noDataFound)
                  Center(
                    child: Text(
                      'No data available for the selected month and year.',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  )
                else
                  Column(
                    children: [
                      // Pie Chart for Income, Expenses, and Budget
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Financial Overview',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 200,
                              child: SfCircularChart(
                                legend: Legend(isVisible: true),
                                series: <CircularSeries>[
                                  PieSeries<MapEntry<String, double>, String>(
                                    dataSource: [
                                      MapEntry('Income', totalIncome),
                                      MapEntry('Expenses', totalExpenses),
                                      MapEntry('Budget', totalBudget),
                                    ],
                                    xValueMapper: (MapEntry<String, double> entry, _) => entry.key,
                                    yValueMapper: (MapEntry<String, double> entry, _) => entry.value,
                                    dataLabelMapper: (MapEntry<String, double> entry, _) => '₹${entry.value}', // Add ₹ symbol
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                    pointColorMapper: (MapEntry<String, double> entry, _) {
                                      switch (entry.key) {
                                        case 'Income':
                                          return Colors.green;
                                        case 'Expenses':
                                          return Colors.red;
                                        case 'Budget':
                                          return Colors.blue;
                                        default:
                                          return Colors.grey;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Summary Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard('Income', totalIncome, Colors.green),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildSummaryCard('Expenses', totalExpenses, Colors.red),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildSummaryCard('Budget', totalBudget, Colors.blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),

                // Navigation Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: [
                    _buildNavigationCard(Icons.person, 'Profile', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(title: "Profile")));
                    }),
                    _buildNavigationCard(Icons.currency_rupee, 'Income', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => enter_income_details_track(title: "Income Details")));
                    }),
                    _buildNavigationCard(Icons.account_balance_wallet, 'Budget', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetManagement(title: "Budget Management")));
                    }),
                    _buildNavigationCard(Icons.shopping_cart, 'Expenses', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => viewexpense(title: "View Expenses")));
                    }),
                    _buildNavigationCard(Icons.money, ' View Income', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => viewincome(title: "View Income")));
                    }),
                    _buildNavigationCard(Icons.bar_chart, 'Add Expenses', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => viewbudget(title: "View Budget")));
                    }),
                    _buildNavigationCard(Icons.lightbulb, 'Suggestions', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => viewsuggestions(title: "View Suggestions")));
                    }),
                    _buildNavigationCard(Icons.people, 'Experts', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => viewexpert(title: "Experts")));
                    }),
                    _buildNavigationCard(Icons.receipt, 'Tax', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_tax(title: "Manage Tax")));
                    }),
                    _buildNavigationCard(Icons.notifications, 'Notifications', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => viewnotification(title: "Notifications")));
                    }),
                    _buildNavigationCard(Icons.report, 'Finance', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinancialReportPage(title: "Finance Report")));
                    }),

                    _buildNavigationCard(Icons.rate_review, 'Review', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => expertreviews(title: "View Review")));
                    }),        _buildNavigationCard(Icons.list, 'Complaint', () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => sendComplaint(title: "Send Complaint")));
                    }),      _buildNavigationCard(Icons.list, 'View Complaint', () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => viewComplaint(title: "View Complaint")));
                    }),    _buildNavigationCard(Icons.password, 'Change password', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyChangePassword()));
                    })


                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, double value, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\₹${value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String imgurl = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/user_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'].toString();
          String DOB = jsonDecode(response.body)['DOB'].toString();
          String Gender = jsonDecode(response.body)['Gender'].toString();
          String Email = jsonDecode(response.body)['Email'].toString();
          String Contact = jsonDecode(response.body)['Contact'].toString();
          String Place = jsonDecode(response.body)['Place'].toString();
          String Post = jsonDecode(response.body)['Post'].toString();
          String Pin = jsonDecode(response.body)['Pin'].toString();
          String District = jsonDecode(response.body)['District'].toString();
          String Photo = imgurl + jsonDecode(response.body)['Photo'].toString();

          setState(() {
            name_ = name;
            DOB_ = DOB;
            Gender_ = Gender;
            Email_ = Email;
            Contact_ = Contact;
            Place_ = Place;
            Post_ = Post;
            Pin_ = Pin;
            District_ = District;
            Photo_ = Photo;
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