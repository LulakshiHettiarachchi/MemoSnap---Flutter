import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//void main() => runApp(const MyLogOut());

class MyLogOut extends StatelessWidget {
  const MyLogOut({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        
        Container(
              child: Image(
               width: 300,
              image: NetworkImage("https://i.postimg.cc/yxNnfz1K/i5.png"),
              ),
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
