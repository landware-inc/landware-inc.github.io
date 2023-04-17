import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../common/commondata.dart';
import 'component/asset_card.dart';


class ListViewScreen extends StatelessWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  Future<List> paginationAssetList() async {
    try {
      final dio = Dio();

      final response = await dio.post(
          '$appServerURL/selected',
          data: {
            'gubun': '전세',
            'callname': '',
            'minp': '12000',
            'maxp': '30000',
            'mins': '45',
            'maxs': '100',
          }
      );

      print(response.data);


      dio.close();

      return response.data;


    } catch(e) {
      print(e);
      return [];
    }
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
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder(
                future: paginationAssetList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: AssetCard(
                                  id: snapshot.data[index]['id'],
                                  image: Image.network(
                                    snapshot.data[index]['img1'] == ''
                                        ? '$appServerURL/sample.jpg'
                                        : '$appServerURL/${snapshot.data[index]['img1']}',
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
                                ),
                              );
                            },
                            childCount: snapshot.data.length,
                          ),
                        ),
                      ],
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
