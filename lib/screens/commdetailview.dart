
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dio/src/form_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kakao_login_test/screens/component/bottom_menu.dart';
import 'package:http_parser/http_parser.dart';

import '../common/commondata.dart';



class CommDetailViewScreen extends StatefulWidget {
  final int id;


  CommDetailViewScreen({
    required this.id,
    Key? key}) : super(key: key);


  @override
  State<CommDetailViewScreen> createState() => _CommDetailViewScreenState();
}

class _CommDetailViewScreenState extends State<CommDetailViewScreen> {
  double _lat = 0.0;

  double _lng = 0.0;

  final ImagePicker _picker = ImagePicker();

  List<XFile> _pickedImgs = [];

  Future<void> _pickImg() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImgs = images;

      });
    }
  }



  Future<List> pagenationDetailData() async {
    final dio = Dio();
    final response = await dio.post(
        '$appServerURL/commdetail',
        data: {
          'id': widget.id,
        }
    );

    _lat = double.parse(response.data[0]['lat'].toString());
    _lng = double.parse(response.data[0]['lng'].toString());

    dio.close();
    return response.data;
  }

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context)  {
    final _authentication = FirebaseAuth.instance;
    var f = NumberFormat('###,###,###,###');
    PageController _controller = PageController(initialPage: 0, keepPage: false);
    PageController _controllerMain = PageController(initialPage: 0, keepPage: false);
    List<String> _imgList = [];
    List<Widget> _boxContents = [
      IconButton(
        onPressed: () {
          _pickImg();
        },
        icon: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 3,
            ),
          ),
          child: Icon(
              Icons.photo,
              color: Colors.red,
              size: 24,
          ),
        ),
      ),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      _pickedImgs.length <= 9 ? Container() : FittedBox(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Text(
            '+${(_pickedImgs.length - 9).toString()}',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    ];





    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Detail View'),
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
              getx.Get.back();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: BottomMenuBar(),
      body: PageView(
        controller: _controllerMain,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: FutureBuilder(
              future: pagenationDetailData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _imgList = [
                    snapshot.data[0]['img_1'],
                    snapshot.data[0]['img_2'],
                    snapshot.data[0]['img_3'],
                    snapshot.data[0]['img_4'],
                    snapshot.data[0]['img_5'],
                    snapshot.data[0]['img_6'],
                  ];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: (MediaQuery.of(context).size.width / 13) * 7,
                          child: PageView(
                            controller: _controller,
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  snapshot.data[0]['img_1'] == ''
                                      ? '$appServerURL/sample.jpg'
                                      : '$appServerURL/${snapshot.data[0]['img_1']}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              ClipRRect(
                                child: Image.network(
                                  snapshot.data[0]['img_2'] == ''
                                      ? '$appServerURL/sample.jpg'
                                      : '$appServerURL/${snapshot.data[0]['img_2']}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              ClipRRect(
                                child: Image.network(
                                  snapshot.data[0]['img_3'] == ''
                                      ? '$appServerURL/sample.jpg'
                                      : '$appServerURL/${snapshot.data[0]['img_3']}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              ClipRRect(
                                child: Image.network(
                                  snapshot.data[0]['img_4'] == ''
                                      ? '$appServerURL/sample.jpg'
                                      : '$appServerURL/${snapshot.data[0]['img_4']}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              ClipRRect(
                                child: Image.network(
                                  snapshot.data[0]['img_5'] == ''
                                      ? '$appServerURL/sample.jpg'
                                      : '$appServerURL/${snapshot.data[0]['img_5']}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              ClipRRect(
                                child: Image.network(
                                  snapshot.data[0]['img_6'] == ''
                                      ? '$appServerURL/sample.jpg'
                                      : '$appServerURL/${snapshot.data[0]['img_6']}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Theme.of(context).colorScheme.primary, thickness: 1.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data[0]['division'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            Text(
                              snapshot.data[0]['type'] ?? '',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '면적 : ${snapshot.data[0]['size'] ?? ''} 평',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            Text(
                              '${snapshot.data[0]['floor'] ?? ''}층',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            Text(
                              '엘리베이터 : ${snapshot.data[0]['eliv'] == '1' ? 'O' : 'X'}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Theme.of(context).colorScheme.primary, thickness: 1.0),
                        Text(
                          '주차 : ${snapshot.data[0]['parking'] == '' ? '0' : snapshot.data[0]['parking']}대',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        if(snapshot.data[0]['entitleprice'] > 0)
                          Text(
                            '권리금 : ${f.format(int.parse(snapshot.data[0]['entitleprice'].toString()))}만원',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        if(snapshot.data[0]['deposit'] > 0)
                          Row(
                            children: [
                              Text(
                                '보증금 : ${f.format(int.parse(snapshot.data[0]['deposit'].toString()))}만원',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                              ),
                              Text(
                                ' / 월세 : ${f.format(int.parse(snapshot.data[0]['monthly'].toString()))}만원',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        if(snapshot.data[0]['salesprice'] > 0)
                          Text(
                            '매매가 : ${f.format(int.parse(snapshot.data[0]['salesprice'].toString()))}만원',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          '연락처 : ${snapshot.data[0]['tel'] ?? ''}',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        Divider(color: Theme.of(context).colorScheme.primary, thickness: 1.0),
                        GestureDetector(
                          onTap: () {
                            _controllerMain.jumpToPage(1);
                          },
                          child: Container(
                            margin: EdgeInsets.all(3.0),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network('https://maps.googleapis.com/maps/api/staticmap?center=&{$_lat,$_lng},zoom=13&size=${(MediaQuery.of(context).size.width*0.97).round()}x197&maptype=roadmap&markers=color:red%7C$_lat,$_lng&key=$googleMapKey'),
                          ),
                        ),
                        Divider(color: Theme.of(context).colorScheme.primary, thickness: 1.0),
                        Text('접수일자 : ${DateFormat('yyyy/MM/dd').format(DateTime.parse(snapshot.data[0]['date']))}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text('비고 : ${snapshot.data[0]['etc'] ?? ''}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          '상세주소 : ${snapshot.data[0]['addr'] ?? ''}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        Divider(color: Theme.of(context).colorScheme.primary, thickness: 1.0),
                        SizedBox(
                          height: MediaQuery.of(context).size.width/1.5,
                          child : GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 5.0,
                            childAspectRatio: 2/1.3,
                            padding: EdgeInsets.all(5.0),
                            children: List.generate(
                                9,
                                (index) => DottedBorder(
                                  color: Theme.of(context).colorScheme.primary,
                                  strokeWidth: 1,
                                  dashPattern: [5, 5],
                                  child: Container(
                                    decoration:
                                      index <= _pickedImgs.length -1
                                          ? BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Theme.of(context).colorScheme.primaryContainer,
                                             image: DecorationImage(
                                                image: FileImage(File(_pickedImgs[index].path)),
                                                fit: BoxFit.fitHeight,
                                              ),
                                        ) :
                                        index <= _imgList.length -1
                                          ? BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Theme.of(context).colorScheme.primaryContainer,
                                             image: DecorationImage(
                                                image: _imgList[index] == '' ? NetworkImage('$appServerURL/sample.jpg',) :  NetworkImage('$appServerURL/$_imgList[index]',),
                                                fit: BoxFit.fitHeight,
                                              ),
                                        ) : null,
                                    child : Center(child: _boxContents[index]),

                                   //  decoration: index <= _imgList.length -1
                                   //    ? _imgList[index] == '' ? Image.network('$appServerURL/sample.jpg', fit: BoxFit.cover,) :  Image.network('$appServerURL/$_imgList[index]', fit: BoxFit.cover,)
                                   //    : IconButton(
                                   //      icon: Icon(Icons.add),
                                   //      onPressed: () {
                                   // //       _pickedImgs();
                                   //      },
                                   //    ),
                                  ),
                                ),
                              ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              onPressed: _pickedImgs.length == 0
                                  ? null
                                  : () async {
                                        final List<MultipartFile> _files =  _pickedImgs.map((img) => MultipartFile.fromFileSync(img.path,  contentType: new MediaType("image", "jpg"))).toList();
                                        FormData _formData = FormData.fromMap({"uploadfile": _files});

                                        Dio dio = Dio();

                                        // dio.options.headers["authorization"] = AuthProvider.token;
                                        dio.options.contentType = 'multipart/form-data';
                                        dio.options.maxRedirects.isFinite;
                                        //
                                        final res = await dio.post('$appServerURL/upload', data: _formData).then((res) {
                                          getx.Get.back();
                                          return res.data;
                                        });

                                        dio.close();

                                      },
                              child: Text('사진 수정하기'),
                            ),
                          ]
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Container(
            child: FutureBuilder(
                future: pagenationDetailData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_lat, _lng),
                        zoom: 17,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('marker_1'),
                          position: LatLng(_lat, _lng),
                        ),
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}


