import 'package:flutter/material.dart';

class CommModel extends ChangeNotifier {
  List<Comm> _commList = [];
  List<Comm> get commList => _commList;

  void addComm(Comm comm) {
    _commList.add(comm);
    notifyListeners();
  }

  void removeComm(Comm comm) {
    _commList.remove(comm);
    notifyListeners();
  }
}


class Comm {
  final int id;
  final String date;
  final String type;
  final String status;
  final String division;
  final String addr1;
  final String addr2;
  final int salesprice;
  final int deposit;
  final int monthly;
  final int entitleprice;
  final int adminprice;
  final int size;
  final String floor;
  final String parking;
  final bool eliv;
  final String etc;
  final String tel;
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String img5;
  final String img6;

  Comm({
    required this.id,
    required this.date,
    required this.type,
    required this.status,
    required this.division,
    required this.addr1,
    required this.addr2,
    required this.salesprice,
    required this.deposit,
    required this.monthly,
    required this.entitleprice,
    required this.adminprice,
    required this.etc,
    required this.size,
    required this.floor,
    required this.parking,
    required this.eliv,
    required this.tel,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.img6,
  });

  factory Comm.fromJson(Map<String, dynamic> json) {
    return Comm(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      status: json['status'],
      division: json['division'],
      addr1: json['addr1'],
      addr2: json['addr2'],
      salesprice: json['salesprice'],
      deposit: json['deposit'],
      monthly: json['monthly'],
      entitleprice: json['entitleprice'],
      adminprice: json['adminprice'],
      etc: json['etc'],
      size: json['size'],
      floor: json['floor'],
      parking: json['parking'],
      eliv: json['eliv'],
      tel: json['tel'],
      img1: json['img1'],
      img2: json['img2'],
      img3: json['img3'],
      img4: json['img4'],
      img5: json['img5'],
      img6: json['img6'],
    );
  }
}