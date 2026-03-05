// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:new_project/loginmain.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'login.dart';
//
// void main() {
//   runApp(const MyMySignup());
// }
//
// class MyMySignup extends StatelessWidget {
//   const MyMySignup({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MySignup',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyMySignupPage(title: 'MySignup'),
//     );
//   }
// }
//
// class MyMySignupPage extends StatefulWidget {
//   const MyMySignupPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyMySignupPage> createState() => _MyMySignupPageState();
// }
//
// class _MyMySignupPageState extends State<MyMySignupPage> {
//   String gender = "Male";
//   File? uploadimage;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController dateofbirthcontroller = TextEditingController();
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController contactcontroller = TextEditingController();
//   TextEditingController placecontroller = TextEditingController();
//   TextEditingController postcontroller = TextEditingController();
//   TextEditingController pincontroller = TextEditingController();
//   TextEditingController districtcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   TextEditingController confirmpasswordcontroller = TextEditingController();
//
//   File? _selectedImage;
//   String? _encodedImage;
//   String photo = '';
//
//   Future<void> _chooseAndUploadImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//         _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
//         photo = _encodedImage.toString();
//       });
//     }
//   }
//
//   Future<void> _checkPermissionAndChooseImage() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadImage();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Permission Denied'),
//           content: const Text(
//             'Please go to app settings and grant permission to choose an image.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         dateofbirthcontroller.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }
//
//   // Validation before sending data
//   bool _validateForm() {
//     if (nameController.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Name cannot be empty");
//       return false;
//     }
//     if (emailcontroller.text.isEmpty || !_isValidEmail(emailcontroller.text)) {
//       Fluttertoast.showToast(msg: "Please enter a valid email address");
//       return false;
//     }
//     if (contactcontroller.text.isEmpty || contactcontroller.text.length != 10) {
//       Fluttertoast.showToast(msg: "Please enter a valid contact number");
//       return false;
//     }
//     if (dateofbirthcontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please select a date of birth");
//       return false;
//     }
//     if (passwordcontroller.text.isEmpty || passwordcontroller.text.length < 6) {
//       Fluttertoast.showToast(msg: "Password should be at least 6 characters long");
//       return false;
//     }
//     if (passwordcontroller.text != confirmpasswordcontroller.text) {
//       Fluttertoast.showToast(msg: "Passwords do not match");
//       return false;
//     }
//     return true;
//   }
//
//   bool _isValidEmail(String email) {
//     String pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b';
//     RegExp regex = RegExp(pattern);
//     return regex.hasMatch(email);
//   }
//
//   void _send_data() async {
//     if (!_validateForm()) {
//       return; // Prevent further execution if validation fails
//     }
//
//     String name = nameController.text;
//     String DOB = dateofbirthcontroller.text;
//     String Email = emailcontroller.text;
//     String Contact = contactcontroller.text;
//     String Place = placecontroller.text;
//     String Post = postcontroller.text;
//     String Pin = pincontroller.text;
//     String District = districtcontroller.text;
//     String password = passwordcontroller.text;
//     String confirm = confirmpasswordcontroller.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/user_signup/');
//     try {
//       final response = await http.post(urls, body: {
//         "photo": photo,
//         "name": name,
//         "dob": DOB,
//         "gender": gender,
//         "email": Email,
//         "contact": Contact,
//         "place": Place,
//         "pin": Pin,
//         "post": Post,
//         "district": District,
//         "password": password,
//         "confirm": confirm,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Registration Successful');
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => MyLogin(title: "Login"),
//             ),
//           );
//         } else {
//           Fluttertoast.showToast(msg: 'Registration failed');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => true,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 if (_selectedImage != null) ...{
//                   InkWell(
//                     child: Image.file(_selectedImage!, height: 200, width: 200, fit: BoxFit.cover),
//                     radius: 399,
//                     onTap: _checkPermissionAndChooseImage,
//                   ),
//                 } else ...{
//                   InkWell(
//                     onTap: _checkPermissionAndChooseImage,
//                     child: Column(
//                       children: [
//                         Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'), height: 200, width: 200),
//                         Text('Select Image', style: TextStyle(color: Colors.cyan)),
//                       ],
//                     ),
//                   ),
//                 },
//                 SizedBox(height: 20),
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Name",
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: dateofbirthcontroller,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Date of Birth",
//                     prefixIcon: Icon(Icons.calendar_today),
//                   ),
//                   onTap: () => _selectDate(context),
//                 ),
//                 SizedBox(height: 10),
//                 Column(
//                   children: [
//                     RadioListTile(
//                       value: "Male",
//                       groupValue: gender,
//                       onChanged: (value) {
//                         setState(() {
//                           gender = value.toString();
//                         });
//                       },
//                       title: Text("Male"),
//                     ),
//                     RadioListTile(
//                       value: "Female",
//                       groupValue: gender,
//                       onChanged: (value) {
//                         setState(() {
//                           gender = value.toString();
//                         });
//                       },
//                       title: Text("Female"),
//                     ),
//                     RadioListTile(
//                       value: "Other",
//                       groupValue: gender,
//                       onChanged: (value) {
//                         setState(() {
//                           gender = value.toString();
//                         });
//                       },
//                       title: Text("Other"),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: emailcontroller,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Email",
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: contactcontroller,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Contact",
//                     prefixIcon: Icon(Icons.phone),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: placecontroller,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Place",
//                     prefixIcon: Icon(Icons.place),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: postcontroller,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Post",
//                     prefixIcon: Icon(Icons.local_post_office),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: pincontroller,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Pin",
//                     prefixIcon: Icon(Icons.pin),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: districtcontroller,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "District",
//                     prefixIcon: Icon(Icons.location_city),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: passwordcontroller,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Password",
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: confirmpasswordcontroller,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Confirm Password",
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _send_data,
//                   child: Text("Signup", style: TextStyle(fontSize: 18)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }









