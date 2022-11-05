import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyMem extends StatefulWidget {
  const MyMem({super.key});

  @override
  State<MyMem> createState() => _MyMemState();
}

class _MyMemState extends State<MyMem> {
  final CollectionReference _mem =
      FirebaseFirestore.instance.collection('new_memory');

  @override
  Widget build(BuildContext context) {
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
                      ],
                    ));
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
// Add new product
      /* floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat*/
    );
  }
}

_delete(String id) {}

_create() {}

_update(DocumentSnapshot<Object?> documentSnapshot) {}
