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
  // _MyMemState(this._mem);
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

  /*final Query<Map<String, dynamic>> _mem = FirebaseFirestore.instance
        .collection('new_memory')
        .where('Email', isEqualTo:"akila@gmail.com");

Query<Map<String, dynamic>> getMainCollection() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('new_memory').where('Email', isEqualTo:"akila@gmail.com");
  }*/

//DocumentReference<T> doc([String? path]);

  //print("*****");
  //print(_email.text);

 final CollectionReference firestore =
      FirebaseFirestore.instance.collection('new_memory');

 Future<void> _delete(String productId) async {
    await firestore.doc(productId).delete();

    ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a memory')));
  }

//update my memory
  Future<void> _update([DocumentSnapshot? documentSnapshot, context]) async {
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
        context: context,
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
                  decoration: const InputDecoration(labelText: 'Place'),
                ),
                TextField(
                  controller: _date,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: _content,
                  decoration: const InputDecoration(labelText: 'Memory'),
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

                    /*    await _mem.doc(documentSnapshot!.id)
                        .update({"Place": place, "Date": date,"Content":content});
                    _place.text = '';
                    _date.text = '';
                     _content.text = '';
                    Navigator.of(context).pop();*/

                    await firestore
                        .where('Email', isEqualTo: "akila@gmail.com")
                        .get()
                        .then((snapshot) {
                      snapshot.docs.forEach((documentSnapshot) async {
                        //There must be a field in document snapshot that represents this doc Id
                        String thisDocId = documentSnapshot['Document ID'];
                        await firestore
                            .doc(thisDocId)
                            .update({
                          'Place': place,
                          'Date': date,
                          'Content': content
                        });
                      });
                    });
                  },
                )
              ],
            ),
          );
        });
  }

//display my memory
  @override
  Widget build(BuildContext context) {
    final Query<Map<String, dynamic>> _mem = FirebaseFirestore.instance
        .collection('new_memory')
        .where('Email', isEqualTo: "akila@gmail.com");

    return Scaffold(
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
                            onPressed: () => _delete(documentSnapshot.id)),
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
  }
}

_delete(String id) {}

_create() {}

//_update(DocumentSnapshot<Object?> documentSnapshot) {}


