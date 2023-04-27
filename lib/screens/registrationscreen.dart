import 'dart:ffi';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_login_test/common/commondata.dart';
import 'package:remedi_kopo/remedi_kopo.dart';


import '../status/controller.dart';
import 'component/bottom_menu.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final controller = Get.put(Controller());
  List<bool> isSelected = [true, false, false];
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  bool _isSales = false;
  bool _isJeonse = false;
  bool _isMonthly = false;
  int pyeong = 0;
  int canvasHeight = 0;
  final _AddressController = TextEditingController();
  final _AddressDetailController = TextEditingController();
  final _CallNameController = TextEditingController();
  final _SizeController = TextEditingController();
  final _TypeController = TextEditingController();
  final _RoomController = TextEditingController();
  final _BathController = TextEditingController();
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

  Map<String, String> formData = {};

  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _InDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('부동산 물건 등록'),
            pinned: false,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 10,),
                  ToggleButtons(
                    children: <Widget>[
                      Container(width: (MediaQuery.of(context).size.width - 36)/3.0, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.house,size: 20.0,color: Colors.red,),new SizedBox(width: 4.0,), new Text("주거용",style: TextStyle(color: Colors.red,fontSize: 20),)],)),
                      Container(width: (MediaQuery.of(context).size.width - 36)/3.0, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.add_business,size: 20.0,color: Colors.yellow[800],),new SizedBox(width: 4.0,), new Text("사업용",style: TextStyle(color: Colors.yellow[800],fontSize: 20))],)),
                      Container(width: (MediaQuery.of(context).size.width - 36)/3.0, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.domain,size: 20.0,color: Colors.blue,),new SizedBox(width: 4.0,), new Text("건물/토지",style: TextStyle(color: Colors.blue,fontSize: 20))],)),
                    ],
                    isSelected: isSelected,
                    onPressed: toggleSelect,
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height + canvasHeight,
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          for(int i = 0; i < isSelected.length; i++) {
                            if(i == index) {
                              isSelected[i] = true;

                              // if(i == 1) controller.selectGubun('전세');
                              // else if(i == 2) controller.selectGubun('월세');
                              // else controller.selectGubun('매매');

                            } else {
                              isSelected[i] = false;
                            }
                          }
                        });
                      },
                      children: [
                         _regidential(),
                         _commertial(),
                         _landbuilding(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(1.0),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10.0)),
                ),
                onPressed: (){},
                child: Text(
                  '등록하기',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }

  void toggleSelect(int index) async {
    setState(() {
      for(int i = 0; i < isSelected.length; i++) {
        if(i == index) {
          isSelected[i] = true;

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

  Widget _regidential() {
    return Form(
      key: _formKey,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5,),
            TextFormField(
              controller: _CallNameController,
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
                  width: 260,
                  height: 60,
                  child: TextFormField(
                    controller: _AddressController,
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
                            fontSize: 18,
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
                  width: 230,
                  height: 60,
                  child: TextFormField(
                    controller: _AddressDetailController,
                    decoration: InputDecoration(
                      labelText: '상세주소',
                      hintText: '상세 주소를 입력하세요',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 55,
                  height: 60,
                  child: TextFormField(
                    controller: _FloorController,
                    keyboardType: TextInputType.number,
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
                Text('/'),
                Container(
                  width: 55,
                  height: 60,
                  child: TextFormField(
                    controller: _TotalFloorController,
                    keyboardType: TextInputType.number,
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
                  width: 90,
                  height: 50,
                  child: TextFormField(
                    controller: _SizeController,
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
                        pyeong = (int.parse(value) / 3.3058).round();
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 70,
                  height: 50,
                    child: Text(
                      '$pyeong평',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    )
                ),
                Container(
                  width: 60,
                  height: 50,
                  child: TextFormField(
                    controller: _TypeController,
                    maxLength: 4,
                    decoration: InputDecoration(
                      labelText: '타입',
                      hintText: '타입',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 55,
                  height: 50,
                  child: TextFormField(
                    controller: _RoomController,
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
                Text('/'),
                Container(
                  width: 55,
                  height: 50,
                  child: TextFormField(
                    controller: _BathController,
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
                  width: 88,
                  height: 60,
                  child: DropdownButtonFormField(

                      items: ['남','남서','남동','서','동','북서','북동','북'].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _DirectionController = value.toString();
                      },
                      value: '남',
                      decoration: InputDecoration(
                        labelText: '방향',
                        hintText: '방향',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.red[50],
                      ),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: 120,
                  height: 60,
                  child: TextFormField(
                    controller: _InDateController,
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
                  width: 100,
                  height: 60,
                  child: DropdownButtonFormField(
           //         controller: _InDateTypeController,
                    value: '협의',
                    items: ['즉시','협의','지정일'].map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _InDateTypeController = value.toString();
                      },
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                          canvasHeight = canvasHeight + 220;
                        } else {
                          canvasHeight = canvasHeight - 220;
                        }
                      }
                    );
                  },
                ),
                SizedBox(width: 20,),
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
                        canvasHeight = canvasHeight + 150;
                      } else {
                        canvasHeight = canvasHeight - 150;
                      }
                    });
                  },
                ),
                SizedBox(width: 20,),
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
                      canvasHeight = canvasHeight + 230;
                    } else {
                      canvasHeight = canvasHeight - 230;
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
                  width: 130,
                  height: 60,
                  child : TextFormField(
                    controller: _Name1Controller,
                    decoration: InputDecoration(
                      labelText: '이름1',
                      hintText: '연락처 이름1',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 220,
                  height: 60,
                  child : TextFormField(
                    controller: _Tel1Controller,
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
                  width: 130,
                  height: 60,
                  child : TextFormField(
                    controller: _Name2Controller,
                    decoration: InputDecoration(
                      labelText: '이름2',
                      hintText: '이름2',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 220,
                  height: 60,
                  child : TextFormField(
                    controller: _Tel2Controller,
                    keyboardType: TextInputType.number,
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
                    controller: _SalesController,
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
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _DepositNowController,
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
                      labelText: '현임차보증금',
                      hintText: '현재 임대중이라면 임차 보증금을 적어 주세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _MonthlyNowController,
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
                    controller: _JeonseController,
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
                    controller: _DepositController,
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
                      labelText: '임차보증금',
                      hintText: '예정 임차보증 금액을 적어 주세요',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.red[50],
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _MonthlyController,
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
                    controller: _LoanController,
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
              controller: _DescController,
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              minLines: 8,
              decoration: InputDecoration(
                labelText: '특이사항',
                hintText: '기타 특이사항을 적어 주세요',
                border: OutlineInputBorder(),
              ),
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

  Widget _commertial() {
    return Container(
      color: Colors.blue,
    );
  }


  Widget _landbuilding() {
    return Container(
      color: Colors.cyan,
    );
  }

}


