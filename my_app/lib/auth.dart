import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class fireauth extends StatefulWidget {
  const fireauth({Key? key}) : super(key: key);
  @override
  State<fireauth> createState() => _fireauthstate();
}

class _fireauthstate extends State<fireauth> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  var error = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Firebase activity"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 195, 216, 75)),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(100),
          child: Center(
            child: Column(children: [
              Container(
                  width: 300,
                  color: Color.fromARGB(255, 222, 237, 189),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(
                              15), //apply padding to all four sides
                          child: TextFormField(
                            controller: _email,
                            onChanged: (value) {
                              error = "";
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return "Email is required!";
                              }
                              if (!RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value)) {
                                return "Enter a valid email..!";
                              }
                            }),
                          )),
                      Padding(
                          padding: EdgeInsets.all(
                              15), //apply padding to all four sides
                          child: TextFormField(
                            controller: _password,
                            onChanged: (value) {
                              error = "";
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return "Password is required!";
                              }
                              if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(value)) {
                                return "Password must be at least 8 characters long";
                              }
                            }),
                          )),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(error,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 233, 27, 27))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Container(
                          alignment: FractionalOffset.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: signin, child: Text("Sign In")),
                                ElevatedButton(
                                    onPressed: signUp, child: Text("Sign up")),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: ElevatedButton(
                            onPressed: signInWithGoogle,
                            child: Text("Sign in with google")),
                      )
                    ],
                  )),
            ]),
          ),
        ));
  }

  signUp() async {
    print(_email.text);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signin() async {
    print(_email.text);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        print(error);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }
}
