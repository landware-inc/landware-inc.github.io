import 'package:flutter/material.dart';
import 'package:get/get.dart';


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



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('부동산 물건 등록'),
      // ),

//      bottomNavigationBar: BottomMenuBar(),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('부동산 물건 등록'),
            pinned: true,
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
                      Container(width: (MediaQuery.of(context).size.width - 36)/3.0, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.domain,size: 20.0,color: Colors.red,),new SizedBox(width: 4.0,), new Text("주거용",style: TextStyle(color: Colors.red,fontSize: 20),)],)),
                      Container(width: (MediaQuery.of(context).size.width - 36)/3.0, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.add_business,size: 20.0,color: Colors.yellow[800],),new SizedBox(width: 4.0,), new Text("사업용",style: TextStyle(color: Colors.yellow[800],fontSize: 20))],)),
                      Container(width: (MediaQuery.of(context).size.width - 36)/3.0, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new Icon(Icons.meeting_room,size: 20.0,color: Colors.blue,),new SizedBox(width: 4.0,), new Text("건물/토지",style: TextStyle(color: Colors.blue,fontSize: 20))],)),
                    ],
                    isSelected: isSelected,
                    onPressed: toggleSelect,
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
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
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 13.0)),
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
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5,),
          TextFormField(
            decoration: InputDecoration(
              labelText: '물건명',
              hintText: '단지명/건물명칭 등',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.red[50],
            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            decoration: InputDecoration(
              labelText: '주소',
              hintText: '주소를 입력하세요',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.red[50],
            ),
          ),
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
                value : _isSales,
                onChanged: (value) {
                  setState(() {
                    _isSales = value!;
                  });
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
                value : _isJeonse,
                onChanged: (value) {
                  setState(() {
                    _isJeonse = value!;
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
                value : _isMonthly,
                onChanged: (value) {
                  setState(() {
                    _isMonthly = value!;
                  });
                },
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
                  decoration: InputDecoration(
                    labelText: '현임차보증금',
                    hintText: '현재 임대중이라면 임차 보증금을 적어 주세요',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
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
                  decoration: InputDecoration(
                    labelText: '전세가격',
                    hintText: '전세 예정 금액을 적어 주세요',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.red[50],
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '대출금액',
                    hintText: '임대 예정물건에 대출이 있으면 그 금액을 적어 주세요',
                    border: OutlineInputBorder(),
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
                  decoration: InputDecoration(
                    labelText: '임차보증금',
                    hintText: '예정 임차 보증금액을 적어 주세요',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.red[50],
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '월차임',
                    hintText: '예정 월 차임을 적어 주세요',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.red[50],
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '대출금액',
                    hintText: '임대 예정물건에 대출이 있으면 그 금액을 적어 주세요',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
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
