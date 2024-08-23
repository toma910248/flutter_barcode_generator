// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeData _$BarcodeDataFromJson(Map<String, dynamic> json) => BarcodeData(
      (json['barcodeItems'] as List<dynamic>)
          .map((e) => BarcodeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarcodeDataToJson(BarcodeData instance) =>
    <String, dynamic>{
      'barcodeItems': instance.barcodeItems,
    };
