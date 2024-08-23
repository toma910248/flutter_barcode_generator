import 'package:barcode_widget/barcode_widget.dart';
import 'package:json_annotation/json_annotation.dart';

part 'barcode_item.g.dart';

enum BarcodeType {
  code39('CODE 39');

  const BarcodeType(this.value);
  final String value;

  Barcode get getBarcode => switch (this) {
        code39 => Barcode.code39(),
      };
}

@JsonSerializable()
class BarcodeItem {
  BarcodeItem(this.barcodeType, this.label, this.data);

  BarcodeType barcodeType;

  String data;

  String label;

  factory BarcodeItem.fromJson(Map<String, dynamic> json) => _$BarcodeItemFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeItemToJson(this);
}
