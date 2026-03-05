//
// //
// // import 'package:disaster_managment/public/public_distict_wise_notifications.dart';
// // import 'package:disaster_managment/user/signup.dart';
// // import 'package:disaster_managment/user/userhome.dart';
// // import 'package:disaster_managment/user/view_profile.dart';
// // import 'package:disaster_managment/volunter/volunteer_signup.dart';
// // import 'package:disaster_managment/volunter/volunter_home.dart';
// import 'package:flutter/material.dart';
// // import 'package:hive/hive.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hive/hive.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:new_project/home.dart';
// import 'package:new_project/homescreen.dart';
// import 'package:new_project/signup.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // import 'Gaurd/gard_home.dart';
// // import 'customer/registration.dart';
//
// class MyLogin extends StatefulWidget {
//   const MyLogin({Key? key, required String title}) : super(key: key);
//
//   @override
//   _MyLoginState createState() => _MyLoginState();
// }
//
// class _MyLoginState extends State<MyLogin> {
//   bool isChecked = false;
//   TextEditingController unamecontroller = TextEditingController();
//   TextEditingController pswcontroller = TextEditingController();
//
//
//   late Row box1;
//
//   @override
//   void initState() {
//     //
//     super.initState();
//     createBox();
//
//   }
//
//   void createBox() async {
//     box1 = (await Hive.openBox('logininfo')) as Row;
//     getdata();
//   }
//   void getdata()async {
//     if (box1.get('email') != null) {
//       unamecontroller.text = box1.get('email');
//       isChecked = true;
//       setState(() {
//
//       });
//     }
//     if (box1.get('password') != null) {
//       unamecontroller.text = box1.get('password');
//       isChecked = true;
//       setState(() {
//
//       });
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             Container(),
//             Container(
//               padding: EdgeInsets.only(left: 35, top: 130),
//               child: Text(
//                 'Welcome\nBack',
//                 style: TextStyle(color: Colors.white, fontSize: 33),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                     top: MediaQuery
//                         .of(context)
//                         .size
//                         .height * 0.5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(left: 35, right: 35),
//                       child: Column(
//                         children: [
//                           TextField(
//                             controller: unamecontroller,
//                             style: TextStyle(color: Colors.black),
//                             decoration: InputDecoration(
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 hintText: "Email",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           TextField(
//                             controller: pswcontroller,
//                             style: TextStyle(),
//                             obscureText: true,
//                             decoration: InputDecoration(
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 hintText: "Password",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                           ),
//                           SizedBox(
//                             height: 40,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Sign in',
//                                 style: TextStyle(
//                                     fontSize: 27, fontWeight: FontWeight.w700),
//                               ),
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Color(0xff4c505b),
//                                 child: IconButton(
//                                     color: Colors.white,
//                                     onPressed: () {
//
//                                       _send_data();
//                                     },
//                                     icon: Icon(
//                                       Icons.arrow_forward,
//                                     )),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 40,
//                           ),
//
//
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               TextButton(
//                                 onPressed: (){
//                                   Navigator.push(context, MaterialPageRoute(
//                                     builder: (context) => MyMySignupPage(title:'Sigup',),),);
//                                 },
//                                 child: Text(
//                                   'User Signup',
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       decoration: TextDecoration.underline,
//                                       color: Color(0xff4c505b),
//                                       fontSize: 18),
//                                 ),
//                                 style: ButtonStyle(),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _send_data() async{
//
//     String username=unamecontroller.text;
//     String password=pswcontroller.text;
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/user_login_post/');
//     try {
//       final response = await http.post(urls, body: {
//         'name':username,
//         'password':password,
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
//           String lid=jsonDecode(response.body)['lid'];
//           sh.setString("lid", lid).toString();
//
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) => user_home_new(title: 'Home',),));
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
// }
//
// extension on Row {
//   get(String s) {}
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/homescreen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_project/home.dart';
import 'package:new_project/signup.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key, required String title}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool isChecked = false;
  bool _isPasswordVisible = false; // Password visibility toggle
  TextEditingController unamecontroller = TextEditingController();
  TextEditingController pswcontroller = TextEditingController();

  late Box<dynamic> box1; // Declare Box type properly

  @override
  void initState() {
    super.initState();
    createBox();
  }

  void createBox() async {
    // Open the Hive box, box1 will store the login info (email & password).
    box1 = await Hive.openBox('logininfo');
    getdata();
  }

  void getdata() async {
    // Retrieve email and password from Hive box
    if (box1.get('email') != null) {
      unamecontroller.text = box1.get('email');
      isChecked = true;
      setState(() {});
    }
    if (box1.get('password') != null) {
      pswcontroller.text = box1.get('password');
      isChecked = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: unamecontroller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Password field with visibility toggle
                          TextField(
                            controller: pswcontroller,
                            style: TextStyle(),
                            obscureText: !_isPasswordVisible, // Toggle visibility
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey, // Change color of the eye icon
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible; // Toggle the password visibility
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _send_data();
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MyMySignupPage(title: 'Signup'),
                                    ),
                                  );
                                },
                                child: Text(
                                  'User Signup',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _send_data() async {
    String username = unamecontroller.text;
    String password = pswcontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_login_post/');
    try {
      final response = await http.post(urls, body: {
        'name': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['lid'];
          String uname = jsonDecode(response.body)['uname'];
          String uphoto = jsonDecode(response.body)['uphoto'];
          sh.setString("lid", lid);
          sh.setString("uname", uname);
          sh.setString("uphoto", uphoto);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => user_home_new(title: "Personal Finance",),
            ),
          );
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
