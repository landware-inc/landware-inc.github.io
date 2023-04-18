

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_login_test/screens/listview.dart';

import '../status/controller.dart';

class RoungeScreen extends StatefulWidget {
  const RoungeScreen({Key? key}) : super(key: key);

  @override
  State<RoungeScreen> createState() => _RoungeScreenState();
}

class _RoungeScreenState extends State<RoungeScreen> {
  final _authentication = FirebaseAuth.instance;
  final controller = Get.put(Controller());
  User? loggedInUser;
  String? userName;
  String result = '';
  List<bool> isSelected = [false, true, false];
  RangeValues values =  RangeValues(15000, 150000);
  RangeValues values2 =  RangeValues(5000, 50000);
  RangeValues values3 =  RangeValues(0, 45000);
  RangeValues values4 =  RangeValues(0, 150);
  double pickerValue = 0;
  PageController _controller = PageController(initialPage: 0, keepPage: false);



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
        title: const Text('Rounge'),
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('ID : ${controller.userId.value}'),
            Text('Email : ${controller.userEmail.value}'),
            Text('Name : ${controller.userName.value}'),
            Text('Rounge'),
            GetBuilder<Controller>(
              init: Controller(), // init을 설정하지 않을 시 에러 발생
              builder: (_) => Text(
                'clicks: ${_.count1}',
              ),
            ),

            Column(
              children: [
                ToggleButtons(
                    children: [
                      const Text('매매'),
                      const Text('전세'),
                      const Text('월세'),
                    ],
                    isSelected: isSelected,
                    onPressed: toggleSelect,
                ),
              ],
            ),

            TextButton(
                onPressed: controller.increment1,
                child: const Text('increment1')),
            GetX<Controller>( // init을 통해 Controller를 등록할 수 있지만 여기선 Get.put을 사용
              builder: (_) => Text(
                '최대: ${_.maxPrice.value}',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: PageView(
                controller: _controller,
                children: [
                  RangeSlider(
                      max: controller.maxS.value.toDouble(),
                      values: values,
                      divisions: 50,
                      onChanged: onPickerChanged,
                      labels: RangeLabels(
                        values.start.round().toString(),
                          values.end.round().toString()
                      ),
                    ),
                  RangeSlider(
                    max: controller.maxJ.value.toDouble(),
                    min: 0,
                    values: values2,
                    divisions: 50,
                    onChanged: onPickerChanged2,
                    labels: RangeLabels(
                        values2.start.round().toString(),
                        values2.end.round().toString()
                    ),
                  ),
                  Column(
                    children: [
                      RangeSlider(
                        max: controller.maxD.value.toDouble(),
                        min: 0,
                        values: values3,
                        divisions: 50,
                        onChanged: onPickerChanged3,
                        labels: RangeLabels(
                            values3.start.round().toString(),
                            values3.end.round().toString()
                        ),
                      ),
                      RangeSlider(
                        max: controller.maxM.value.toDouble(),
                        min: 0,
                        values: values4,
                        divisions: 50,
                        onChanged: onPickerChanged4,
                        labels: RangeLabels(
                            values4.start.round().toString(),
                            values4.end.round().toString()
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),

            Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
              return Text(
                '최소: ${controller.minPrice.value}',
              );
            }),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
                onPressed: () async {
                  Get.to(() => ListViewScreen());
                },
                child: const Text('List Test 화면으로')
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

  void   initRangeVlues() {
    values = RangeValues(0, controller.maxS.value.toDouble());
    values2 = RangeValues(0, controller.maxJ.value.toDouble());
    values3 = RangeValues(0, controller.maxD.value.toDouble());
    values4 = RangeValues(0, controller.maxM.value.toDouble());
  }
}
