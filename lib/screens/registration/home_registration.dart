abstract class _HomeRegistrationView {

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
  controller: _AddressDetailController,
  validator: (value) {
  if(value!.isEmpty) {
  return '필수 입력 항목입니다.';
  }
  return null;
  },
  onSaved: (value) {
  formData['addressDetail'] = value!;
  },
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
  width: 58,
  child: TextFormField(
  controller: _FloorController,
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
  controller: _TotalFloorController,
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
  controller: _SizeController,
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
  controller: _TypeController,
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
  controller: _RoomController,
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
  controller: _BathController,
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
  formData['Type'] = value!;
  },
  onSaved: (value) {
  formData['Type'] = value!;
  },
  value: '아파트',
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

  items: ['남','남서','남동','서','동','북서','북동','북'].map((String value) {
  return DropdownMenuItem(
  value: value,
  child: Text(value),
  );
  }).toList(),
  onChanged: (value) {
  _DirectionController = value.toString();
  },
  onSaved: (value) {
  formData['direction'] = value!;
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
  //         controller: _InDateTypeController,
  value: '협의',
  onSaved: (value) {
  formData['inDateType'] = value!;
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
  canvasHeight = canvasHeight + 250;
  } else {
  canvasHeight = canvasHeight - 250;
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
  canvasHeight = canvasHeight + 170;
  } else {
  canvasHeight = canvasHeight - 170;
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
  controller: _Name1Controller,
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
  ),
  ),
  SizedBox(width: 10,),
  Container(
  width: MediaQuery.of(context).size.width - 150,
  child : TextFormField(
  controller: _Tel1Controller,
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
  controller: _Name2Controller,
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
  controller: _Tel2Controller,
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
  controller: _SalesController,
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
  ),
  SizedBox(height: 10,),
  TextFormField(
  controller: _DepositNowController,
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
  controller: _MonthlyNowController,
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
  controller: _JeonseController,
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
  controller: _DepositController,
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
  controller: _MonthlyController,
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
  controller: _LoanController,
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
  controller: _DescController,
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
  ],
  ),
  ),
  );

}