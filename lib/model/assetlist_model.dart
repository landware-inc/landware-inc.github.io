import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'assetlist_model.g.dart';

class AssetListModel extends ChangeNotifier {
  List<AssetList> _assetList = [];
  List<AssetList> get assetList => _assetList;

  void addAsset(AssetList assetlist) {
    _assetList.add(assetlist);
    notifyListeners();
  }

  void removeAsset(AssetList assetlist) {
    _assetList.remove(assetlist);
    notifyListeners();
  }
}

//@JsonSerializable()
class AssetList {
  final Int id;
  final String callname;
  final String sizetype;
  final String direction;
  final String floor;
  final Int price;
  final Int room;
  final Int bath;
  final String indate;

  AssetList({
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

   factory AssetList.fromJson(Map<String, dynamic> json) {
     return AssetList(
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
}
