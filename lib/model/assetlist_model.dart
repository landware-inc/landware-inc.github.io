import 'dart:ffi';

import 'package:flutter/material.dart';

class AssetListModel extends ChangeNotifier {
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
  final Int id;
  final String callname;
  final String sizetype;
  final String direction;
  final String floor;
  final Int price;
  final Int room;
  final Int bath;
  final String indate;

  Asset({
    required this.id,
    required this.callname,
    required this.sizetype,
    required this.direction,
    required this.floor,
    required this.price,
    required this.room,
    required this.bath,
    required this.indate,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      callname: json['callname'],
      sizetype: json['sizetype'],
      direction: json['direction'],
      floor: json['floor'],
      price: json['price'],
      room: json['room'],
      bath: json['bath'],
      indate: json['indate'],
    );
  }
