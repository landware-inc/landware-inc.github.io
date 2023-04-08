import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoungeScreen extends StatefulWidget {
  const RoungeScreen({Key? key}) : super(key: key);

  @override
  State<RoungeScreen> createState() => _RoungeScreenState();
}

class _RoungeScreenState extends State<RoungeScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
        print(loggedInUser!.uid);
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rounge'),
      ),
      body: const Center(
        child: Text('Rounge'),
      ),);
  }
}
