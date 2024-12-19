import 'package:barcode_widget/barcode_widget.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:random_string/random_string.dart';

part 'barcode_item.g.dart';

enum BarcodeTypeEnum {
  code39('CODE 39');

  const BarcodeTypeEnum(this.value);
  final String value;

  Barcode get getBarcode => switch (this) {
        code39 => Barcode.code39(),
      };
}

@JsonSerializable()
class BarcodeItem {
  final String id;

  BarcodeTypeEnum barcodeType;

  String data;

  String label;

  BarcodeItem({String? id, required this.barcodeType, required this.label, required this.data})
      : id = id ?? randomAlphaNumeric(10);

  factory BarcodeItem.fromJson(Map<String, dynamic> json) => _$BarcodeItemFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeItemToJson(this);
}