import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/loginmain.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'login.dart';

void main() {
  runApp(const MyMySignup());
}

class MyMySignup extends StatelessWidget {
  const MyMySignup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySignup',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyMySignupPage(title: 'MySignup'),
    );
  }
}

class MyMySignupPage extends StatefulWidget {
  const MyMySignupPage({super.key, required this.title});

  final String title;

  @override
  State<MyMySignupPage> createState() => _MyMySignupPageState();
}

class _MyMySignupPageState extends State<MyMySignupPage> {
  String gender = "Male";
  File? uploadimage;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateofbirthcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController postcontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  File? _selectedImage;
  String? _encodedImage;
  String photo = '';

  bool isPasswordVisible = false; // Track password visibility
  bool isConfirmPasswordVisible = false; // Track confirm password visibility

  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dateofbirthcontroller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  // Validation before sending data
  bool _validateForm() {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Name cannot be empty");
      return false;
    }
    if (emailcontroller.text.isEmpty || !_isValidEmail(emailcontroller.text)) {
      Fluttertoast.showToast(msg: "Please enter a valid email address");
      return false;
    }
    if (contactcontroller.text.isEmpty || !_isValidPhoneNumber(contactcontroller.text)) {
      Fluttertoast.showToast(msg: "Please enter a valid contact number");
      return false;
    }
    if (dateofbirthcontroller.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a date of birth");
      return false;
    }
    if (passwordcontroller.text.isEmpty || !_isValidPassword(passwordcontroller.text)) {
      Fluttertoast.showToast(msg: "Password must be at least 8 characters long and contain at least one special character, one number, one lowercase, and one uppercase letter.");
      return false;
    }
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      Fluttertoast.showToast(msg: "Passwords do not match");
      return false;
    }
    return true;
  }

  bool _isValidEmail(String email) {
    String pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool _isValidPhoneNumber(String phone) {
    // Check if phone number has exactly 10 digits and is numeric
    String pattern = r'^\d{10}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(phone);
  }

  bool _isValidPassword(String password) {
    // Regex for password validation:
    // - At least 8 characters
    // - At least one lowercase letter
    // - At least one uppercase letter
    // - At least one number
    // - At least one special character
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  void _send_data() async {
    if (!_validateForm()) {
      return; // Prevent further execution if validation fails
    }

    String name = nameController.text;
    String DOB = dateofbirthcontroller.text;
    String Email = emailcontroller.text;
    String Contact = contactcontroller.text;
    String Place = placecontroller.text;
    String Post = postcontroller.text;
    String Pin = pincontroller.text;
    String District = districtcontroller.text;
    String password = passwordcontroller.text;
    String confirm = confirmpasswordcontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_signup/');
    try {
      final response = await http.post(urls, body: {
        "photo": photo,
        "name": name,
        "dob": DOB,
        "gender": gender,
        "email": Email,
        "contact": Contact,
        "place": Place,
        "pin": Pin,
        "post": Post,
        "district": District,
        "password": password,
        "confirm": confirm,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Registration Successful');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyLogin(title: "Login"),
            ),
          );
        } else {
          Fluttertoast.showToast(msg: 'Registration failed');
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
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_selectedImage != null) ...{
                  InkWell(
                    child: Image.file(_selectedImage!, height: 200, width: 200, fit: BoxFit.cover),
                    radius: 399,
                    onTap: _checkPermissionAndChooseImage,
                  ),
                } else ...{
                  InkWell(
                    onTap: _checkPermissionAndChooseImage,
                    child: Column(
                      children: [
                        Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'), height: 200, width: 200),
                        Text('Select Image', style: TextStyle(color: Colors.cyan)),
                      ],
                    ),
                  ),
                },
                SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: dateofbirthcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Date of Birth",
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    RadioListTile(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                      title: Text("Male"),
                    ),
                    RadioListTile(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                      title: Text("Female"),
                    ),
                    RadioListTile(
                      value: "Other",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                      title: Text("Other"),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: contactcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contact",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: placecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Place",
                    prefixIcon: Icon(Icons.place),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: postcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Post",
                    prefixIcon: Icon(Icons.local_post_office),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: pincontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Pin",
                    prefixIcon: Icon(Icons.pin),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: districtcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "District",
                    prefixIcon: Icon(Icons.location_city),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordcontroller,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: confirmpasswordcontroller,
                  obscureText: !isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _send_data,
                  child: Text("Signup", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


