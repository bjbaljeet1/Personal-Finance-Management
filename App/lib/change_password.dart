// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'homescreen.dart';
// import 'login.dart';
// void main() {
//   runApp(const MyChangePassword());
// }
//
// class MyChangePassword extends StatelessWidget {
//   const MyChangePassword({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ChangePassword',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyChangePasswordPage(title: 'ChangePassword'),
//     );
//   }
// }
//
// class MyChangePasswordPage extends StatefulWidget {
//   const MyChangePasswordPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyChangePasswordPage> createState() => _MyChangePasswordPageState();
// }
//
// class _MyChangePasswordPageState extends State<MyChangePasswordPage> {
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     TextEditingController oldpasswordController= new TextEditingController();
//     TextEditingController newpasswordController= new TextEditingController();
//     TextEditingController confirmpasswordController= new TextEditingController();
//
//
//     return WillPopScope(
//       onWillPop: () async{ return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   controller: oldpasswordController,
//
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Old Password")),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   controller: newpasswordController,
//
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("New Password")),
//                 ),
//               ),      Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   controller: confirmpasswordController,
//
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Confirm Password")),
//                 ),
//               ),
//
//               ElevatedButton(
//                 onPressed: () async {
//
//                   String oldp= oldpasswordController.text.toString();
//                   String newp= newpasswordController.text.toString();
//                   String confirmp= newpasswordController.text.toString();
//
//
//
//                   SharedPreferences sh = await SharedPreferences.getInstance();
//                   String url = sh.getString('url').toString();
//                   String lid = sh.getString('lid').toString();
//
//                   final urls = Uri.parse('$url/user_change_password/');
//                   try {
//                     final response = await http.post(urls, body: {
//                       'lid':lid,
//                       'oldpassword':oldp,
//                       'newpassword':newp,
//                       'confirmpassword':confirmp,
//
//
//
//                     });
//                     if (response.statusCode == 200) {
//                       String status = jsonDecode(response.body)['status'];
//                       if (status=='ok') {
//                         Fluttertoast.showToast(msg: 'Password Changed Successfully');
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => user_home_new(title: 'Home',)));
//                       }else {
//                         Fluttertoast.showToast(msg: 'Incorrect Password');
//                       }
//                     }
//                     else {
//                       Fluttertoast.showToast(msg: 'Network Error');
//                     }
//                   }
//                   catch (e){
//                     Fluttertoast.showToast(msg: e.toString());
//                   }
//
//                 },
//                 child: Text("ChangePassword"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';

void main() {
  runApp(const MyChangePassword());
}

class MyChangePassword extends StatelessWidget {
  const MyChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change Password',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyChangePasswordPage(title: 'Change Password'),
    );
  }
}

class MyChangePasswordPage extends StatefulWidget {
  const MyChangePasswordPage({super.key, required this.title});
  final String title;

  @override
  State<MyChangePasswordPage> createState() => _MyChangePasswordPageState();
}

class _MyChangePasswordPageState extends State<MyChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  bool isValidPassword(String password) {
    print("Checking password: $password");
    //final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}\$');
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    bool isValid = regex.hasMatch(password);
   // print("Password is valid: $isValid");
    print("Regex Match: ${regex.hasMatch(password)}");

    return isValid;
  }

  Future<void> changePassword() async {
    String oldPassword = oldPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print("Old Password: $oldPassword");
    print("New Password: $newPassword");
    print("Confirm Password: $confirmPassword");

    if (!isValidPassword(newPassword)) {
      Fluttertoast.showToast(
          msg: 'Password must be at least 8 characters long and include an uppercase letter, lowercase letter, number, and special character.');
      return;
    }

    if (newPassword != confirmPassword) {
      Fluttertoast.showToast(msg: 'New Password and Confirm Password do not match.');
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';

    final urls = Uri.parse('$url/user_change_password/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'oldpassword': oldPassword,
        'newpassword': newPassword,
        'confirmpassword': confirmPassword,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Password Changed Successfully');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => user_home_new(title: 'Home')),
          );
        } else {
          Fluttertoast.showToast(msg: 'Incorrect Password');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildPasswordTextField(oldPasswordController, 'Old Password', false),
            buildPasswordTextField(newPasswordController, 'New Password', true),
            buildPasswordTextField(confirmPasswordController, 'Confirm Password', true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: changePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordTextField(TextEditingController controller, String label, bool isNewPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isNewPassword ? !isPasswordVisible : !isConfirmPasswordVisible,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          suffixIcon: IconButton(
            icon: Icon(
              isNewPassword ? (isPasswordVisible ? Icons.visibility : Icons.visibility_off) :
              (isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
            ),
            onPressed: () {
              setState(() {
                if (isNewPassword) {
                  isPasswordVisible = !isPasswordVisible;
                } else {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
