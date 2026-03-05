// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:pfm/home.dart';
// import 'package:pfm/massage.dart';
// import 'package:pfm/sendexpertreview.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const ViewReply());
// }
//
// class ViewReply extends StatelessWidget {
//   const ViewReply({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Reply',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const viewexpert(title: 'View Reply'),
//     );
//   }
// }
//
// class viewexpert extends StatefulWidget {
//   const viewexpert({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewexpert> createState() => _viewexpertState();
// }
//
// class _viewexpertState extends State<viewexpert> {
//
//   _viewexpertState() {
//     viewreply();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> Expertname_ = <String>[];
//   List<String> Qualification_ = <String>[];
//   List<String> Experiance_ = <String>[];
//   List<String> Gender_ = <String>[];
//   List<String> Phone_ = <String>[];
//   List<String> Email_ = <String>[];
//   List<String> Place_ = <String>[];
//   List<String> Status_ = <String>[];
//   List<String> Photo_ = <String>[];
//
//
//   Future<void> viewreply() async {
//     List<String> id = <String>[];
//     List<String> Experiance = <String>[];
//     List<String> Qualification = <String>[];
//     List<String> Name = <String>[];
//     List<String> Gender = <String>[];
//     List<String> Phone = <String>[];
//     List<String> Email = <String>[];
//     List<String> Place = <String>[];
//     List<String> Status = <String>[];
//     List<String> Photo = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String img_url = sh.getString('img_url').toString();
//       String url = '$urls/view_expert/';
//
//       var data = await http.post(Uri.parse(url), body: {
//
//         'lid': lid,
//       });
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         Name.add(arr[i]['Name'].toString());
//         Qualification.add(arr[i]['Qualification'].toString());
//         Experiance.add(arr[i]['Experiance'].toString());
//         Gender.add(arr[i]['Gender'].toString());
//         Phone.add(arr[i]['Phone'].toString());
//         Email.add(arr[i]['Email'].toString());
//         Place.add(arr[i]['Place'].toString());
//         Status.add(arr[i]['Status'].toString());
//         Photo.add(img_url + arr[i]['Photo'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         Expertname_ = Name;
//         Qualification_ = Qualification;
//         Experiance_ = Experiance;
//         Gender_ = Gender;
//         Phone_ = Phone;
//         Email_ = Email;
//         Place_ = Place;
//         Status_ = Status;
//         Photo_ = Photo;
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => user_home_page()),);
//           },),
//           backgroundColor: Theme
//               .of(context)
//               .colorScheme
//               .primary,
//           title: Text(widget.title),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           // padding: EdgeInsets.all(5.0),
//           // shrinkWrap: true,
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               onLongPress: () {
//                 print("long press" + index.toString());
//               },
//               title: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Card(
//                         child:
//                         Row(
//                             children: [
//                               Column(
//
//                                 children: [
//                                   Image(image: NetworkImage(Photo_[index]),
//                                     height: 200,
//                                     width: 20,),
//
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Text("Name     :"),
//                                         Text(Expertname_[index]),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Text("Qualification    :"),
//                                         Text(Qualification_[index]),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Text("Experiance   :"),
//                                         Text(Experiance_[index]),
//                                       ],
//                                     ),
//                                   ),
//
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Text("Gender   :"),
//                                         Text(Gender_[index]),
//                                       ],
//                                     ),
//                                   ),
//
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Text("Phone   :"),
//                                         Text(Phone_[index]),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Text("Email   :"),
//                                         Text(Email_[index]),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Text("Place   :"),
//                                         Text(Place_[index]),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Text("Status   :"),
//                                         Text(Status_[index]),
//                                       ],
//                                     ),
//                                   ),
//
//
//                                   // ElevatedButton(onPressed: () async {
//                                   //   SharedPreferences sh = await SharedPreferences
//                                   //       .getInstance();
//                                   //   String url = sh.getString('url').toString();
//                                   //   String lid = sh.getString('lid').toString();
//                                   //
//                                   //   final Uri urls = Uri.parse(
//                                   //       '$url/send_request/');
//                                   //   try {
//                                   //     final response = await http.post(
//                                   //         urls, body: {
//                                   //       'eid': id_[index],
//                                   //       'lid': lid
//                                   //     });
//                                   //
//                                   //     if (response.statusCode == 200) {
//                                   //       String status = jsonDecode(
//                                   //           response.body)['status'];
//                                   //       if (status == 'ok') {
//                                   //         Fluttertoast.showToast(
//                                   //             msg: 'Sended successfully');
//                                   //
//                                   //         Navigator.push(
//                                   //             context, MaterialPageRoute(
//                                   //           builder: (context) =>
//                                   //               viewexpert(title: ""),));
//                                   //       } else {
//                                   //         Fluttertoast.showToast(
//                                   //             msg: 'Not Found');
//                                   //       }
//                                   //     } else {
//                                   //       Fluttertoast.showToast(
//                                   //           msg: 'Network Error');
//                                   //     }
//                                   //   } catch (e) {
//                                   //     Fluttertoast.showToast(msg: e.toString());
//                                   //   }
//                                   // }, child: Text("Send Request")),
//                                   ElevatedButton(onPressed: () async {
//                                     SharedPreferences sh = await SharedPreferences.getInstance();
//                                     sh.setString('eid', id_[index].toString());
//
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     sendexpertreview(title: 'Review')),);
//
//                                   }, child: Text("Send Review")),
//                                   ElevatedButton(onPressed: () async {
//                                     SharedPreferences sh = await SharedPreferences.getInstance();
//                                     sh.setString('eid', id_[index].toString());
//
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     message(title: 'Message')),);
//
//                                   }, child: Text("Send Message")),
//
//                                 ],
//                               ),
//
//                             ]
//                         ),
//
//                         elevation: 8,
//                         margin: EdgeInsets.all(10),
//                       ),
//                     ],
//                   )),
//             );
//           },
//         ),
//
//
//       ),
//     );
//   }
//
// }


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/home.dart';
import 'package:new_project/homescreen.dart';
import 'package:new_project/massage.dart';
import 'package:new_project/sendexpertreview.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

 void main() {
  runApp(const ViewReply());
}

