

import 'dart:convert';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kakao_login_test/screens/regidentiallistview.dart';

import '../status/controller.dart';

class ResidentialScreen extends StatefulWidget {
  const ResidentialScreen({Key? key}) : super(key: key);

  @override
  State<ResidentialScreen> createState() => _ResidentialScreenState();
}

class _ResidentialScreenState extends State<ResidentialScreen> {
  final _authentication = FirebaseAuth.instance;
  final controller = Get.put(Controller());
  User? loggedInUser;
  String? userName;
  String result = '';
  List<bool> isSelected = [true, false, false];
  RangeValues values =   RangeValues(0, 150000);
  RangeValues values2 =  RangeValues(0, 50000);
  RangeValues values3 =  RangeValues(0, 45000);
  RangeValues values4 =  RangeValues(0, 150);
  RangeValues values5 =  RangeValues(0, 300);
  double pickerValue = 0;
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  TextEditingController _textEditingControllerMin = TextEditingController();
  TextEditingController _textEditingControllerMax = TextEditingController();
  TextEditingController _textEditingControllerMinJ = TextEditingController();
  TextEditingController _textEditingControllerMaxJ = TextEditingController();
  TextEditingController _textEditingControllerMinD = TextEditingController();
  TextEditingController _textEditingControllerMaxD = TextEditingController();
  TextEditingController _textEditingControllerMinM = TextEditingController();
  TextEditingController _textEditingControllerMaxM = TextEditingController();
  TextEditingController _textEditingControllerMinSize = TextEditingController();
  TextEditingController _textEditingControllerMaxSize = TextEditingController();
  List<Widget> _list = [Text('모든가격')];
  List<Widget> _listJ = [Text('모든가격')];
  List<Widget> _listD = [Text('모든가격')];
  List<Widget> _listM = [Text('모든가격')];
  List<Widget> _listSize = [Text('모든평수')];
  String selectedRoomCount = '0';
  var f = NumberFormat('###,###,###,###');



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initRangeVlues();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('주거용 검색 조건'),
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15,),
              TextFormField(
                key: ValueKey(1),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  controller.selectCallname(value!);
                },
                onChanged: (value) {
                  controller.selectCallname(value!);
                },
                decoration: InputDecoration(
                  hintText: '단지/동명 (없으면 모든 단지/동)',
                  labelText: '단지/동명',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    letterSpacing: 1.0,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ToggleButtons(
                      children: <Widget>[
                        Container(width: (MediaQuery.of(context).size.width - 36)/4.5, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.domain,size: 20.0,color: Colors.red,),new SizedBox(width: 4.0,), new Text("매매",style: TextStyle(color: Colors.red,fontSize: 20),)],)),
                        Container(width: (MediaQuery.of(context).size.width - 36)/4.5, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.add_business,size: 20.0,color: Colors.yellow[800],),new SizedBox(width: 4.0,), new Text("전세",style: TextStyle(color: Colors.yellow[800],fontSize: 20))],)),
                        Container(width: (MediaQuery.of(context).size.width - 36)/4.5, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.meeting_room,size: 20.0,color: Colors.blue,),new SizedBox(width: 4.0,), new Text("월세",style: TextStyle(color: Colors.blue,fontSize: 20))],)),
                      ],
                      isSelected: isSelected,
                      onPressed: toggleSelect,
                  ),
                  SizedBox(width: 20,),
                  Text('방 : ',style: TextStyle(fontSize: 18),),
                  DropdownButton(
                    value: selectedRoomCount,
                    onChanged: (index){
                      setState(() {
                        selectedRoomCount = index.toString();
                        controller.roomCount(selectedRoomCount);
                      });
                    },
                      items: [
                        DropdownMenuItem(
                          child: Text('무관'),
                          value: '0',
                        ),
                        DropdownMenuItem(
                          child: Text('1'),
                          value: '1',
                        ),
                        DropdownMenuItem(
                          child: Text('2'),
                          value: '2',
                        ),
                        DropdownMenuItem(
                          child: Text('3'),
                          value: '3',
                        ),
                        DropdownMenuItem(
                          child: Text('4 +'),
                          value: '4',
                        ),
                      ],
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 318,
                child: PageView(
                  pageSnapping: true,
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      for(int i = 0; i < isSelected.length; i++) {
                        if(i == index) {
                          isSelected[i] = true;

                          if(i == 1) controller.selectGubun('전세');
                          else if(i == 2) controller.selectGubun('월세');
                          else controller.selectGubun('매매');

                        } else {
                          isSelected[i] = false;
                        }
                      }
                    });
                  },
                  children: [

                    Column(
                      children: [
                            SizedBox(height: 25,),
                            Text(
                                '매매 가격',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                    child: TextField(
                                      textAlign: TextAlign.right ,
                                      controller: _textEditingControllerMin,
                                      inputFormatters: [CurrencyTextInputFormatter(
                                          locale: 'ko_KR',
                                          decimalDigits: 0,
                                          symbol: '',
                                      )],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: '최소',
                                        labelText: '최소',
                                        hintStyle: TextStyle(
                                          color: Theme.of(context).colorScheme.outline,
                                          letterSpacing: 1.0,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        contentPadding: EdgeInsets.all(10),

                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).colorScheme.onBackground,
                                          ),
               //                           borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).colorScheme.outlineVariant,
                                          ),
                //                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                      ),
                                    )
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 85,
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: CupertinoPicker(
                                    itemExtent: 40,
                                    diameterRatio: 5,
                                    offAxisFraction: -1.0,
                                      scrollController: FixedExtentScrollController(initialItem: 0),
                                      squeeze: 1.0,
                                      onSelectedItemChanged: (index) {
                                        if(index == 0) {
                                          _textEditingControllerMin.text = f.format(controller.minS.value);
                                          _textEditingControllerMax.text = f.format(controller.maxS.value);
                                          controller.minPrice(controller.minS.value.toInt());
                                          controller.maxPrice(controller.maxS.value.toInt());
                                        } else {
                                          _textEditingControllerMin.text = f.format(((index) * 5000 - 5000));
                                          _textEditingControllerMax.text = f.format(((index + 1) * 5000));
                                          controller.minPrice(((index) * 5000 -5000));
                                          controller.maxPrice(((index + 1) * 5000));
                                        }
                                      },
                                      children: _list,
                                  ),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    child: TextField(
                                      textAlign: TextAlign.right ,
                                      controller: _textEditingControllerMax,
                                      key: ValueKey(1),
                                      inputFormatters: [CurrencyTextInputFormatter(
                                        locale: 'ko_KR',
                                        decimalDigits: 0,
                                        symbol: '',
                                      )],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: '최대',
                                        labelText: '최대',
                                        hintStyle: TextStyle(
                                          color: Theme.of(context).colorScheme.outline,
                                          letterSpacing: 1.0,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).colorScheme.onBackground,
                                          ),
                            //              borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).colorScheme.outlineVariant,
                                          ),
                             //             borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ]
                      ),


