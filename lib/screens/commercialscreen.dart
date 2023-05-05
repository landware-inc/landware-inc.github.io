import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_login_test/screens/component/bottom_menu.dart';
import 'package:kakao_login_test/screens/regidentiallistview.dart';
import 'package:intl/intl.dart';
import '../status/controller.dart';
import 'commerciallistview.dart';

class CommercialScreen extends StatefulWidget {
  const CommercialScreen({Key? key}) : super(key: key);

  @override
  State<CommercialScreen> createState() => _CommercialScreenState();
}

class _CommercialScreenState extends State<CommercialScreen> {
  final _authentication = FirebaseAuth.instance;
  final controller = Get.put(Controller());
  User? loggedInUser;
  String? userName;
  String result = '';
  List<bool> isSelected = [true, false];
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
  var f = NumberFormat('###,###,###,###');
  List<Widget> _list = [Text('모든가격')];
  List<Widget> _listJ = [Text('모든가격')];
  List<Widget> _listD = [Text('모든가격')];
  List<Widget> _listM = [Text('모든가격')];
  List<Widget> _listSize = [Text('모든평수')];


  @override
  void initState() {
    // TODO: implement initState
    initRangeVlues(0);
    super.initState();

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('상업용 검색 조건'),
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

      bottomNavigationBar: BottomMenuBar(),

      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                hintText: '동명/상권명 (없으면 모든 동/상권)',
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



            Column(
              children: [
                ToggleButtons(
                  children: <Widget>[
                    Container(width: (MediaQuery.of(context).size.width - 66)/2, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.domain,size: 20.0,color: Colors.red,),new SizedBox(width: 4.0,), new Text("매매",style: TextStyle(color: Colors.red,fontSize: 20),)],)),
//                    Container(width: (MediaQuery.of(context).size.width - 36)/3, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.add_business,size: 20.0,color: Colors.yellow[800],),new SizedBox(width: 4.0,), new Text("전세",style: TextStyle(color: Colors.yellow[800],fontSize: 20))],)),
                    Container(width: (MediaQuery.of(context).size.width - 66)/2, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.meeting_room,size: 20.0,color: Colors.blue,),new SizedBox(width: 4.0,), new Text("월세",style: TextStyle(color: Colors.blue,fontSize: 20))],)),
                  ],
                  isSelected: isSelected,
                  onPressed: toggleSelect,
                ),
              ],
            ),


            Container(
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: PageView(
                  pageSnapping: true,
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        if (i == index) {
                          isSelected[i] = true;
                        } else {
                          isSelected[i] = false;
                        }
                      }
                      initRangeVlues(index);
                    });
                  },
                  children: [
                    Column(
                        children: [
                          SizedBox(height: 10,),
                          Text(
                            '매매 가격',
                            style: TextStyle(
                              fontSize: 17,
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
                                      contentPadding: EdgeInsets.all(5),

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
                                height: 65,
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: CupertinoPicker(
                                  itemExtent: 40,
                                  diameterRatio: 5,
                                  offAxisFraction: -1.0,
                                  scrollController: FixedExtentScrollController(initialItem: 0),
                                  squeeze: 1.0,
                                  onSelectedItemChanged: (index) {
                                    if(index == 0) {
                                      _textEditingControllerMin.text = f.format(controller.minS.value/10000);
                                      _textEditingControllerMax.text = f.format(controller.maxS.value/10000);
                                      controller.minPrice(controller.minS.value.toInt());
                                      controller.maxPrice(controller.maxS.value.toInt());
                                    } else if(index == 1) {
                                      _textEditingControllerMin.text = '0';
                                      _textEditingControllerMax.text = f.format(((index * 5000)*1.5).round());
                                      controller.minPrice(1*10000);
                                      controller.maxPrice(((index * 5000)*1.5).round()*10000);
                                    } else {
                                      _textEditingControllerMin.text = f.format((((index) * 5000)*0.7).round());
                                      _textEditingControllerMax.text = f.format((((index) * 5000)*1.3).round());
                                      controller.minPrice(((index * 5000)*0.7).round()*10000);
                                      controller.maxPrice(((index * 5000)*1.3).round()*10000);
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
                                      contentPadding: EdgeInsets.all(5),
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
                    Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 10,),
                            Text(
                              '보증금',
                              style: TextStyle(
                                fontSize: 17,
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
                                        contentPadding: EdgeInsets.all(5),

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
                                  height: 65,
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: CupertinoPicker(
                                    itemExtent: 40,
                                    diameterRatio: 5,
                                    offAxisFraction: -1.0,
                                    scrollController: FixedExtentScrollController(initialItem: 0),
                                    squeeze: 1.0,
                                    onSelectedItemChanged: (index) {
                                      if(index == 0) {
                                        _textEditingControllerMinD.text = f.format(controller.minD.value/10000);
                                        _textEditingControllerMaxD.text = f.format(controller.maxD.value/10000);
                                        controller.minDeposit(controller.minD.value.toInt());
                                        controller.maxDeposit(controller.maxD.value.toInt());
                                      } else if(index == 1) {
                                        _textEditingControllerMinD.text = '0';
                                        _textEditingControllerMaxD.text = f.format(((index * 500)*1.5).round());
                                        controller.minDeposit(1);
                                        controller.maxDeposit(((index * 500 * 10000)*1.5).round());
                                      } else {
                                        _textEditingControllerMinD.text = f.format((((index) * 500)*0.7).round());
                                        _textEditingControllerMaxD.text = f.format((((index) * 500)*1.3).round());
                                        controller.minDeposit(((index * 500 * 10000)*0.7).round());
                                        controller.maxDeposit(((index * 500 * 10000)*1.3).round());
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
                                        contentPadding: EdgeInsets.all(5),
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
                        SizedBox(height: 20,),
                        Text(
                          '월세',
                          style: TextStyle(
                            fontSize: 17,
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
                                    contentPadding: EdgeInsets.all(5),

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
                              height: 65,
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
                                    controller.minMonthly(((index * 10000) * 10 -10));
                                    controller.maxMonthly((((index + 1) * 10000) * 10));
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
                                    contentPadding: EdgeInsets.all(5),
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
                  ],
              ),
            ),

            Container(
//                height: 140,
              child: Column(
                children: [
                  Text(
                    '평수',
                    style: TextStyle(
                      fontSize: 17,
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
                              contentPadding: EdgeInsets.all(5),

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
                        height: 65,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: CupertinoPicker(
                          itemExtent: 40,
                          diameterRatio: 5,
                          offAxisFraction: -1.0,
                          scrollController: FixedExtentScrollController(initialItem: 0),
                          squeeze: 1.0,
                          onSelectedItemChanged: (index) {
                            if(index == 0) {
                              _textEditingControllerMinSize.text = f.format(controller.minZ.value);
                              _textEditingControllerMaxSize.text = f.format(controller.maxZ.value);
                              controller.minSize(controller.minZ.value.toInt());
                              controller.maxSize(controller.maxZ.value.toInt());
                            } else if(index == 1) {
                              _textEditingControllerMinSize.text = '0';
                              _textEditingControllerMaxSize.text = f.format(((index * 5)*1.5).round());
                              controller.minSize(1);
                              controller.maxSize(((index * 5)*1.5).round());
                            } else {
                              _textEditingControllerMinSize.text = f.format((((index) * 5)*0.7).round());
                              _textEditingControllerMaxSize.text = f.format((((index) * 5)*1.3).round());
                              controller.minSize(((index * 5)*0.7).round());
                              controller.maxSize(((index * 5)*1.3).round());
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
                              contentPadding: EdgeInsets.all(5),
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

            SizedBox(height: 20,),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () async {
                Get.to(() => CommercialListViewScreen());
              },
              child: const Text(
                '선택 완료',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleSelect(int index) async {
    setState(() {
      for(int i = 0; i < isSelected.length; i++) {
        if(i == index) {
          isSelected[i] = true;

          if(i == 1) controller.selectGubun('월세');
          else controller.selectGubun('매매');

        } else {
          isSelected[i] = false;
        }
      }
      initRangeVlues(index);
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
      controller.minEntitle(values2.start.round());
      controller.maxEntitle(values2.end.round());
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

  void   initRangeVlues(int index) {
    values = RangeValues(controller.minS.value.toDouble(), controller.maxS.value.toDouble());
    values2 = RangeValues(controller.minE.value.toDouble(), controller.maxE.value.toDouble());
    values3 = RangeValues(controller.minD.value.toDouble(), controller.maxD.value.toDouble());
    values4 = RangeValues(controller.minM.value.toDouble(), controller.maxM.value.toDouble());
    values5 = RangeValues(controller.minZ.value.toDouble(), controller.maxZ.value.toDouble());
    _textEditingControllerMinSize.text = f.format(controller.minZ.value).toString();
    _textEditingControllerMaxSize.text = f.format(controller.maxZ.value).toString();
    _textEditingControllerMin.text = f.format(controller.minS.value/10000).toString();
    _textEditingControllerMax.text = f.format(controller.maxS.value/10000).toString();
    _textEditingControllerMinD.text = f.format(controller.minD.value/10000).toString();
    _textEditingControllerMaxD.text = f.format(controller.maxD.value/10000).toString();
    _textEditingControllerMinM.text = f.format(controller.minM.value/10000).toString();
    _textEditingControllerMaxM.text = f.format(controller.maxM.value/10000).toString();
    controller.minPrice(controller.minS.value.toInt());
    controller.maxPrice(controller.maxS.value.toInt());
    controller.minDeposit(controller.minD.value.toInt());
    controller.maxDeposit(controller.maxD.value.toInt());
    controller.minMonthly(controller.minM.value.toInt());
    controller.maxMonthly(controller.maxM.value.toInt());
    controller.minSize(controller.minZ.value.toInt());
    controller.maxSize(controller.maxZ.value.toInt());
    if(index == 0) controller.selectGubun('매매');
    if(index == 1) controller.selectGubun('월세');
    controller.selectCallname('');
    _list.addAll(List.generate(((controller.maxS.value.toInt()/10000)/5000).toInt(), (i) => ((i + 1) * 5000)).map((e) => Text('${f.format(e)}만원')).toList());
//    _listJ.addAll(List.generate((controller.maxJ.value.toInt()/5000).toInt(), (i) => ((i + 1) * 5000)).map((e) => Text('${f.format(e)}만원')).toList());
    _listD.addAll(List.generate(((controller.maxD.value.toInt()/10000)/500).toInt(), (i) => ((i + 1) * 500)).map((e) => Text('${f.format(e)}만원')).toList());
    _listM.addAll(List.generate(((controller.maxM.value.toInt()/10000)/10).toInt(), (i) => ((i + 1) * 10)).map((e) => Text('${f.format(e)}만원')).toList());
    _listSize.addAll(List.generate(((controller.maxZ.value.toInt())/5).toInt(), (i) => ((i + 1) * 5)).map((e) => Text('${f.format(e)}평')).toList());
  }
}
