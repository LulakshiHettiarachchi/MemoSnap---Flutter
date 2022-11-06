
import 'package:flutter/material.dart';
import 'package:my_app/log_out.dart';
import 'myHome.dart';
import 'newMemory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'log_out.dart';
import 'my_memory.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Memories';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
      
    );
  }
}

//bottom navigation bar
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
    MyMem(), //trips sharing contents
    NewMemory(),//Add new memory
    MyMemOnly(),//veiw my memories
    MyLogOut()//user log out 
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
        title: const Text('Memories'),
         backgroundColor: Color.fromARGB(255, 103, 240, 172),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Memories',
            backgroundColor: Color.fromARGB(255, 245, 22, 211),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Add new Memory',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'My Memories',
            backgroundColor: Color.fromARGB(255, 208, 236, 83),
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
