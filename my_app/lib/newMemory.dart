import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
//import 'package:my_app/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'myHome.dart';
import './auth.dart';


class NewMemory extends StatefulWidget {
  const NewMemory({Key? key}) : super(key: key);

  @override
  State<NewMemory> createState() => _MyCustomForm();
}

class _MyCustomForm extends State<NewMemory> {
  //const MyCustomForm({super.key});

//store form data in text controllers
  TextEditingController _place = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _content = TextEditingController();
  var error = "";

  @override
  void initState() {
    getEmail();
    super.initState();
  }

//for get user email from shared preference
  TextEditingController _email = TextEditingController();
  getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final String? saveE = prefs.getString('email');
    // print(saveE);
    if (saveE != null) {
      // print("**********");
      _email.text = saveE.toString();
      //print(_email.text);
      return _email.text;
    }
  }
//widget for new memory form field
  @override
  Widget build(BuildContext context) {
   // print("+++++++++++++++++++++++");
   //print(_email.text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30),
          child: TextFormField(
            controller: _place,
            onChanged: (value) {
              error = "";
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Where did you go/Title for your memory',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: TextFormField(
            controller: _date,
            onChanged: (value) {
              error = "";
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Date',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: TextFormField(
            controller: _content,
            onChanged: (value) {
              error = "";
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Memories(you can share your experience and memories with others)',
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Center(
              child: ElevatedButton(
                  onPressed: add_memory,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.normal),
                  ),
                  child: Text("Add new Memory")
                  ),
            )),
      ],
    );
  }

//insert new data to database
  add_memory() async {
    //final user_email = getEmail().toString();
    print(_place.text);
    print(_date.text);
    print(_email.text);

    FirebaseFirestore.instance.collection('new_memory').add({
      'Place': _place.text,
      'Date': _date.text,
      'Content': _content.text,
      'Email': _email.text
    });

    //navigate to home page (all memories)
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  MyApp()),
            );
  }
}
