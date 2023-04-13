import 'package:flutter/material.dart';

class AssetModel extends ChangeNotifier {
  List<Asset> _assetList = [];
  List<Asset> get assetList => _assetList;

  void addAsset(Asset asset) {
    _assetList.add(asset);
    notifyListeners();
  }

  void removeAsset(Asset asset) {
    _assetList.remove(asset);
    notifyListeners();
  }
}

class Asset {
  final int id;
  final String date;
  final String type;
  final String status;
  final String addr;
  final String size;
  final String oneroom;
  final String rebuild;
  final int jeonse;
  final int deposit;
  final int monthly;
  final int salesprice;
  final int currentdeposit;
  final int currentmonthly;
  final double firstprice;
  final int premium;
  final int realprice;
  final String phone1;
  final String descrioption;
  final String callname;
  final String sizetype;
  final String direction;
  final String floor;
  final int price;
  final int room;
  final int bath;
  final String indate;
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String img5;
  final String img6;

  Asset({
    required this.id,
    required this.date,
    required this.type,
    required this.status,
    required this.addr,
    required this.size,
    required this.oneroom,
    required this.rebuild,
    required this.jeonse,
    required this.deposit,
    required this.monthly,
    required this.salesprice,
    required this.currentdeposit,
    required this.currentmonthly,
    required this.firstprice,
    required this.premium,
    required this.realprice,
    required this.phone1,
    required this.descrioption,
    required this.callname,
    required this.sizetype,
    required this.direction,
    required this.floor,
    required this.price,
    required this.room,
    required this.bath,
    required this.indate,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.img6,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      status: json['status'],
      addr: json['addr'],
      size: json['size'],
      oneroom: json['oneroom'],
      rebuild: json['rebuild'],
      jeonse: json['jeonse'],
      deposit: json['deposit'],
      monthly: json['monthly'],
      salesprice: json['salesprice'],
      currentdeposit: json['currentdeposit'],
      currentmonthly: json['currentmonthly'],
      firstprice: json['firstprice'],
      premium: json['premium'],
      realprice: json['realprice'],
      phone1: json['phone1'],
      descrioption: json['descrioption'],
      callname: json['callname'],
      sizetype: json['sizetype'],
      direction: json['direction'],
      floor: json['floor'],
      price: json['price'],
      room: json['room'],
      bath: json['bath'],
      indate: json['indate'],
      img1: json['img1'],
      img2: json['img2'],
      img3: json['img3'],
      img4: json['img4'],
      img5: json['img5'],
      img6: json['img6'],
    );
  }
}

