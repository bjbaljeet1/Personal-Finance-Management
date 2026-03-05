import 'package:flutter/material.dart';
import 'package:new_project/login.dart';
import 'package:new_project/loginmain.dart';
// import 'package:pfm/temp/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(){
    ipcontroller.text="192.168.50.137";
  }

  TextEditingController ipcontroller=TextEditingController();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

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

            TextFormField(controller:ipcontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text("ipaddress")),),

            ElevatedButton(onPressed: (){
              send_data();
            }, child: Text("connect"))


          ],
        ),
      ),
    );
  }
  void send_data() async{
    String ip=ipcontroller.text;
    String url="http://"+ip+":7000/myapp";
    String img_url="http://"+ip+":7000";
    SharedPreferences sh=await SharedPreferences.getInstance();
    sh.setString("url", url).toString();
    sh.setString("img_url", img_url).toString();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLogin(title: '',)));
  }
}
