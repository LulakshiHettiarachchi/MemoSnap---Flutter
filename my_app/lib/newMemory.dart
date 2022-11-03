import 'dart:html';

import 'package:conditional_questions/conditional_questions.dart';
import 'package:flutter/material.dart';
//import 'package:image_form_field/image_form_field.dart';

/*void main() {
  runApp(newMemory());
}*/

class NewMemory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //  title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _key = GlobalKey<QuestionFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      // title: Text(widget.title!),
      //    ),
      body: ConditionalQuestions(
        key: _key,
        children: questions(),
        trailing: [
          MaterialButton(
            color: Color.fromARGB(255, 177, 230, 178),
            splashColor: Colors.orangeAccent,
            onPressed: () async {
              if (_key.currentState!.validate()) {
                print("validated!");
              }
            },
            child: Text("Done"),
          )
        ],
        // leading: [Text("TITLE")],
      ),
    );
  }
}

List<Question> questions() {
  return [
    Question(
      question: "Where did you go?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Field cannot be empty";
        return null;
      },
    ),
    Question(
      question: "Date",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Field cannot be empty";
        return null;
      },
    ),
    Question(
      question: "Memories about the trip",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Field cannot be empty";
        return null;
      },
    ),

    //image
    // PickedFile _imageFile;
  ];
}
