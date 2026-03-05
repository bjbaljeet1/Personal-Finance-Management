import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_project/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewProfilePage(title: 'View Profile'),
    );
  }
}

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {

  _ViewProfilePageState() {
    _send_data();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pro.jpg"), // Add your image in the assets folder
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent, // Makes Scaffold transparent
          appBar: AppBar(
            leading: BackButton(),
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
            title: Text(widget.title),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(Photo_),
                      backgroundColor: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileDetail("Name", name_),
                          _buildProfileDetail("Date of Birth", DOB_),
                          _buildProfileDetail("Gender", Gender_),
                          _buildProfileDetail("Email", Email_),
                          _buildProfileDetail("Contact", Contact_),
                          _buildProfileDetail("Place", Place_),
                          _buildProfileDetail("Post", Post_),
                          _buildProfileDetail("Pin Code", Pin_),
                          _buildProfileDetail("District", District_),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyEditPage(title: "MyEditPage"),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Edit Profile", style: TextStyle(fontSize: 16)),
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


  // Helper function to build profile details
  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

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
