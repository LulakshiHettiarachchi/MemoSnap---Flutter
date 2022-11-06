import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//void main() => runApp(const MyLogOut());

class MyLogOut extends StatelessWidget {
  const MyLogOut({Key? key}) : super(key: key);

//static const String _title = 'GeeskforGeeks';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: _title,
      home: Scaffold(
        //appBar: AppBar(
        //	title: const Text(_title),
        //backgroundColor: Colors.green,
        //	),
        body: LogOut(),
      ),
    );
  }
}

class LogOut extends StatefulWidget {
  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return Center(
      
        child: Column(
          
      children: [
        
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network("https://i.postimg.cc/yxNnfz1K/i5.png"),
        ),
        ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 213, 138, 183),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.normal),
            ),
            child: Text("Log Out"))
      ],
    ));
  }
}
