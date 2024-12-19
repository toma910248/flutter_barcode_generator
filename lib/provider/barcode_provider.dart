import 'dart:convert';

import 'package:barcode_generator/model/persistence/barcode_data.dart';
import 'package:barcode_generator/model/persistence/barcode_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shortcuts/flutter_shortcuts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodeProvider extends ChangeNotifier {
  final FlutterShortcuts _flutterShortcuts = FlutterShortcuts();
  SharedPreferences? _sharedPreferences;
  List<BarcodeItem> _barcodeItems = [];

  BarcodeProvider() {
    _init();
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    load();

    if (_barcodeItems.isEmpty) {
      _barcodeItems.add(BarcodeItem(barcodeType: BarcodeTypeEnum.code39, label: 'NEW', data: "123456789"));
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

    _updateShortcuts();
  }

  Future<void> remove(int index) async {
    _barcodeItems.removeAt(index);

    await save();

    notifyListeners();

    _updateShortcuts();
  }

  Future<void> update(int index, BarcodeItem item) async {
    _barcodeItems[index] = item;

    await save();

    notifyListeners();

    _updateShortcuts();
  }

  void _updateShortcuts() async {
    _flutterShortcuts.setShortcutItems(shortcutItems: _getShortcutItems());
  }

  List<ShortcutItem> _getShortcutItems() {
    return _barcodeItems.asMap().entries.map((e) => _getShortcutItem(e.key)).toList();
  }

  ShortcutItem _getShortcutItem(int index) {
    final item = _barcodeItems[index];
    final uri = Uri(queryParameters: {
      'id': item.id,
      'label': item.label,
      'barcodeType': item.barcodeType.value,
      'data': item.data,
    });

    return ShortcutItem(
      id: item.id,
      action: uri.toString(),
      shortLabel: item.label,
    );
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
