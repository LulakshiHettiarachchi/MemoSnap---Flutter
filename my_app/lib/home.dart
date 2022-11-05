// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class home extends StatefulWidget {
//   const home({Key? key}) : super(key: key);

//   @override
//   State<home> createState() => _homeState();
// }

// class _homeState extends State<home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title: Text("TourG"),
//             centerTitle: true,
//             backgroundColor: Colors.teal),
//         body: SingleChildScrollView(
//           child: Center(
//               child: Column(
//             children: [
//               updateArea(),
//               Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Text('Successfully Signed In!',
//                       style: new TextStyle(
//                           color: Color.fromARGB(255, 49, 46, 51),
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold))),
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: ElevatedButton(
//                   child: Text("Logout"),
//                   onPressed: () async {
//                     await FirebaseAuth.instance.signOut();
//                   },
//                 ),
//               )
//             ],
//           )),
//         ));
//   }
// }

// class updateArea extends StatefulWidget {
//   String toDisplay = "Home Page ";

//   @override
//   State<updateArea> createState() => _updateAreaState();
// }

// class _updateAreaState extends State<updateArea> {
//   String toDisplay = "Home Page";

//   void buttonPressed() {
//     setState(() {
//       toDisplay = "Updated";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.only(top: 10.0),
//         height: 300,
//         width: 400,
//         padding: EdgeInsets.all(36.0),
//         child: Column(
//           children: [
//             Text(toDisplay),
//             Container(
//               padding: EdgeInsets.all(16.0),
//               child: imageHolder(),
//             )
//           ],
//         ));
//   }

//   LogOut() async {
//     await FirebaseAuth.instance.signOut();
//   }
// }

// class imageHolder extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(height: 100, width: 100);
//   }
// }

// class form extends StatefulWidget {
//   const form({super.key});

//   @override
//   State<form> createState() => _formState();
// }

// class _formState extends State<form> {
//   String _name = "";
//   String _email = "";
//   String _password = "";

//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   Widget _buidName() {
//     return Padding(
//         padding: EdgeInsets.all(15), //apply padding to all four sides
//         child: TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Name',
//           ),
//           validator: ((value) {
//             if (value!.isEmpty) {
//               return "Name is required!";
//             }
//           }),
//           onSaved: (value) {
//             _name = value!;
//           },
//         ));
//   }

//   Widget _buildEmail() {
//     return Padding(
//         padding: EdgeInsets.all(15), //apply padding to all four sides
//         child: TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Email',
//           ),
//           validator: ((value) {
//             if (value!.isEmpty) {
//               return "Email is required!";
//             }
//             if (!RegExp(
//                     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//                 .hasMatch(value)) {
//               return "Enter a valid email..!";
//             }
//           }),
//           onSaved: (value) {
//             _email = value!;
//           },
//         ));
//   }

//   Widget _buildPassword() {
//     return Padding(
//         padding: EdgeInsets.all(15), //apply padding to all four sides
//         child: TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Password',
//           ),
//           obscureText: true,
//           validator: ((value) {
//             if (value!.isEmpty) {
//               return "Password is required!";
//             }
//             if (!RegExp(
//                     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
//                 .hasMatch(value)) {
//               return "Password must be at least 8 characters long";
//             }
//           }),
//           onSaved: (value) {
//             _password = value!;
//           },
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 300,
//         height: 800,
//         padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
//         child: Form(
//           key: _formkey,
//           child: Column(
//             children: <Widget>[
//               _buidName(),
//               _buildEmail(),
//               _buildPassword(),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                 child: Column(
//                   children: [
//                     // RaisedButton(
//                     //     child: Text("Submit"),
//                     //     onPressed: () {
//                     //       if (!_formkey.currentState!.validate()) {
//                     //         return;
//                     //       }
//                     //       _formkey.currentState!.save();

//                     //       print(_name);
//                     //       print(_email);
//                     //       print(_password);
//                     //     })
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:my_app/log_out.dart';
import 'myHome.dart';
import 'newMemory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'log_out.dart';
//void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Tour2Do';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    MyHome(), //trips sharing contents
    NewMemory(),
    Text(
      'Index 2: My Trip',
      style: optionStyle,
    ),
    MyLogOut()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'My memories',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Plan',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'My Trip',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Log Out',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
