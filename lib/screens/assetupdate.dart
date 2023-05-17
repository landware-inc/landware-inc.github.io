import 'dart:convert';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_login_test/common/commondata.dart';
import 'package:kakao_login_test/screens/assetdetailview.dart';
import 'package:kakao_login_test/screens/commdetailview.dart';
import 'package:remedi_kopo/remedi_kopo.dart';


import '../status/controller.dart';
import 'component/bottom_menu.dart';

class AssetUpdateScreen extends StatefulWidget {
  final int id;
  final int type;
  const AssetUpdateScreen({
    required this.id,
    required this.type,
    Key? key}) : super(key: key);

  @override
  State<AssetUpdateScreen> createState() => _AssetUpdateScreenState();
}




class _AssetUpdateScreenState extends State<AssetUpdateScreen> {
  final controller = Get.put(Controller());
  List<bool> isSelected = [true, false, false];
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  bool _isSales = false;
  bool _isJeonse = false;
  bool _isMonthly = false;
  bool _isSalesComm = false;
  bool _isJeonseComm = false;
  bool _isMonthlyComm = false;
  int pyeong = 0;
  double lat = 0;
  double lng = 0;
  int _selectedPage = 0;
  int _initvalue = 0;

  int canvasHeight = 835;
  final _AddressController = TextEditingController();
  final _AddressDetailController = TextEditingController();
  final _CallNameController = TextEditingController();
  final _SizeController = TextEditingController();
  final _TypeController = TextEditingController();
  final _RoomController = TextEditingController();
  final _BathController = TextEditingController();
  final _ParkingController = TextEditingController();
  final _AdminController = TextEditingController();
  final _EntitlePriceController = TextEditingController();
  bool  _ElevatorController = false;
  String _DirectionController = '남';
  final _InDateController = TextEditingController();
  String _InDateTypeController = '협의';
  final _FloorController = TextEditingController();
  final _Name1Controller = TextEditingController();
  final _Tel1Controller = TextEditingController();
  final _Name2Controller = TextEditingController();
  final _Tel2Controller = TextEditingController();
  final _DepositController = TextEditingController();
  final _MonthlyController = TextEditingController();
  final _SalesController = TextEditingController();
  final _JeonseController = TextEditingController();
  final _MonthlyNowController = TextEditingController();
  final _DepositNowController = TextEditingController();
  final _LoanController = TextEditingController();
  final _DescController = TextEditingController();
  final _TotalFloorController = TextEditingController();
  final _DivisionController = TextEditingController();

  Map<String, String> formData = {};