class ViewReply extends StatelessWidget {
  const ViewReply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const viewexpert(title: 'View Reply'),
    );
  }
}

class viewexpert extends StatefulWidget {
  const viewexpert({super.key, required this.title});

  final String title;

  @override
  State<viewexpert> createState() => _viewexpertState();
}

class _viewexpertState extends State<viewexpert> {
  List<Map<String, String>> experts = [];

  _viewexpertState() {
    viewReply();
  }

  Future<void> viewReply() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String img_url = sh.getString('img_url') ?? '';
      String url = '$urls/view_expert/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);

      if (jsondata['status'] == 'ok') {
        var arr = jsondata['data'];
        List<Map<String, String>> tempList = [];

        for (var expert in arr) {
          tempList.add({
            'id': expert['id'].toString(),
            'name': expert['Name'].toString(),
            'qualification': expert['Qualification'].toString(),
            'experience': expert['Experiance'].toString(),
            'gender': expert['Gender'].toString(),
            'phone': expert['Phone'].toString(),
            'email': expert['Email'].toString(),
            'place': expert['Place'].toString(),
            'status': expert['Status'].toString(),
            'photo': img_url + expert['Photo'].toString(),
          });
        }

        setState(() {
          experts = tempList;
        });
      }
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => user_home_new(title: '',)));
        }),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: experts.length,
        itemBuilder: (BuildContext context, int index) {
          var expert = experts[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(expert['photo'] ?? ''),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(expert['name'] ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("${expert['qualification'] ?? ''} | ${expert['experience'] ?? ''} years experience"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Gender: ${expert['gender'] ?? ''}"),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("Phone: ${expert['phone'] ?? ''}"),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Email: ${expert['email'] ?? ''}"),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text("Place: ${expert['place'] ?? ''}"),
                  ),
                  ListTile(
                    leading: Icon(Icons.verified),
                    title: Text("Status: ${expert['status'] ?? ''}"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences sh = await SharedPreferences.getInstance();
                          sh.setString('eid', expert['id'] ?? '');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => sendexpertreview(title: 'Review')));
                        },
                        child: Text("Send Review"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences sh = await SharedPreferences.getInstance();
                          sh.setString('eid', expert['id'] ?? '');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => message(title: 'Message')));
                        },
                        child: Text("Send Message"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

