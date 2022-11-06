import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import './home.dart';
import './auth.dart';
import 'package:flutter/material.dart';


//if login success load home page else redirect to sign up page
class landing extends StatefulWidget {
  const landing({Key? key}) : super(key: key);

  @override
  State<landing> createState() => _landingState();
}

class _landingState extends State<landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: StreamBuilder(
        
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyApp();
          } else {
            return fireauth();
          }
        },
      ),
    );
  }
}
