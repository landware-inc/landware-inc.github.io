import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../common/commondata.dart';

class RoungeScreen extends StatefulWidget {
  const RoungeScreen({Key? key}) : super(key: key);

  @override
  State<RoungeScreen> createState() => _RoungeScreenState();
}

class _RoungeScreenState extends State<RoungeScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedInUser;
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedInUser = user;

        final uid = loggedInUser!.uid;

        final dio = Dio();

        final result  = await dio.post(
            '$appServerURL/getusrname',
            data: {
              'uuid': uid,
            },
        );

        userName = result.toString();
        print(userName);
      }
    } catch (e) {
      print(e);
    }
    finally {
      setState(() {});
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rounge'),
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('ID : ${loggedInUser!.uid}'),
            Text('Email : ${loggedInUser!.email}'),
            Text('Name : ${userName == null ? '' : userName}'),
            Text('Rounge'),
          ],
        ),
      ),
    );
  }
}