  final _formKey = GlobalKey<FormState>();
  final _formKeyComm = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _InDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }



  Future<List> pagenationDetailData() async {
    final dio = Dio();
    final response = await dio.post(
        '$appServerURL/homedetail',
        data: {
          'id': widget.id,
        }
    );
    dio.close();
    return response.data;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: pagenationDetailData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return Center(child: CircularProgressIndicator());
              } else {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text('부동산 물건 수정'),
                      pinned: false,
                      floating: true,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .background,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: 20,),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height + canvasHeight,
                              child: _regidential(snapshot),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          ),
      bottomNavigationBar: BottomMenuBar(),
    );
  }

  void toggleSelect(int index) async {
    setState(() {
      for(int i = 0; i < isSelected.length; i++) {
        if(i == index) {
          isSelected[i] = true;

          if(i == 1) _selectedPage = 1;
          else if(i == 2) _selectedPage = 2;
          else _selectedPage = 0;

          // if(i == 1) controller.selectGubun('전세');
          // else if(i == 2) controller.selectGubun('월세');
          // else controller.selectGubun('매매');

        } else {
          isSelected[i] = false;
        }
      }
      _controller.jumpToPage(index);
    }
    );
  }

  Widget _regidential(AsyncSnapshot snapshot) {
    pyeong = (snapshot.data[0]['size'] / 3.3058).toInt();

    if(_initvalue == 0 && snapshot.data[0]['salesprice'] > 0) {
      _isSales = true;
      _isSalesComm = true;

    }
    if(_initvalue == 0 && snapshot.data[0]['jeonse'] > 0) {
      _isJeonse = true;
      _isJeonseComm = true;

    }
    if(_initvalue == 0 && snapshot.data[0]['monthly'] > 0) {
      _isMonthly = true;
      _isMonthlyComm = true;

    }

    if(_initvalue == 0) {
      _AddressController.text = snapshot.data[0]['addr'];
      _InDateController.text = snapshot.data[0]['indate'];
    }

    _initvalue = 1;


    return Form(
      key: _formKey,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5,),
            TextFormField(
//              controller: _CallNameController,
              initialValue: snapshot.data[0]['callname'],
              validator: (value) {
                if(value!.isEmpty) {
                  return '필수 입력 항목입니다.';
                }
                return null;
              },
              onSaved: (value) {
                formData['callName'] = value!;
              },
              decoration: InputDecoration(
                labelText: '물건명',
                hintText: '단지명/건물명칭 등',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.red[50],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 130,
                  child: TextFormField(
                    controller: _AddressController,
                    validator: (value) {
                      if(value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formData['address'] = value!;
                    },
                    decoration: InputDecoration(
                      labelText: '주소',
                      hintText: '주소를 입력하세요',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: (){
                      _addressAPI();
                    },
                    child: Text(
                        '주소검색',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  child: TextFormField(
//                    controller: _AddressDetailController,
                    initialValue: snapshot.data[0]['addr2'],
                    // validator: (value) {
                    //   if(value!.isEmpty) {
                    //     return '필수 입력 항목입니다.';
                    //   }
                    //   return null;
                    // },
                    onSaved: (value) {
                      formData['addressDetail'] = value!;
                    },
                    decoration: InputDecoration(
                      labelText: '상세주소',
                      hintText: '상세 주소를 입력하세요',
                      border: OutlineInputBorder(),
                      // filled: true,
                      // fillColor: Colors.red[50],
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 58,
                  child: TextFormField(
//                    controller: _FloorController,
                    initialValue: snapshot.data[0]['floor'].toString(),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formData['floor'] = value!;
                    },
                    inputFormatters: [FilteringTextInputFormatter(RegExp('[0-9-]',), allow:true), ],
                    maxLength: 3,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: '층',
                      hintText: '층수',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                      counterText: '',
                    ),
                  ),
                ),
                Container(
                  width: 58,
                  child: TextFormField(
//                    controller: _TotalFloorController,
                    initialValue: snapshot.data[0]['totalfloor'].toString(),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if(value!.isEmpty) {
                        formData['totalFloor'] = '0';
                      } else {
                        formData['totalFloor'] = value!;
                      }
                    },
                    inputFormatters: [FilteringTextInputFormatter(RegExp('[0-9]',), allow:true), ],
                    maxLength: 3,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: '총층',
                      hintText: '총층',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Divider(thickness: 1, height: 1, color: Colors.indigo[300],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/3,
                  child: TextFormField(
//                    controller: _SizeController,
                    initialValue: snapshot.data[0]['size'].toString(),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formData['size'] = value!;
                    },
                    decoration: InputDecoration(
                      labelText: '면적(㎡)',
                      hintText: '면적(㎡)',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                      counterText: '',
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 7,
                    onChanged: (value) {
                      setState(() {
                        pyeong = (int.parse(value) / 3.3058).toInt();
                      });
                    },
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 58,
                  child: TextFormField(
//                    controller: _TypeController,
                    initialValue: snapshot.data[0]['sizetype'],
                    onSaved: (value) {
                      if(value!.isEmpty) {
                        formData['sizeType'] = '';
                      } else {
                        formData['sizeType'] = value!;
                      }
                    },
                    maxLength: 4,
                    decoration: InputDecoration(
                      labelText: '타입',
                      hintText: '타입',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 58,
                  child: TextFormField(
//                    controller: _RoomController,
                    initialValue: snapshot.data[0]['room'].toString(),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formData['room'] = value!;
                    },
                    inputFormatters: [FilteringTextInputFormatter(RegExp('[0-9]'), allow:true), ],
                    decoration: InputDecoration(
                      labelText: '방수',
                      hintText: '방수',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                      counterText: '',
                    ),
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  width: 58 ,
                  child: TextFormField(
//                    controller: _BathController,
                    initialValue: snapshot.data[0]['bath'].toString(),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formData['bath'] = value!;
                    },
                    inputFormatters: [FilteringTextInputFormatter(RegExp('[0-9]'), allow:true), ],
                    decoration: InputDecoration(
                      labelText: '욕실',
                      hintText: '욕실',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                      counterText: '',
                    ),
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Divider(thickness: 1, height: 1, color: Colors.indigo[300],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/3,
                    alignment: Alignment.centerRight,
                    height: 30,
                    child: Text(
                      '약 $pyeong평',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )
                ),
                Container(
                  width: 115,
                  height: 60,
                  child: DropdownButtonFormField(

                    items: ['아파트','오피','도생','빌라','원룸','주택','다가구','상가주택'].map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      formData['Type'] = value!.toString();
                    },
                    onSaved: (value) {
                      formData['Type'] = value!.toString();
                    },
                    value: snapshot.data[0]['type'],
                    decoration: InputDecoration(
                      labelText: '종류',
                      hintText: '종류',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Divider(thickness: 1, height: 1, color: Colors.indigo[300],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: 60,
                  child: DropdownButtonFormField(

                    items: ['남','남서','남동','서','동','북서','북동','북','동북','동남','서북','서남',''].map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _DirectionController = value.toString();
                    },
                    onSaved: (value) {
                      formData['direction'] = value!.toString();
                    },
                    value: snapshot.data[0]['direction'] ?? '남',
                    decoration: InputDecoration(
                      labelText: '방향',
                      hintText: '방향',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: MediaQuery.of(context).size.width/3.3,
                  height: 60,
                  child: TextFormField(
                    controller: _InDateController,
                    onSaved: (value) {
                      formData['inDate'] = value!.replaceAll('-', '/');
                    },
                    readOnly: true,
                    onTap: (){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2024),
                      ).then((value) => setState(() {
                        _InDateController.text = value.toString().substring(0,10);
                      })
                      );
                    },
                    decoration: InputDecoration(
                      labelText: '입주일',
                      hintText: '입주가능 일자',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/3.3,
                  height: 60,
                  child: DropdownButtonFormField(
                    //controller: _InDateTypeController,
                    onSaved: (value) {
                      formData['inDateType'] = value!.toString();
                    },
                    items: ['즉시','협의','지정일'].map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _InDateTypeController = value.toString();
                    },
                    value: snapshot.data[0]['indatetype'] ?? '협의',
                    decoration: InputDecoration(
                      labelText: '입주조건',
                      hintText: '입주조건',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Divider(thickness: 1, height: 1, color: Colors.indigo[300],),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '매매',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  activeColor: Theme.of(context).colorScheme.error,
                  inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                  value : _isSales,
                  onChanged: (value) {
                    setState(() {
                      _isSales = value!;
                      if(_isSales) {
                        canvasHeight = canvasHeight + 270;
                      } else {
                        canvasHeight = canvasHeight - 270;
                      }
                    }
                    );
                  },
                ),
                SizedBox(width: 10,),
                Text(
                  '전세',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  activeColor: Theme.of(context).colorScheme.error,
                  inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                  value : _isJeonse,
                  onChanged: (value) {
                    setState(() {
                      _isJeonse = value!;
                      if(_isJeonse) {
                        canvasHeight = canvasHeight + 190;
                      } else {
                        canvasHeight = canvasHeight - 190;
                      }
                    });
                  },
                ),
                SizedBox(width: 10,),
                Text(
                  '월세',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  activeColor: Theme.of(context).colorScheme.error,
                  inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                  value : _isMonthly,
                  onChanged: (value) {
                    setState(() {
                      _isMonthly = value!;
                    });
                    if(_isMonthly) {
                      canvasHeight = canvasHeight + 265;
                    } else {
                      canvasHeight = canvasHeight - 265;
                    }
                  },
                ),
              ],
            ),
            Divider(thickness: 1, height: 1, color: Colors.indigo[300],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  child : TextFormField(
//                    controller: _Name1Controller,

                    validator: (value) {
                      if(value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formData['name1'] = value!;
                    },
                    decoration: InputDecoration(
                      labelText: '이름1',
                      hintText: '연락처 이름1',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                    initialValue: snapshot.data[0]['name1'],
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  child : TextFormField(
//                    controller: _Tel1Controller,
                  initialValue: snapshot.data[0]['phone1'],
                    validator: (value) {
                      if(value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formData['tel1'] = value!;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, //숫자만!
                      NumberFormatter(), // 자동하이픈
                      LengthLimitingTextInputFormatter(13) //13자리만 입력받도록 하이픈 2개+숫자 11개
                    ],
                    decoration: InputDecoration(
                      labelText: '연락처1',
                      hintText: '연락처1',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 60,
                  child : TextFormField(
//                    controller: _Name2Controller,
                    initialValue: snapshot.data[0]['name2'],
                    onSaved: (value) {
                      if(value!.isEmpty) {
                        formData['name2'] = '';
                      } else {
                        formData['name2'] = value!;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: '이름2',
                      hintText: '이름2',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  height: 60,
                  child : TextFormField(
//                    controller: _Tel2Controller,
                    initialValue: snapshot.data[0]['phone2'],
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if(value!.isEmpty) {
                        formData['tel2'] = '';
                      } else {
                        formData['tel2'] = value!;
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, //숫자만!
                      NumberFormatter(), // 자동하이픈
                      LengthLimitingTextInputFormatter(13) //13자리만 입력받도록 하이픈 2개+숫자 11개
                    ],
                    decoration: InputDecoration(
                      labelText: '연락처2',
                      hintText: '연락처2',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _isSales,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  TextFormField(
//                    controller: _SalesController,

                    validator: (value) {
                      if(_isSales & value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formData['sales'] = value!;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'ko',
                        decimalDigits: 0,
                        symbol: '₩',
                      )
                    ],
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      labelText: '매매가격',
                      hintText: '매매 예정 금액을 적어 주세요',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                    initialValue: snapshot.data[0]['salesprice'].toString(),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
//                    controller: _DepositNowController,
                    initialValue: snapshot.data[0]['currentdeposit'].toString(),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if(value!.isEmpty) {
                        formData['depositNow'] = '0';
                      } else {
                        formData['depositNow'] = value!;
                      }
                    },
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'ko',
                        decimalDigits: 0,
                        symbol: '₩',
                      )
                    ],
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      labelText: '현임차보증금',
                      hintText: '현재 임대중이라면 임차 보증금을 적어 주세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
//                    controller: _MonthlyNowController,
                  initialValue: snapshot.data[0]['currentmonthly'].toString(),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if(value!.isEmpty) {
                        formData['monthlyNow'] = '0';
                      } else {
                        formData['monthlyNow'] = value!;
                      }
                    },
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'ko',
                        decimalDigits: 0,
                        symbol: '₩',
                      )
                    ],
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      labelText: '현월차임',
                      hintText: '현재 임대중이라면 월 차임을 적어 주세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isJeonse,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  TextFormField(
//                    controller: _JeonseController,
                    initialValue: snapshot.data[0]['jeonse'].toString(),
                    validator: (value) {
                      if(_isJeonse & value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formData['jeonse'] = value!;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'ko',
                        decimalDigits: 0,
                        symbol: '₩',
                      )
                    ],
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      labelText: '전세가격',
                      hintText: '전세 예정 금액을 적어 주세요',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isMonthly,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  TextFormField(
//                    controller: _DepositController,
                    initialValue: snapshot.data[0]['deposit'].toString(),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if(value!.isEmpty) {
                        formData['deposit'] = '0';
                      } else {
                        formData['deposit'] = value!;
                      }
                    },
                    validator: (value) {
                      if(_isMonthly & value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'ko',
                        decimalDigits: 0,
                        symbol: '₩',
                      )
                    ],
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      labelText: '임차보증금',
                      hintText: '예정 임차보증 금액을 적어 주세요',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
//                    controller: _MonthlyController,
                    initialValue: snapshot.data[0]['monthly'].toString(),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if(value!.isEmpty) {
                        formData['monthly'] = '0';
                      } else {
                        formData['monthly'] = value!;
                      }
                    },
                    validator: (value) {
                      if(_isMonthly & value!.isEmpty) {
                        return '필수 입력 항목입니다.';
                      }
                      return null;
                    },
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'ko',
                        decimalDigits: 0,
                        symbol: '₩',
                      )
                    ],
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      labelText: '월차임',
                      hintText: '예정 월 차임을 적어 주세요',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isMonthly || _isJeonse,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  TextFormField(
//                    controller: _LoanController,
                    initialValue: snapshot.data[0]['loan'].toString(),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if(value!.isEmpty) {
                        formData['loan'] = '0';
                      } else {
                        formData['loan'] = value!;
                      }
                    },
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'ko',
                        decimalDigits: 0,
                        symbol: '₩',
                      )
                    ],
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      labelText: '대출금액',
                      hintText: '임대 예정 물건에 대출이 있으면 그 금액을 적어 주세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(thickness: 1, height: 1, color: Colors.indigo[300],),
            TextFormField(
//              controller: _DescController,
              initialValue: snapshot.data[0]['description'].toString(),
              keyboardType: TextInputType.multiline,
              onSaved: (value) {
                if(value!.isEmpty) {
                  formData['desc'] = '';
                } else {
                  formData['desc'] = value!;
                }
              },
              maxLines: 8,
              minLines: 8,
              decoration: InputDecoration(
                labelText: '특이사항',
                hintText: '기타 특이사항을 적어 주세요',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(1.0),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10.0)),
                  ),
                  onPressed: () async {
                      if (!_isSales && !_isJeonse && !_isMonthly) {
                        Get.snackbar('등록 오류', '거래유형을 최소 한가지 이상 선택해주세요.');
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        try {
                          final dio = Dio();

                          String gpsUrl =
                              'https://maps.googleapis.com/maps/api/geocode/json?address=${formData['address']}&key=$googleMapKey&language=ko';
                          try{
                            final responseGps = await dio.get(gpsUrl);

                            var rst = jsonDecode(responseGps.toString());

                            lat = rst['results'][0]['geometry']['location']['lat'];
                            lng = rst['results'][0]['geometry']['location']['lng'];
                            // print(response.data[0]['addr']);
                          } catch(e) {
                            lat = 0;
                            lng = 0;
                          }


                          final response = await dio.post(
                              '$appServerURL/updateasset',
                              data: {
                                'selectedpage': _selectedPage,
                                'id': widget.id,
                                'callname': formData['callName'],
                                'addr1': formData['address'],
                                'addr2': formData['addressDetail'] ?? '',
                                'size': formData['size'],
                                'sizetype': formData['sizeType'] ?? '',
                                'indate': formData['inDate'],
                                'indatetype': formData['inDateType'],
                                'floor': formData['floor'],
                                'totalfloor': formData['totalFloor'] ?? 0,
                                'room': formData['room'],
                                'bath': formData['bath'],
                                'type': formData['Type'],
                                'direction': formData['direction'],
                                'name1': formData['name1'] ?? '',
                                'name2': formData['name2'] ?? '',
                                'phone1': formData['tel1'],
                                'phone2': formData['tel2'] ?? '',
                                'sales': formData['sales'] == null
                                    ? 0
                                    : formData['sales']!.replaceAll('₩', '')
                                    .replaceAll(',', ''),
                                'jeonse': formData['jeonse'] == null
                                    ? 0
                                    : formData['jeonse']!.replaceAll('₩', '')
                                    .replaceAll(',', ''),
                                'deposit': formData['deposit'] == null
                                    ? 0
                                    : formData['deposit']!.replaceAll('₩', '')
                                    .replaceAll(',', ''),
                                'monthly': formData['monthly'] == null
                                    ? 0
                                    : formData['monthly']!.replaceAll('₩', '')
                                    .replaceAll(',', ''),
                                'loan': formData['loan'] == null
                                    ? 0
                                    : formData['loan']!.replaceAll('₩', '')
                                    .replaceAll(',', ''),
                                'depositnow': formData['depositNow'] == null
                                    ? 0
                                    : formData['depositNow']!.replaceAll('₩', '')
                                    .replaceAll(',', ''),
                                'monthlynow': formData['monthlyNow'] == null
                                    ? 0
                                    : formData['monthlyNow']!.replaceAll('₩', '')
                                    .replaceAll(',', ''),
                                'lat': lat,
                                'lng': lng,
                                'desc': formData['desc'] ?? '',
                                'date': DateTime.now().toString(),
                                'owner': controller.userName.value,
                              }
                          );

                          print(response.data);

                          dio.close();

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('수정 완료'),
                                  content: Text('수정이 완료되었습니다.'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.off(AssetDetailViewScreen(id: widget.id));
                                        },
                                        child: Text('확인')
                                    )
                                  ],
                                );
                              }
                          );

                          return response.data;
                        } catch (e) {
                          print(e);
                        }
                      }
                  },
                  child: Text(
                    '수정하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _addressAPI() async {
    KopoModel model = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );

    if (model != null) {
      final address = model.address ?? '';
      _AddressController.value = TextEditingValue(
        text: address,
      );
      formData['address'] = address;
    }
  }
}
