import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../common/commondata.dart';
import 'component/asset_card.dart';


class ListViewScreen extends StatelessWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  Future<List> paginationAssetList() async {
    final dio = Dio();
    final response = await dio.get('$appServerURL/list');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    final _authentication = FirebaseAuth.instance;


    return Scaffold(
      appBar: AppBar(
        title: const Text('List test'),
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
              Get.back();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder(
                future: paginationAssetList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {

                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AssetCard(
                          id: snapshot.data[index]['id'],
                          image: Image.network('https://lh3.googleusercontent.com/tpCgvS5XdP40MFvx6jVq4SUDteZThkOmuG4hTbPRw-Wx0-afxlPwlmM4g6dIJRw=w600',
                            fit: BoxFit.cover,
                          ),
                          callname: snapshot.data[index]['callname'],
                          price: snapshot.data[index]['jeonse'] ?? 0,
                          room: snapshot.data[index]['room'] ?? 0,
                          bath: snapshot.data[index]['bath'] ?? 0,
                          sizetype: snapshot.data[index]['sizetype'],
                          direction: snapshot.data[index]['direction'],
                          indate: snapshot.data[index]['indate'],
                          floor: snapshot.data[index]['floor'],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
        ),
      ),
    );
  }
}
