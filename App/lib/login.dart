// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:new_project/home.dart';
// import 'package:new_project/signup.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const login(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class login extends StatefulWidget {
//   const login({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<login> createState() => _loginState();
// }
//
// class _loginState extends State<login> {
//
//   TextEditingController usernamecontroller=new TextEditingController();
//   TextEditingController passwordcontroller=new TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               controller: usernamecontroller,
//               decoration: InputDecoration(border: OutlineInputBorder(),label: Text("username")),),
//             TextFormField(
//               controller: passwordcontroller,
//               decoration: InputDecoration(border: OutlineInputBorder(),label: Text("password")),),
//             ElevatedButton(onPressed: (){
//               _send_data();
//             }, child: Text("login")),
//             ElevatedButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMySignupPage(title: 'signup',)));
//             }, child: Text("signup"))
//
//           ],
//         ),
//       ),
//
//     );
//   }
//   void _send_data() async{
//
//
//     String username=usernamecontroller.text;
//     String password=passwordcontroller.text;
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
//           sh.setString("lid", lid);
//
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) => user_home_page(),));
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
//
//
//
//
//





import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_project/home.dart';
import 'package:new_project/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const login(title: 'Flutter Demo Home Page'),
    );
  }
}

class login extends StatefulWidget {
  const login({super.key, required this.title});

  final String title;

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _isPasswordVisible = false; // This will track password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernamecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Username"),
              ),
            ),
            // Password field with visibility toggle
            TextFormField(
              controller: passwordcontroller,
              obscureText: !_isPasswordVisible, // Password visibility toggle
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Password"),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
                    });
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _send_data();
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyMySignupPage(title: 'Signup')),
                );
              },
              child: Text("Signup"),
            ),
          ],
        ),
      ),
    );
  }

  void _send_data() async {
    String username = usernamecontroller.text;
    String password = passwordcontroller.text;

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
          sh.setString("lid", lid);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => user_home_page(),
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