/*                      GetX<Controller>( // init을 통해 Controller를 등록할 수 있지만 여기선 Get.put을 사용
                          builder: (_) => Text(
                            '최대: ${_.maxPrice.value}',
                          ),
                        ),
                        RangeSlider(
                            max: controller.maxS.value.toDouble(),
                            min: controller.minS.value.toDouble(),
                            values: values,
                            divisions: 50,
                            onChanged: onPickerChanged,
                            labels: RangeLabels(
                              values.start.round().toString(),
                              values.end.round().toString(),
                            ),
                          ),
                        GetX<Controller>( // init을 통해 Controller를 등록할 수 있지만 여기선 Get.put을 사용
                          builder: (_) => Text(
                            '최소: ${_.minPrice.value}',
                          ),
                        ), */


                    Column(
                      children: [
                        SizedBox(height: 25,),
                        Text('전세 가격',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextField(
                                  textAlign: TextAlign.right ,
                                  controller: _textEditingControllerMinJ,
                                  inputFormatters: [CurrencyTextInputFormatter(
                                    locale: 'ko_KR',
                                    decimalDigits: 0,
                                    symbol: '',
                                  )],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '최소',
                                    labelText: '최소',
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.outline,
                                      letterSpacing: 1.0,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    contentPadding: EdgeInsets.all(10),

                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                      //                           borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.outlineVariant,
                                      ),
                                      //                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                )
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 85,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CupertinoPicker(
                                itemExtent: 40,
                                diameterRatio: 5,
                                offAxisFraction: -1.0,
                                scrollController: FixedExtentScrollController(initialItem: 0),
                                squeeze: 1.0,
                                onSelectedItemChanged: (index) {
                                  if(index == 0) {
                                    _textEditingControllerMinJ.text = f.format(controller.minJ.value);
                                    _textEditingControllerMaxJ.text = f.format(controller.maxJ.value);
                                    controller.minJeonse(controller.minJ.value.toInt());
                                    controller.maxJeonse(controller.maxJ.value.toInt());
                                  } else {
                                    _textEditingControllerMinJ.text = f.format(((index) * 5000 - 5000));
                                    _textEditingControllerMaxJ.text = f.format(((index + 1) * 5000));
                                    controller.minJeonse(((index) * 5000 -5000));
                                    controller.maxJeonse(((index + 1) * 5000));
                                  }
                                },
                                children: _listJ,
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextField(
                                  textAlign: TextAlign.right ,
                                  controller: _textEditingControllerMaxJ,
                                  key: ValueKey(1),
                                  inputFormatters: [CurrencyTextInputFormatter(
                                    locale: 'ko_KR',
                                    decimalDigits: 0,
                                    symbol: '',
                                  )],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '최대',
                                    labelText: '최대',
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.outline,
                                      letterSpacing: 1.0,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                      //              borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.outlineVariant,
                                      ),
                                      //             borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 25,),
                            Text(
                                '보증금',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    child: TextField(
                                      textAlign: TextAlign.right ,
                                      controller: _textEditingControllerMinD,
                                      inputFormatters: [CurrencyTextInputFormatter(
                                        locale: 'ko_KR',
                                        decimalDigits: 0,
                                        symbol: '',
                                      )],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: '최소',
                                        labelText: '최소',
                                        hintStyle: TextStyle(
                                          color: Theme.of(context).colorScheme.outline,
                                          letterSpacing: 1.0,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        contentPadding: EdgeInsets.all(10),

                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).colorScheme.onBackground,
                                          ),
                                          //                           borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).colorScheme.outlineVariant,
                                          ),
                                          //                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                      ),
                                    )
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 85,
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: CupertinoPicker(
                                    itemExtent: 40,
                                    diameterRatio: 5,
                                    offAxisFraction: -1.0,
                                    scrollController: FixedExtentScrollController(initialItem: 0),
                                    squeeze: 1.0,
                                    onSelectedItemChanged: (index) {
                                      if(index == 0) {
                                        _textEditingControllerMinD.text = f.format(controller.minD.value);
                                        _textEditingControllerMaxD.text = f.format(controller.maxD.value);
                                        controller.minDeposit(controller.minD.value.toInt());
                                        controller.maxDeposit(controller.maxD.value.toInt());
                                      } else {
                                        _textEditingControllerMinD.text = f.format(((index) * 500 - 500));
                                        _textEditingControllerMaxD.text = f.format(((index + 1) * 500));
                                        controller.minDeposit(((index) * 500 -500));
                                        controller.maxDeposit(((index + 1) * 500));
                                      }
                                    },
                                    children: _listD,
                                  ),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    child: TextField(
                                      textAlign: TextAlign.right ,
                                      controller: _textEditingControllerMaxD,
                                      key: ValueKey(1),
                                      inputFormatters: [CurrencyTextInputFormatter(
                                        locale: 'ko_KR',
                                        decimalDigits: 0,
                                        symbol: '',
                                      )],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: '최대',
                                        labelText: '최대',
                                        hintStyle: TextStyle(
                                          color: Theme.of(context).colorScheme.outline,
                                          letterSpacing: 1.0,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).colorScheme.onBackground,
                                          ),
                                          //              borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).colorScheme.outlineVariant,
                                          ),
                                          //             borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 25,),
                        Text(
                            '월세',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextField(
                                  textAlign: TextAlign.right ,
                                  controller: _textEditingControllerMinM,
                                  inputFormatters: [CurrencyTextInputFormatter(
                                    locale: 'ko_KR',
                                    decimalDigits: 0,
                                    symbol: '',
                                  )],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '최소',
                                    labelText: '최소',
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.outline,
                                      letterSpacing: 1.0,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    contentPadding: EdgeInsets.all(10),

                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                      //                           borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.outlineVariant,
                                      ),
                                      //                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                )
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 90,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CupertinoPicker(
                                itemExtent: 40,
                                diameterRatio: 5,
                                offAxisFraction: -1.0,
                                scrollController: FixedExtentScrollController(initialItem: 0),
                                squeeze: 1.0,
                                onSelectedItemChanged: (index) {
                                  if(index == 0) {
                                    _textEditingControllerMinM.text = f.format(controller.minM.value);
                                    _textEditingControllerMaxM.text = f.format(controller.maxM.value);
                                    controller.minMonthly(controller.minM.value.toInt());
                                    controller.maxMonthly(controller.maxM.value.toInt());
                                  } else {
                                    _textEditingControllerMinM.text = f.format(((index) * 10 - 10));
                                    _textEditingControllerMaxM.text = f.format(((index + 1) * 10));
                                    controller.minMonthly(((index) * 10 -10));
                                    controller.maxMonthly(((index + 1) * 10));
                                  }
                                },
                                children: _listM,
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextField(
                                  textAlign: TextAlign.right ,
                                  controller: _textEditingControllerMaxM,
                                  key: ValueKey(1),
                                  inputFormatters: [CurrencyTextInputFormatter(
                                    locale: 'ko_KR',
                                    decimalDigits: 0,
                                    symbol: '',
                                  )],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '최대',
                                    labelText: '최대',
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.outline,
                                      letterSpacing: 1.0,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                      //              borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.outlineVariant,
                                      ),
                                      //             borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                    ]
                  ),
                ),
              SizedBox(height: 25,),
              Container(
                height: 140,
                child: Column(
                  children: [
                    Text(
                        '평수',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextField(
                              textAlign: TextAlign.right ,
                              controller: _textEditingControllerMinSize,
                              inputFormatters: [CurrencyTextInputFormatter(
                                locale: 'ko_KR',
                                decimalDigits: 0,
                                symbol: '',
                              )],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '최소',
                                labelText: '최소',
                                hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  letterSpacing: 1.0,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: EdgeInsets.all(10),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.onBackground,
                                  ),
                                  //                           borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.outlineVariant,
                                  ),
                                  //                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                            )
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 80,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: CupertinoPicker(
                            itemExtent: 40,
                            diameterRatio: 5,
                            offAxisFraction: -1.0,
                            scrollController: FixedExtentScrollController(initialItem: 0),
                            squeeze: 1.0,
                            onSelectedItemChanged: (index) {
                              if(index == 0) {
                                _textEditingControllerMinSize.text = f.format((controller.minZ.value.toInt() * 0.3025).toInt());
                                _textEditingControllerMaxSize.text = f.format((controller.maxZ.value.toInt() * 0.3025).toInt());
                                controller.minSize(controller.minZ.value.toInt());
                                controller.maxSize(controller.maxZ.value.toInt());
                              } else {
                                _textEditingControllerMinSize.text = f.format(((index) * 5 - 5));
                                _textEditingControllerMaxSize.text = f.format(((index + 1) * 5));
                                controller.minSize(((((index) * 5) -5) * 3.3057).toInt());
                                controller.maxSize((((index + 1) * 5) * 3.3057).toInt());
                              }
                            },
                            children: _listSize,
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: TextField(
                              textAlign: TextAlign.right ,
                              controller: _textEditingControllerMaxSize,
                              key: ValueKey(1),
                              inputFormatters: [CurrencyTextInputFormatter(
                                locale: 'ko_KR',
                                decimalDigits: 0,
                                symbol: '',
                              )],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '최대',
                                labelText: '최대',
                                hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  letterSpacing: 1.0,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.onBackground,
                                  ),
                                  //              borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.outlineVariant,
                                  ),
                                  //             borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Column(
              //   children : [
              //     Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
              //       return Text(
              //         '최대: ${(controller.maxSize.value*0.3025).round()}',
              //       );
              //     }),
              //     RangeSlider(
              //       max: controller.maxZ.value.toDouble(),
              //       min: controller.minZ.value.toDouble(),
              //       values: values5,
              //       divisions: 50,
              //       onChanged: onPickerChanged5,
              //       labels: RangeLabels(
              //         (values5.start*0.3025).round().toString(),
              //         (values5.end*0.3025).round().toString(),
              //       ),
              //     ),
              //     Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
              //       return Text(
              //         '최소: ${(controller.minSize.value*0.3025).round()}',
              //       );
              //     }),
              //   ],
              // ),
              SizedBox(height: 25,),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                  onPressed: () async {

                    Get.to(() => RegidentialListViewScreen());
                  },
                  child: const Text(
                    '선택 완료',
                    style: TextStyle(fontSize: 18),
                  ),
              ),
            ],
          ),
    ),
      ),
    );
  }

  void toggleSelect(int index) async {
      setState(() {
        for(int i = 0; i < isSelected.length; i++) {
          if(i == index) {
            isSelected[i] = true;

            if(i == 1) controller.selectGubun('전세');
            else if(i == 2) controller.selectGubun('월세');
            else controller.selectGubun('매매');

          } else {
            isSelected[i] = false;
          }
        }
        _controller.jumpToPage(index);
      }
    );
  }

  void onPickerChanged(RangeValues value) {
    setState(() {
      values = value;
      controller.minPrice(values.start.round());
      controller.maxPrice(values.end.round());
    });
  }
  void onPickerChanged2(RangeValues value) {
    setState(() {
      values2 = value;
      controller.minJeonse(values2.start.round());
      controller.maxJeonse(values2.end.round());
    });
  }
  void onPickerChanged3(RangeValues value) {
    setState(() {
      values3 = value;
      controller.minDeposit(values3.start.round());
      controller.maxDeposit(values3.end.round());
    });
  }
  void onPickerChanged4(RangeValues value) {
    setState(() {
      values4 = value;
      controller.minMonthly(values4.start.round());
      controller.maxMonthly(values4.end.round());
    });
  }

  void onPickerChanged5(RangeValues value) {
    setState(() {
      values5 = value;
      controller.minSize(values5.start.round());
      controller.maxSize(values5.end.round());
    });
  }

  void   initRangeVlues() {
    values = RangeValues(controller.minS.value.toDouble(), controller.maxS.value.toDouble());
    values2 = RangeValues(controller.minJ.value.toDouble(), controller.maxJ.value.toDouble());
    values3 = RangeValues(controller.minD.value.toDouble(), controller.maxD.value.toDouble());
    values4 = RangeValues(controller.minM.value.toDouble(), controller.maxM.value.toDouble());
    values5 = RangeValues(controller.minZ.value.toDouble(), controller.maxZ.value.toDouble());
    controller.selectGubun('매매');
    controller.roomCount('0');
    _textEditingControllerMin.text = f.format(controller.minS.value).toString();
    _textEditingControllerMax.text = f.format(controller.maxS.value).toString();
    _textEditingControllerMinJ.text = f.format(controller.minJ.value).toString();
    _textEditingControllerMaxJ.text = f.format(controller.maxJ.value).toString();
    _textEditingControllerMinD.text = f.format(controller.minD.value).toString();
    _textEditingControllerMaxD.text = f.format(controller.maxD.value).toString();
    _textEditingControllerMinM.text = f.format(controller.minM.value).toString();
    _textEditingControllerMaxM.text = f.format(controller.maxM.value).toString();
    _textEditingControllerMinSize.text = f.format(controller.minZ.value).toString();
    _textEditingControllerMaxSize.text = f.format(controller.maxZ.value).toString();
    _list.addAll(List.generate((controller.maxS.value.toInt()/5000).toInt(), (i) => ((i + 1) * 5000)).map((e) => Text('${f.format(e)}만원')).toList());
    _listJ.addAll(List.generate((controller.maxJ.value.toInt()/5000).toInt(), (i) => ((i + 1) * 5000)).map((e) => Text('${f.format(e)}만원')).toList());
    _listD.addAll(List.generate((controller.maxD.value.toInt()/500).toInt(), (i) => ((i + 1) * 500)).map((e) => Text('${f.format(e)}만원')).toList());
    _listM.addAll(List.generate((controller.maxM.value.toInt()/10).toInt(), (i) => ((i + 1) * 10)).map((e) => Text('${f.format(e)}만원')).toList());
    _listSize.addAll(List.generate(((controller.maxZ.value.toInt()*0.3025)/5).toInt(), (i) => ((i + 1) * 5)).map((e) => Text('${f.format(e)}평')).toList());
  }
}
