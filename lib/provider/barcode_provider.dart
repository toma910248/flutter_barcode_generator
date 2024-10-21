import 'dart:convert';

import 'package:barcode_generator/model/persistence/barcode_data.dart';
import 'package:barcode_generator/model/persistence/barcode_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodeProvider extends ChangeNotifier {
  SharedPreferences? _sharedPreferences;
  List<BarcodeItem> _barcodeItems = [];

  BarcodeProvider() {
    _init();
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    load();

    if (_barcodeItems.isEmpty) {
      _barcodeItems.add(BarcodeItem(BarcodeType.code39, 'NEW', "123456789"));
      notifyListeners();
    }
  }

  List<BarcodeItem> getAll() => List.unmodifiable(_barcodeItems);

  int getLength() => _barcodeItems.length;

  BarcodeItem get(int index) => _barcodeItems[index];

  Future<void> add(BarcodeItem item) async {
    _barcodeItems.add(item);

    await save();

    notifyListeners();
  }

  Future<void> remove(int index) async {
    _barcodeItems.removeAt(index);

    await save();

    notifyListeners();
  }

  Future<void> update(int index, BarcodeItem item) async {
    _barcodeItems[index] = item;

    await save();

    notifyListeners();
  }

  Future<void> load() async {
    final json = _sharedPreferences?.getString('barcode');
    if (json != null) {
      final barcodeData = BarcodeData.fromJson(jsonDecode(json));
      _barcodeItems = barcodeData.barcodeItems;
    }
    notifyListeners();
  }

  Future<void> save() async {
    await _sharedPreferences?.setString('barcode', jsonEncode(BarcodeData(_barcodeItems).toJson()));
  }
}
