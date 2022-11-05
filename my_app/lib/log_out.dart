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
      child: ElevatedButton(
        //	color: Colors.green,
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Log Out',
              style: TextStyle(
                color: Color.fromARGB(255, 247, 248, 246),
              ),
            ), // <-- Text

            Icon(
              // <-- Icon
              Icons.logout,
              size: 14.0,
            ),
          ],
        ),
      ),
    );
  }
}
