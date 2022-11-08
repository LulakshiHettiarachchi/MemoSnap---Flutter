import 'dart:js';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMemOnly extends StatefulWidget {
  const MyMemOnly({Key? key}) : super(key: key);

  @override
  State<MyMemOnly> createState() => _MyMemState();
}

class _MyMemState extends State<MyMemOnly> {
 

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
   
    if (saveE != null) {
      
      _email.text = saveE.toString();
      
      return _email.text;
    }
  }

  final CollectionReference firestore =
      FirebaseFirestore.instance.collection('new_memory');

//delete a memory
  Future<void> _delete(String productId) async {
    await firestore.doc(productId).delete();

    ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a memory')));
  }

//update my memory
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    TextEditingController _place = TextEditingController();
    TextEditingController _date = TextEditingController();
    TextEditingController _content = TextEditingController();

    if (documentSnapshot != null) {
      _place.text = documentSnapshot['Place'];
      _date.text = documentSnapshot['Date'];
      _content.text = documentSnapshot['Content'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: this.context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _place,
                  decoration: const InputDecoration(
                      labelText: 'Where did you go/Title for your memory'),
                ),
                TextField(
                  controller: _date,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: _content,
                  decoration: const InputDecoration(
                      labelText:
                          'Memories(you can share your experience and memories with others)'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String place = _place.text;
                    final String date = _date.text;
                    final String content = _content.text;

                    await firestore.doc(documentSnapshot!.id).update(
                        {"Place": place, "Date": date, "Content": content});
                    _place.text = '';
                    _date.text = '';
                    _content.text = '';
                    Navigator.of(this.context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

//display my memories
  Future<void> _display() async {
    final Query<Map<String, dynamic>> _mem = FirebaseFirestore.instance
        .collection('new_memory')
        .where('Email', isEqualTo: _email.text);

    await showModalBottomSheet(
        isScrollControlled: true,
        context: this.context,
        builder: (BuildContext ctx) {
          return Scaffold(
            appBar: AppBar(
                title: Text("My Memories"),
                centerTitle: true,
                backgroundColor: Color.fromARGB(255, 11, 224, 135)),
            body: StreamBuilder(
              stream: _mem.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Text(
                                  documentSnapshot['Place'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 122, 118, 118)
                                          .withOpacity(1)),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Text(
                                  documentSnapshot['Date'],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 122, 118, 118)
                                          .withOpacity(0.9)),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Text(
                                  documentSnapshot['Content'],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 137, 134, 134)
                                          .withOpacity(0.9)),
                                ),
                              ),
                            ),
                            Row(children: <Widget>[
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: Color.fromARGB(255, 15, 152, 127),
                                  onPressed: () => _update(documentSnapshot)),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Color.fromARGB(255, 240, 82, 71),
                                  onPressed: () =>
                                      _delete(documentSnapshot.id)),
                            ])
                          ],
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(

    child: Column(children: [
      ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network("https://i.postimg.cc/7Z8kCBP9/i2.jpg"),
              ),
     ElevatedButton(onPressed: _display,
               style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.normal),
                  ),
                child: Text("View My Memories"))

     ],)
      

    
        
        
      
    );

    //throw UnimplementedError();
  }
}



//_update(DocumentSnapshot<Object?> documentSnapshot) {}

