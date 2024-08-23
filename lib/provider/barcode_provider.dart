import 'dart:convert';

import 'package:barcode_generator/model/persistence/barcode_data.dart';
import 'package:barcode_generator/model/persistence/barcode_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodeProvider extends ChangeNotifier {
  SharedPreferences? _sharedPreferences;
  List<BarcodeItem> barcodeItems = [];

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    load();
  }

  Future<void> load() async {
    final json = _sharedPreferences?.getString('barcode');
    if (json != null) {
      final barcodeData = BarcodeData.fromJson(jsonDecode(json));
      barcodeItems = barcodeData.barcodeItems;
    }

    if (barcodeItems.isEmpty) {
      barcodeItems.add(BarcodeItem(BarcodeType.code39, 'NEW', "123456789"));
    }

    notifyListeners();
  }

  Future<void> add(BarcodeItem item) async {
    barcodeItems.add(item);

    await save();

    notifyListeners();
  }

  Future<void> update(int index, BarcodeItem item) async {
    barcodeItems[index] = item;

    await save();

    notifyListeners();
  }

  Future<void> save() async {
    await _sharedPreferences?.setString('barcode', jsonEncode(BarcodeData(barcodeItems).toJson()));
  }

  getByIndex(int index) {}
}
