import 'package:barcode_generator/model/persistence/barcode_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'barcode_data.g.dart';

@JsonSerializable()
class BarcodeData {
  List<BarcodeItem> barcodeItems;

  BarcodeData(this.barcodeItems);

  factory BarcodeData.fromJson(Map<String, dynamic> json) => _$BarcodeDataFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeDataToJson(this);
}
